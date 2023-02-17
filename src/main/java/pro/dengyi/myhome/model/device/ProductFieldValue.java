package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 设备类别字段映射表
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_product_field")
@ApiModel("产品字段实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ProductFieldValue extends BaseModel {

  @ApiModelProperty(value = "显示值")
  private String label;

  @ApiModelProperty(value = "实际值")
  @NotBlank(message = "实际值不能为空")
  private String value;


}