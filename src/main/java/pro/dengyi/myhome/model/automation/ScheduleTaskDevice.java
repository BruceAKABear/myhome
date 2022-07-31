package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 定时任务实体
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@ApiModel("定时任务实体")
@TableName("task_schedule_device")
public class ScheduleTaskDevice extends BaseModel {

  @ApiModelProperty("设备ID")
  @NotBlank(message = "设备ID不能为空")
  private String deviceId;

  @ApiModelProperty("taskId")
  @NotBlank(message = "taskId不能为空")
  private String taskId;


}
