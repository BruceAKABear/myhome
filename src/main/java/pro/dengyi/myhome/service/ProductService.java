package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.dto.ProductAddDto;
import pro.dengyi.myhome.model.device.dto.ProductPageDto;

/**
 * 产品service接口
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
public interface ProductService {

  /**
   * 新增或修改产品
   * <p>
   * 在修改产品时，如果产品下挂了设备且更改了设备加密类型，则不允许修改
   *
   * @param productAddDto
   */
  void addUpdate(ProductAddDto productAddDto);

  void delete(String id);

  IPage<ProductPageDto> page(Integer page, Integer size, String name);

  List<Product> categoryList();
}
