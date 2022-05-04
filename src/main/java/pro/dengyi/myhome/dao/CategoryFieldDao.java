package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.CategoryField;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Repository
public interface CategoryFieldDao extends BaseMapper<CategoryField> {

  List<CategoryField> selectListByDeviceId(@Param("deviceId") String deviceId);
}
