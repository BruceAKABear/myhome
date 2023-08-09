package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.SceneActionDao;
import pro.dengyi.myhome.dao.SceneConditionDao;
import pro.dengyi.myhome.dao.SceneDao;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.automation.SceneAction;
import pro.dengyi.myhome.model.automation.SceneCondition;
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


    @Transactional
    @Override
    public void addOrUpdate(Scene scene) {

        if (ObjectUtils.isEmpty(scene.getId())) {
//            sceneDao.selectList(new LambdaQueryWrapper<Scene>().eq())

            //新增
            scene.setCreateTime(LocalDateTime.now());
            scene.setUpdateTime(LocalDateTime.now());
            sceneDao.insert(scene);
        } else {
            //修改
            sceneDao.updateById(scene);
        }
        //全量删除后全量新增
        sceneConditionDao.delete(
                new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, scene.getId()));
        sceneActionDao.delete(
                new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, scene.getId()));
        //全量新增
        List<SceneAction> actions = scene.getActions();
        for (SceneAction action : actions) {
            action.setSceneId(scene.getId());
            action.setCreateTime(LocalDateTime.now());
            action.setUpdateTime(LocalDateTime.now());
            sceneActionDao.insert(action);
        }
        List<SceneCondition> conditions = scene.getConditions();
        for (SceneCondition condition : conditions) {
            condition.setSceneId(scene.getId());
            condition.setCreateTime(LocalDateTime.now());
            condition.setUpdateTime(LocalDateTime.now());
            sceneConditionDao.insert(condition);
        }
        //清除缓存
        cache.invalidate("condition");

    }

    @Override
    public List<Scene> list() {
        List<Scene> scenes = sceneDao.selectList(new LambdaQueryWrapper<>());
        if (!CollectionUtils.isEmpty(scenes)) {
            for (Scene scene : scenes) {
                List<SceneAction> sceneActions = sceneActionDao.selectList(
                        new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, scene.getId()));
                List<SceneCondition> sceneConditions = sceneConditionDao.selectList(
                        new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, scene.getId()));
                scene.setConditions(sceneConditions);
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
    public void delete(String id) {
        sceneDao.deleteById(id);
        sceneConditionDao.delete(
                new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, id));
        sceneActionDao.delete(new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, id));
    }

    @Override
    public Scene queryForUpdate(String sceneId) {

        Scene scene = sceneDao.selectById(sceneId);
        List<SceneAction> sceneActions = sceneActionDao.selectList(
                new LambdaQueryWrapper<SceneAction>().eq(SceneAction::getSceneId, sceneId));

        List<SceneCondition> conditions = sceneConditionDao.selectList(
                new LambdaQueryWrapper<SceneCondition>().eq(SceneCondition::getSceneId, sceneId));

        scene.setActions(sceneActions);
        scene.setConditions(conditions);
        return scene;
    }

    @Override
    public IPage<Scene> page(Integer size, Integer page, String name) {
        size = size == null ? 10 : size;
        page = page == null ? 1 : page;


        return null;
    }
}
