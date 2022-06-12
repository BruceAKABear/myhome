package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import lombok.Data;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.device.ProductField;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
@Repository
public interface ProductFieldDao extends BaseMapper<ProductField> {

}
