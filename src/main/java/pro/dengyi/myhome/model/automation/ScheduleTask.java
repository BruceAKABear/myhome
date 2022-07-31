package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.util.List;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
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
@TableName("task_schedule")
public class ScheduleTask extends BaseModel {

  @ApiModelProperty("任务名")
  @NotBlank(message = "任务名不能为空")
  private String name;

  @ApiModelProperty("corn表达式")
  @NotBlank(message = "corn表达式不能为空")
  @Length(max = 20)
  private String cron;

  @TableField(exist = false)
  private String productId;

  @ApiModelProperty("被控制的设备ID")
  @NotBlank(message = "被控制的设备ID不能为空")
  @TableField(exist = false)
  private List<String> targetDeviceIds;

  @ApiModelProperty("控制内容")
  private String controlPayload;

  private Boolean enable;


}
