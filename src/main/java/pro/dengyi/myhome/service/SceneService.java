package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.automation.dto.SceneChangeDto;

import java.util.List;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/10 13:06
 * @description：
 * @modified By：
 */
public interface SceneService {

    void addOrUpdate(Scene scene);


    void changeEnable(SceneChangeDto dto);

    void delete(String id);


    IPage<Scene> page(Integer page, Integer size, String name, String sceneId);
}
