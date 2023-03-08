package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 固件实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_frameware")
@ApiModel("设备实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Frameware extends BaseModel {


  @ApiModelProperty(value = "产品ID")
  @NotBlank(message = "产品ID不能为空")
  private String productId;

  @ApiModelProperty(hidden = true, value = "产品名称")
  @TableField(exist = false)
  private String productName;

  @ApiModelProperty(value = "固件描述")
  @NotBlank(message = "固件描述不能为空")
  @Length(max = 250)
  private String note;

  @ApiModelProperty(value = "版本")
  private Integer version;

  @ApiModelProperty(value = "url")
  @NotNull(message = "url地址不能为空")
  private String url;

//  @ApiModelProperty(value = "开启自动更新")
//  @NotNull(message = "自动更新不能为空")
//  private Boolean autoUpdate;

}
