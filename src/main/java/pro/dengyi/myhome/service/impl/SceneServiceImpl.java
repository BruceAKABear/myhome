package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
import pro.dengyi.myhome.model.automation.dto.SceneChangeDto;
import pro.dengyi.myhome.service.SceneService;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

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
    private SceneConditionGroupDao sceneConditionGroupDao;

    @Resource
    private Cache sceneCache;


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
        //2. save new data to the database
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
        //3. update cache
        enableSceneCache(sceneId);
    }

    @Transactional
    @Override
    public void changeEnable(SceneChangeDto dto) {
        Scene scene = new Scene();
        scene.setId(dto.getSceneId());
        scene.setEnable(dto.getEnable());
        scene.setUpdateTime(LocalDateTime.now());
        sceneDao.updateById(scene);
        //handle data in cache
        if (dto.getEnable()) {
            enableSceneCache(dto.getSceneId());
        } else {
            disableSceneCache(dto.getSceneId());
        }
    }


    @Transactional
    @Override
    public void delete(String sceneId) {
        sceneDao.deleteById(sceneId);
        sceneConditionGroupDao.delete(new LambdaQueryWrapper<SceneConditionGroup>().eq(SceneConditionGroup::getSceneId, sceneId));
        sceneConditionDao.delete(new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, sceneId));
        sceneActionDao.delete(new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, sceneId));
        disableSceneCache(sceneId);
    }


    @Override
    public IPage<Scene> page(Integer page, Integer size, String name, String sceneId) {
        page = page == null ? 1 : page;
        size = size == null ? 10 : size;
        Page<Scene> pageParam = new Page<>(page, size);
        Integer start = (page - 1) * size;
        Integer end = size;
        Integer totalSize = sceneDao.selectTotalCount(name, sceneId);
        List<Scene> scenes = sceneDao.selectCustomPage(start, end, name, sceneId);
        pageParam.setRecords(scenes);
        pageParam.setTotal(totalSize);
        return pageParam;
    }


    private void enableSceneCache(String sceneId) {
        Scene scene = page(1, 1, null, sceneId).getRecords().get(0);
        sceneCache.put(sceneId, scene);
    }

    /**
     * disable the scene
     *
     * @param sceneId
     */
    private void disableSceneCache(String sceneId) {
        sceneCache.invalidate(sceneId);
    }


}
