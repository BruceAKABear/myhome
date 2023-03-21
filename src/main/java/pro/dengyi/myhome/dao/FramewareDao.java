package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.device.Frameware;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Repository
public interface FramewareDao extends BaseMapper<Frameware> {

  IPage<Frameware> selectCustomPage(IPage<Frameware> pageParam,
      @Param("productId") String productId);
}
