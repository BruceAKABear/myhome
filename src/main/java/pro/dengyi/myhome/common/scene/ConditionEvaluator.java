package pro.dengyi.myhome.common.scene;

import pro.dengyi.myhome.model.automation.SceneCondition;

/**
 * condition evaluator
 */
public interface ConditionEvaluator {
    boolean evaluate(SceneCondition condition, String payload);
}