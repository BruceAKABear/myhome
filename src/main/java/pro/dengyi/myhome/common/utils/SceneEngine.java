package pro.dengyi.myhome.common.utils;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.SceneActionDao;
import pro.dengyi.myhome.dao.SceneDao;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.automation.SceneAction;
import pro.dengyi.myhome.model.automation.SceneCondition;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;

import javax.script.Invocable;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/3 17:17
 * @description：条件引擎
 * @modified By：
 */
@Component
public class SceneEngine {

    @Autowired
    private Cache cache;
    @Autowired
    private DeviceDao deviceDao;
    @Autowired
    private DeviceLogDao deviceLogDao;
    @Autowired
    private SceneActionDao sceneActionDao;
    @Autowired
    private SceneDao sceneDao;

    /**
     *
     * @param applicationContext
     */
    public static void init(ApplicationContext applicationContext) {

    }


    /**
     * 触发场景逻辑
     *
     * @param triggerDeviceId 触发设备id
     * @param conditions      系统中条件集合
     * @param mqttClient      mqtt客户端
     */
    public void trigger(String triggerDeviceId, List<SceneCondition> conditions,
                        MqttClient mqttClient) {
        // 场景条件为空，不执行逻辑
        if (CollectionUtils.isEmpty(conditions)) {
            return;
        }
        //设备没在任何条件中，不执行逻辑
        if (!inCondition(triggerDeviceId, conditions)) {
            return;
        }
        //场景 条件分组
        Map<String, List<SceneCondition>> sceneGroups = conditionGroups(conditions);
        //执行逻辑
        startLogic(triggerDeviceId, sceneGroups, mqttClient);
    }


    /**
     * 判断给定条件集合中是否包含目标设备
     *
     * @param triggerDeviceId 目标设备id
     * @param conditions      条件集合
     * @return
     */
    private boolean inCondition(String triggerDeviceId, List<SceneCondition> conditions) {
        boolean containFlag = false;
        for (SceneCondition condition : conditions) {
            if ("device".equals(condition.getType()) && condition.getDeviceId().equals(triggerDeviceId)) {
                //只要有包含就立即退出循环
                containFlag = true;
                break;
            }
        }
        return containFlag;
    }

    private Map<String, List<SceneCondition>> conditionGroups(List<SceneCondition> conditions) {
        //数据结构为一棵树，根是场景id

        Map<String, List<SceneCondition>> mapList = new HashMap<>();

        for (SceneCondition condition : conditions) {
            List<SceneCondition> sceneConditions;
            if (mapList.containsKey(condition.getSceneId())) {
                sceneConditions = mapList.get(condition.getSceneId());
            } else {
                sceneConditions = new ArrayList<>();
            }
            sceneConditions.add(condition);
            mapList.put(condition.getSceneId(), sceneConditions);
        }
        return mapList;
    }


