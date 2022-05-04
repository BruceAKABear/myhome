package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 设备类型实体
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@TableName("device_category")
@ApiModel("设备分类实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DeviceCategory {

  @ApiModelProperty(value = "分类Id")
  private String id;

  @ApiModelProperty(value = "设备类型名")
  @NotBlank(message = "设备分类名不能为空")
  @Length(min = 3, max = 30)
  private String name;

  @ApiModelProperty(value = "是否可以下发命令")
  @NotNull(message = "必须选择是否可控")
  private Boolean canControl;

  @ApiModelProperty(value = "分类下设备总数")
  @TableField(exist = false)
  private Integer deviceCount;

  @ApiModelProperty(value = "分类控制字段")
  @TableField(exist = false)
  @NotNull(message = "控制字段不能为空")
  private List<CategoryField> categoryFieldList;

}
