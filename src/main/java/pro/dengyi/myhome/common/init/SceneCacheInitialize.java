package pro.dengyi.myhome.common.init;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.service.SceneService;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/12/13 15:12
 * @description：
 * @modified By：
 */
@Component
public class SceneCacheInitialize {
    @Autowired
    private SceneService sceneService;
    @Autowired
    private Cache sceneCache;

    public void initCache() {
        IPage<Scene> page = sceneService.page(1, -1, null, null);
        List<Scene> enableScenes = page.getRecords().stream().filter(Scene::getEnable).collect(Collectors.toList());
        enableScenes.forEach(scene -> sceneCache.put(scene.getId(), scene));
    }
}
