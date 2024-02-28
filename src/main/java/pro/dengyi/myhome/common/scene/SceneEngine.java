package pro.dengyi.myhome.common.scene;

import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import pro.dengyi.myhome.common.enums.RelationEnum;
import pro.dengyi.myhome.common.utils.JavaScriptEngine;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.SceneActionDao;
import pro.dengyi.myhome.dao.SceneDao;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.automation.SceneCondition;
import pro.dengyi.myhome.model.automation.SceneConditionGroup;
import pro.dengyi.myhome.service.SceneService;

import javax.script.ScriptException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/3 17:17
 * @description：条件引擎
 * @modified By：
 */
@Component
public class SceneEngine {

    @Autowired
    private DeviceDao deviceDao;
    @Autowired
    private DeviceLogDao deviceLogDao;
    @Autowired
    private SceneActionDao sceneActionDao;
    @Autowired
    private SceneDao sceneDao;
    @Autowired
    private SceneService sceneService;

    public void execute(String deviceId, String payload) {
        List<Scene> sceneList = sceneService.page(1, -1, null, null)
                .getRecords();
        //if not exist scene data just return next logic
        if (CollectionUtils.isEmpty(sceneList)) {
            return;
        }
        List<String> deviceIds = sceneList.stream()
                .flatMap(scene -> scene.getSceneConditionGroups().stream())
                .flatMap(
                        sceneConditionGroup -> sceneConditionGroup.getConditions()
                                .stream()).map(SceneCondition::getDeviceId)
                .collect(Collectors.toList());
        //if trigger device not contain any conditions just return next logic
        if (!deviceIds.contains(deviceId)) {
            return;
        }
        List<Scene> scenes = includeByScenes(deviceId, sceneList);
        //start to execute real logic
        doLogic(payload, scenes);


    }


    private void doLogic(String payload, List<Scene> scenes) {

        for (Scene scene : scenes) {
            List<SceneConditionGroup> sceneConditionGroups = scene.getSceneConditionGroups();
            StringBuilder conditionGroupBuilder = new StringBuilder();
            for (SceneConditionGroup sceneConditionGroup : sceneConditionGroups) {
                //fist one don't hava the relation symbol
                RelationEnum relation = sceneConditionGroup.getRelation();
                List<SceneCondition> sceneConditions = sceneConditionGroup.getConditions();
                StringBuilder conditionBuilder = new StringBuilder();
                for (SceneCondition sceneCondition : sceneConditions) {
                    // we use reflection to get the target object and execute the target method
                    ConditionEvaluator conditionEvaluator;
                    try {
                        conditionEvaluator = (ConditionEvaluator) Class.forName(
                                        "pro.dengyi.myhome.common.scene.impl." + sceneCondition.getType() + "Evaluator")
                                .newInstance();
                    } catch (InstantiationException | ClassNotFoundException |
                             IllegalAccessException e) {
                        throw new RuntimeException(e);
                    }

                    boolean evaluationResult = conditionEvaluator.evaluate(
                            sceneCondition, payload);
                    if (conditionBuilder.length() == 0) {
                        conditionBuilder.append(evaluationResult);
                    } else {
                        conditionBuilder.append(" ")
                                .append(sceneCondition.getRelation().getValue())
                                .append(" ").append(evaluationResult);
                    }
                }
                //  use js to eval string and get the real status

                boolean conditionResult = jsEngineEval(conditionBuilder);

                if (conditionGroupBuilder.length() == 0) {
                    conditionGroupBuilder.append(conditionResult);
                } else {
                    conditionGroupBuilder.append(" ")
                            .append(relation.getValue()).append(" ")
                            .append(conditionResult);
                }
            }

            boolean sceneResult = jsEngineEval(conditionGroupBuilder);
            if (sceneResult) {
                sendCmd(scene);
            }
        }
    }


    private void sendCmd(Scene scene) {
        System.err.println("send cmd!!");

    }

    /**
     * use js to eval a string and get the response,the string will be like this "true and false or true"
     *
     * @param logicString
     * @return
     */
    private boolean jsEngineEval(StringBuilder logicString) {
        // need to do some logic string validate
        try {
            JavaScriptEngine.engine.eval("var result=" + logicString + ";");
            return (Boolean) JavaScriptEngine.engine.get("result");
        } catch (ScriptException e) {
            throw new RuntimeException(e);
        }
    }


    private List<Scene> includeByScenes(String deviceId,
                                        List<Scene> sceneList) {
        return sceneList.stream()
                .filter(scene -> scene.getSceneConditionGroups().stream()
                        .flatMap(
                                sceneConditionGroup -> sceneConditionGroup.getConditions()
                                        .stream())
                        .map(SceneCondition::getDeviceId)
                        .anyMatch(deviceId::equals))
                .collect(Collectors.toList());
    }

}