    private void startLogic(String triggerDeviceId, Map<String, List<SceneCondition>> sceneGroups,
                            MqttClient mqttClient) {

        for (String sceneId : sceneGroups.keySet()) {
            Scene scene = sceneDao.selectById(sceneId);
            //未启用场景跳过
            if (!scene.getEnable()) {
                continue;
            }
            List<SceneCondition> conditions = sceneGroups.get(sceneId);
            //快速处理不包含，不走逻辑
            if (!inCondition(triggerDeviceId, conditions)) {
                continue;
            }
            boolean[] flags = new boolean[conditions.size()];
            for (int i = 0; i < conditions.size(); i++) {
                SceneCondition condition = conditions.get(i);
                switch (condition.getType()) {
                    case "time":
                        LocalTime serverTime = LocalTime.now();
                        LocalTime startTime = condition.getStartTime();
                        LocalTime endTime = condition.getEndTime();
                        if (!serverTime.isBefore(startTime) && serverTime.isBefore(endTime)) {
                            flags[i] = true;
                        }
                        break;
                    case "device":
                        //目标
                        Map<String, Object> triggerDeviceStatusMap = getLatestDeviceStatus(
                                condition.getDeviceId());
                        try {
                            JavaScriptEngine.engine.eval(
                                    "function doCal(triggerDevice,conditionDeviceProperty, conditionRelation, conditionValue) {\n"
                                            + "    return eval(triggerDevice[conditionDeviceProperty] + conditionRelation + conditionValue)\n"
                                            + "\n" + "}\n");

                            Invocable invocable = (Invocable) JavaScriptEngine.engine;
                            boolean calResult = (boolean) invocable.invokeFunction("doCal",
                                    triggerDeviceStatusMap, condition.getDeviceProperty(), condition.getRelation(),
                                    condition.getPropertyValue());

                            flags[i] = calResult;
                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                        break;
                    default:

                }

            }
//同真为真 and 一真为真 or 
            boolean process = true;
            for (boolean flag : flags) {
                if (!flag) {
                    process = false;

                }
            }

            //目前只有and条件，因此全判断
            if (process) {
                List<SceneAction> sceneActions = sceneActionDao.selectList(
                        new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, sceneId));
                //将多条件归纳为单设备map
                Map<String, List<SceneAction>> mapActions = collectActions2Devices(sceneActions);
                for (String deviceId : mapActions.keySet()) {
                    List<SceneAction> oneDeviceSceneActions = mapActions.get(deviceId);
                    Map<String, Object> params = new HashMap<>();
                    String controlProductId = null;
                    for (SceneAction sceneAction : oneDeviceSceneActions) {
                        params.put(sceneAction.getDeviceProperty(),
                                Boolean.parseBoolean(sceneAction.getPropertyValue()));
                        //todo 可以优化
                        Device device = deviceDao.selectById(sceneAction.getDeviceId());
                        deviceId = device.getId();
                        controlProductId = device.getProductId();
                    }
//                    MqttMessage controlMessage = new MqttMessage(
//                            JSON.toJSONString(params).getBytes(StandardCharsets.UTF_8));
//                    controlMessage.setQos(1);
//                    try {
//                        String controlTopic = "control/" + controlProductId + "/" + deviceId;
//                        mqttClient.publish(controlTopic, controlMessage);
//                        DeviceLog controlLog = new DeviceLog(controlProductId, deviceId, controlTopic,
//                                JSON.toJSONString(params), "down", "scene", null);
//                        deviceLogDao.insert(controlLog);
//                    } catch (MqttException e) {
//                        throw new RuntimeException(e);
//                    }


                }
            }
        }
    }


    /**
     * 将动作集合收集为设备id为key的map
     *
     * @param sceneActions
     * @return
     */
    private Map<String, List<SceneAction>> collectActions2Devices(List<SceneAction> sceneActions) {
        Map<String, List<SceneAction>> mapList = new HashMap<>();
        for (SceneAction sceneAction : sceneActions) {
            List<SceneAction> innerList;
            if (mapList.containsKey(sceneAction.getDeviceId())) {
                innerList = mapList.get(sceneAction.getDeviceId());
            } else {
                innerList = new ArrayList<>();
            }
            innerList.add(sceneAction);
            mapList.put(sceneAction.getDeviceId(), innerList);
        }

        return mapList;
    }


    /**
     * 获取设备最新状态
     *
     * @param deviceId 设备id
     * @return
     */
    private Map<String, Object> getLatestDeviceStatus(String deviceId) {
        String latestDeViceStatus = (String) cache.get("latestDeviceStatus:" + deviceId,
                k -> deviceLogDao.selectOne(
                        new LambdaQueryWrapper<DeviceLog>().eq(DeviceLog::getDeviceId, deviceId)
                                .eq(DeviceLog::getDirection, "up").orderByDesc(DeviceLog::getCreateTime)
                                .last("limit 1").select(DeviceLog::getPayload)));
//        return (Map<String, Object>) JSON.parse(latestDeViceStatus);
        return null;
    }


}
