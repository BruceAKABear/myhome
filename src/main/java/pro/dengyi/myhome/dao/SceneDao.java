package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.automation.Scene;

import java.util.List;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/10 13:07
 * @description：
 * @modified By：
 */
@Repository
public interface SceneDao extends BaseMapper<Scene> {

    List<Scene> sceneListAndDetails();

    IPage<Scene> selectCustomPage(@Param("name") String name, @Param("sceneId") String sceneId);
}
