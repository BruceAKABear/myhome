package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.automation.Scene;

import java.util.List;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/10 13:06
 * @description：
 * @modified By：
 */
public interface SceneService {

    void addOrUpdate(Scene scene);

    List<Scene> list();

    void changeEnable(Map<String, Object> params);

    void delete(String id);

    Scene queryById(String sceneId);

    IPage<Scene> page(Integer size, Integer page, String name);
}
