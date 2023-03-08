package pro.dengyi.myhome.service;

import java.util.List;
import java.util.Map;
import pro.dengyi.myhome.model.automation.Scene;

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

  Scene queryForUpdate(String sceneId);
}
