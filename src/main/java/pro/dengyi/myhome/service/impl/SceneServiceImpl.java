package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.dao.SceneActionDao;
import pro.dengyi.myhome.dao.SceneConditionDao;
import pro.dengyi.myhome.dao.SceneConditionGroupDao;
import pro.dengyi.myhome.dao.SceneDao;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.automation.SceneAction;
import pro.dengyi.myhome.model.automation.SceneCondition;
import pro.dengyi.myhome.model.automation.SceneConditionGroup;
import pro.dengyi.myhome.service.SceneService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/10 13:07
 * @description：
 * @modified By：
 */
@Service
public class SceneServiceImpl implements SceneService {

    @Autowired
    private SceneDao sceneDao;
    @Autowired
    private SceneActionDao sceneActionDao;
    @Autowired
    private SceneConditionDao sceneConditionDao;
    @Autowired
    private Cache cache;
    @Autowired
    private SceneConditionGroupDao sceneConditionGroupDao;


    @Transactional
    @Override
    public void addOrUpdate(Scene scene) {

        if (ObjectUtils.isEmpty(scene.getId())) {
            List<Scene> scenes = sceneDao.selectList(new LambdaQueryWrapper<Scene>().eq(Scene::getName, scene.getName()));
            if (!CollectionUtils.isEmpty(scenes)) {
                throw new BusinessException("scene.same.name.exist");
            }
            //新增
            scene.setCreateTime(LocalDateTime.now());
            scene.setUpdateTime(LocalDateTime.now());
            sceneDao.insert(scene);
        } else {
            //修改
            List<Scene> scenes = sceneDao.selectList(new LambdaQueryWrapper<Scene>().eq(Scene::getName, scene.getName()).ne(Scene::getId, scene.getId()));
            if (!CollectionUtils.isEmpty(scenes)) {
                throw new BusinessException("scene.same.name.exist");
            }
            scene.setUpdateTime(LocalDateTime.now());
            sceneDao.updateById(scene);
        }
        //全量更新条件和动作
        completeUpdate(scene.getId(), scene.getSceneConditionGroups(), scene.getActions());

    }

    //    {
//        "actions": [{
//        "deviceId": "string",
//                "deviceProperty": "string",
//                "propertyValue": "string",
//                "sceneId": "string",
//                "type": "string"
//    }],
//        "sceneConditionGroups": [{
//        "conditions": [{
//            "endTime": "18:00",
//                    "orderNumber": 0,
//                    "startTime": "08:00",
//                    "type": "time"
//        }, {
//            "relation": "AND",
//                    "orderNumber": 1,
//                    "type": "device",
//                    "deviceId": "abcd123",
//                    "deviceProperty": "man",
//                    "operator": "=",
//                    "propertyValue": "true"
//        }],
//        "orderNumber": 0
//    }],
//        "enable": true,
//            "name": "测试场景",
//            "id": "1734454944919052289"
//    }
    private void completeUpdate(String sceneId, List<SceneConditionGroup> sceneConditionGroups, List<SceneAction> sceneActions) {
        //1. clear database
        sceneConditionGroupDao.delete(new LambdaQueryWrapper<SceneConditionGroup>().eq(SceneConditionGroup::getSceneId, sceneId));
        sceneConditionDao.delete(new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, sceneId));
        sceneActionDao.delete(new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, sceneId));
        //2. clear cache
        //3. save new data to database
        for (SceneConditionGroup sceneConditionGroup : sceneConditionGroups) {
            sceneConditionGroup.setSceneId(sceneId);
            sceneConditionGroupDao.insert(sceneConditionGroup);
            List<SceneCondition> conditions = sceneConditionGroup.getConditions();
            for (SceneCondition condition : conditions) {
                condition.setSceneId(sceneId);
                condition.setConditionGroupId(sceneConditionGroup.getId());
                sceneConditionDao.insert(condition);
            }
        }

        for (SceneAction sceneAction : sceneActions) {
            sceneAction.setSceneId(sceneId);
            sceneActionDao.insert(sceneAction);
        }
        //4. update cache
    }

    @Override
    public List<Scene> list() {
        List<Scene> scenes = sceneDao.selectList(new LambdaQueryWrapper<>());
        if (!CollectionUtils.isEmpty(scenes)) {
            for (Scene scene : scenes) {
                List<SceneAction> sceneActions = sceneActionDao.selectList(new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, scene.getId()));
//                List<SceneCondition> sceneConditions = sceneConditionDao.selectList(new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, scene.getId()));
                // scene.setConditions(sceneConditions);
                scene.setActions(sceneActions);
            }
        }
        return sceneDao.selectList(new LambdaQueryWrapper<>());
    }

    @Transactional
    @Override
    public void changeEnable(Map<String, Object> params) {
        String sceneId = (String) params.get("sceneId");
        boolean enable = (boolean) params.get("enable");
        Scene scene = new Scene();
        scene.setId(sceneId);
        scene.setEnable(enable);
        scene.setUpdateTime(LocalDateTime.now());
        sceneDao.updateById(scene);
    }


    @Transactional
    @Override
    public void delete(String sceneId) {
        sceneDao.deleteById(sceneId);
        sceneConditionGroupDao.delete(new LambdaQueryWrapper<SceneConditionGroup>().eq(SceneConditionGroup::getSceneId, sceneId));
        sceneConditionDao.delete(new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, sceneId));
        sceneActionDao.delete(new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, sceneId));
        //todo 从缓存中删除
    }

    @Override
    public Scene queryById(String sceneId) {
        //todo

        Scene scene = sceneDao.selectById(sceneId);
//        List<SceneAction> sceneActions = sceneActionDao.selectList(new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, sceneId));

//        List<SceneCondition> conditions = sceneConditionDao.selectList(new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, sceneId));

        // scene.setActions(sceneActions);
        // scene.setConditions(conditions);
        return scene;
    }

    @Override
    public IPage<Scene> page(Integer size, Integer page, String name) {
        size = size == null ? 10 : size;
        page = page == null ? 1 : page;
        return sceneDao.selectCustomPage(new Page<Scene>(page, size), name);
    }
}
