package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 产品实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_product")
public class Product extends BaseModel {

  @ApiModelProperty(value = "产品名")
  @NotBlank(message = "设备分类名不能为空")
  @Length(min = 1, max = 30)
  private String name;

  @ApiModelProperty(value = "产品描述")
  @Length(max = 250)
  private String note;

  @ApiModelProperty(value = "平台是否可控")
  @NotNull(message = "必须选择是否可控")
  private Boolean canControl;

  @ApiModelProperty(value = "产品类型(1.普通产品，2.网关产品)")
  @NotNull(message = "产品类型不能为空")
  private Integer type;



}
