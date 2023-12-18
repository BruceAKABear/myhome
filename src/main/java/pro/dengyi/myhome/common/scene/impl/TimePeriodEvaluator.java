package pro.dengyi.myhome.common.scene.impl;

import pro.dengyi.myhome.common.scene.ConditionEvaluator;
import pro.dengyi.myhome.model.automation.SceneCondition;

import java.time.LocalTime;

public class TimePeriodEvaluator implements ConditionEvaluator {

    @Override
    public boolean evaluate(SceneCondition condition, String payload) {
        LocalTime serverTimeNow = LocalTime.now();
        LocalTime startTime = condition.getStartTime();
        LocalTime endTime = condition.getEndTime();
        return !serverTimeNow.isBefore(startTime) && !serverTimeNow.isAfter(
                endTime);
    }
}