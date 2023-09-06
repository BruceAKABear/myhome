package pro.dengyi.myhome.common.threads;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.common.utils.IpUtil;
import pro.dengyi.myhome.common.utils.SceneEngine;
import pro.dengyi.myhome.common.utils.queue.DeviceLogQueue;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.FramewareDao;
import pro.dengyi.myhome.dao.SceneConditionDao;
import pro.dengyi.myhome.model.automation.SceneCondition;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.Frameware;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * mqtt消息处理线程
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-26
 */
@Slf4j
@Component
public class MqttMessageHandleThread {

    @Autowired
    private DeviceDao deviceDao;
    @Autowired
    private FramewareDao framewareDao;
    @Autowired
    private Cache cache;

    @Value("${server.port}")
    private Integer serverPort;
    @Autowired
    private SceneEngine sceneEngine;
    @Autowired
    private SceneConditionDao sceneConditionDao;


    /**
     * the basic message for device upload must like this: {productId:xxxxxx,deviceId:xxxxx,...}
     *
     * @param topic      mqtt topic must be like this: control/productId/deviceId(device id use chip
     *                   id for unique)
     * @param message
     * @param mqttClient
     */
    @Async("executor")
    @Transactional
    public void handleMessage(String topic, MqttMessage message, MqttClient mqttClient) {
        log.info("收到消息:topic:{},消息内容:{}", topic, message.toString());
        String[] topicArray = topic.split("/");
        String productId = topicArray[1];
        String deviceId = topicArray[2];

        Device device = (Device) cache.get("device:" + deviceId, pa -> deviceDao.selectById(deviceId));
        //设备日志,队列进行异步存储
        DeviceLog deviceLog = new DeviceLog(productId, deviceId, topic, message.toString(), "up");
        DeviceLogQueue.publish(deviceLog);
        //维持最新状态
        cache.put("latestDeviceStatus:" + deviceId, message.toString());
        //设备固件版本控制
        deviceVersionControl(productId, deviceId, message.toString(), mqttClient);
        //推送设备状态
        //特
        if ("1604724519529963522".equals(productId)) {
//            Map map = JSON.parseObject(message.toString(), Map.class);
//            if ((int) map.get("pm10") != 65535) {
//                PushUtil.deviceStatusChangePush(deviceId, device.getRoomId(),
//                        JSON.parse(message.toString()));
//
//            }
        } else {

//            PushUtil.deviceStatusChangePush(deviceId, device.getRoomId(), JSON.parse(message.toString()));
        }
        //启用的条件触发
        List<SceneCondition> conditions = (List<SceneCondition>) cache.get("condition",
                k -> sceneConditionDao.selectList(new LambdaQueryWrapper<>()));
        sceneEngine.trigger(deviceId, conditions, mqttClient);

    }


    //todo 升级控制 3次未成功的话就不在下发 报出异常通知，目的免得一直在重启
    private void deviceVersionControl(String productId, String deviceId, String message,
                                      MqttClient mqttClient) {
        //判断固件版本更新
        Frameware frameware = (Frameware) cache.get("frameware:" + productId,
                key -> framewareDao.selectOne(
                        new LambdaQueryWrapper<Frameware>().eq(Frameware::getProductId, productId)
                                .orderByDesc(Frameware::getVersion).last("limit 1")));
        Device device = deviceDao.selectById(deviceId);
//        Integer reportDeviceVersion = Integer.parseInt(
//                JSON.parseObject(message).get("version").toString());
        //todo 不相等且大于才进行更新
//        if (!device.getFramewareVersion().equals(reportDeviceVersion)) {
//            //不相等进行更新
//            device.setFramewareVersion(reportDeviceVersion);
//            deviceDao.updateById(device);
//        }
        if (frameware != null && frameware.getVersion() > device.getFramewareVersion()) {
            try {
                Map<String, Object> otaParams = new HashMap<>();
                String ip = IpUtil.getIp();
                otaParams.put("url", "http://" + ip + ":" + serverPort + frameware.getUrl());
                String otaTopic = "ota/" + device.getProductId() + "/" + device.getId();
//                MqttMessage otaMessage = new MqttMessage(
//                        JSON.toJSONString(otaParams).getBytes(StandardCharsets.UTF_8));
//                otaMessage.setQos(1);
//                mqttClient.publish(otaTopic, otaMessage);
//                DeviceLog otaLog = new DeviceLog(device.getProductId(), device.getId(), otaTopic,
//                        JSON.toJSONString(otaParams), "down");
//                DeviceLogQueue.publish(otaLog);
            } catch (Exception e) {
                log.error("下发固件更新时异常:", e);
            }

        }

    }

}
