package pro.dengyi.myhome.common.scene.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import pro.dengyi.myhome.common.scene.ConditionEvaluator;
import pro.dengyi.myhome.common.utils.JavaScriptEngine;
import pro.dengyi.myhome.model.automation.SceneCondition;

import javax.script.Invocable;

@Slf4j
public class DeviceEvaluator implements ConditionEvaluator {

    @Override
    public boolean evaluate(SceneCondition condition, String payload) {
        ObjectMapper om = new ObjectMapper();
        try {
            JavaScriptEngine.engine.eval(
                    "function doCalculate(condition, payload) {\n" + " condition=JSON.parse(condition); payload=JSON.parse(payload);   return eval(payload[condition.deviceProperty] + condition.operator + condition.propertyValue)\n" + "}");
            Invocable invocable = (Invocable) JavaScriptEngine.engine;
            return (boolean) invocable.invokeFunction("doCalculate",
                    om.writeValueAsString(condition), payload);
        } catch (Exception e) {
            log.error("calculate error:{}", e);
            return false;
        }
    }

}