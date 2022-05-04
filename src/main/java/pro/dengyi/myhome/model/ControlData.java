package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 控制命令实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2021-12-15
 */
@Data
@ApiModel("条件任务实体")
@TableName("control_data")
public class ControlData {

  @ApiModelProperty("主键")
  private String id;

  @ApiModelProperty("任务ID")
  private String taskId;

  @ApiModelProperty("设备ID")
  @NotBlank(message = "设备ID不能为空")
  private String deviceId;

  @ApiModelProperty("控制字段")
  @NotBlank(message = "控制字段不能为空")
  private String controlField;

  @ApiModelProperty("控制字段值")
  @NotBlank(message = "字段值不能为空")
  private String controlValue;

}
