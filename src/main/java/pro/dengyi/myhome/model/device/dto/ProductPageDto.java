package pro.dengyi.myhome.model.device.dto;

import io.swagger.annotations.ApiModelProperty;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.ProductField;

/**
 * 产品分页查询数据传输实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
public class ProductPageDto extends Product {

  @ApiModelProperty("设备数")
  private Integer deviceCount;


  @ApiModelProperty(value = "分类控制字段")
  private List<ProductField> productFields;

}
