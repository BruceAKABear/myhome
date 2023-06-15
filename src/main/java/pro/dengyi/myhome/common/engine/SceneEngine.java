package pro.dengyi.myhome.common.engine;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.CollectionUtils;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.automation.SceneAction;
import pro.dengyi.myhome.model.automation.SceneCondition;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/16 9:14
 * @description：场景引擎
 * @modified By：
 */
@Slf4j
public class SceneEngine {
    //js engine
    private static ScriptEngine jsEngine;
    //all scenes include details
    private List<Scene> scenes;

    static {
        ScriptEngineManager mgr = new ScriptEngineManager();
        jsEngine = mgr.getEngineByName("JavaScript");
    }


    public void trigger(String reportMsg) {
        ObjectMapper jackson = new ObjectMapper();
        try {
            Map deviceReportMap = jackson.readValue(reportMsg, Map.class);
            LocalDateTime dateTimeNow = LocalDateTime.now();
            //any condition contains trigger device process else break
            String triggerDeviceId = (String) deviceReportMap.get("deviceId");
            List<Scene> scenesRelated = scenesContainDevice(triggerDeviceId);
            for (int i = 0; i < scenesRelated.size(); i++) {
                Scene scene = scenesRelated.get(i);
                List<SceneCondition> conditionsInScene = scene.getConditions();
                for (SceneCondition condition : conditionsInScene) {
                    switch (condition.getType()) {
                        case "time":
                            //daily type of time  startTime <= serverTime <= endTime
                            LocalTime serverTime = dateTimeNow.toLocalTime();
                            if ((serverTime.isAfter(condition.getStartTime()) || serverTime.equals(condition.getStartTime()))
                                    && (serverTime.isBefore(condition.getEndTime()) || serverTime.equals(condition.getEndTime()))) {

                            }
                            break;
                        case "device":
                            jsEngine.eval(
                                    "function doCal(triggerDevice,conditionDeviceProperty, conditionRelation, conditionValue) {\n"
                                            + "    return eval(triggerDevice[conditionDeviceProperty] + conditionRelation + conditionValue)\n"
                                            + "\n" + "}\n");

                            Invocable invocable = (Invocable) jsEngine;
                            boolean calResult = (boolean) invocable.invokeFunction("doCal",
                                    deviceReportMap, condition.getDeviceProperty(), condition.getRelation(),
                                    condition.getPropertyValue());

                            break;
                        default:
                            log.error("SceneEngine->not supported automation condition type:{}", condition.getType());
                    }
                }
                //todo 逻辑

                List<SceneAction> actionsInScene = scene.getActions();

            }
        } catch (JsonProcessingException e) {
            log.error("SceneEngine->scene engine deserial device msg error: ", e);
        } catch (ScriptException e) {
            log.error("SceneEngine->js engine  error: ", e);
        } catch (NoSuchMethodException e) {
            log.error("SceneEngine->js engine not js method error: ", e);
        }


    }

    /**
     * collect trigger device in any active scenes
     *
     * @param deviceId trigger device id(aka device chip id)
     * @return
     */
    private List<Scene> scenesContainDevice(String deviceId) {
        List<Scene> relatedScenes = new ArrayList<>();
        for (Scene scene : scenes) {
            List<SceneCondition> conditions = scene.getConditions();
            //scene enable and device in trigger condition
            if (scene.getEnable() && !CollectionUtils.isEmpty(conditions)) {
                for (SceneCondition condition : conditions) {
                    if (condition.getDeviceId().equals(deviceId)) {
                        relatedScenes.add(scene);
                        // break to current condition judgement loop to another scene loop
                        break;
                    }
                }
            }
        }
        return relatedScenes;
    }

}
