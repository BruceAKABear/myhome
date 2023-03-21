package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.dto.ProductPageDto;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
@Repository
public interface ProductDao extends BaseMapper<Product> {

  IPage<ProductPageDto> selectCustomPage(IPage<ProductPageDto> pageParam,
      @Param("name") String name);
}
