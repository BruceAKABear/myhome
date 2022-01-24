package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.Version;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 定时任务实体
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ApiModel("定时任务实体")
@TableName("schedule_task")
public class ScheduleTask {

    @ApiModelProperty("主键")
    private String id;

    @ApiModelProperty("家庭ID")
    @NotBlank(message = "家庭ID不能为空")
    private String familyId;

    @ApiModelProperty("任务名")
    @NotBlank(message = "任务名不能为空")
    private String name;

    @ApiModelProperty("corn表达式")
    @NotBlank(message = "corn表达式不能为空")
    @Length(max = 20)
    private String cronExpression;

    @ApiModelProperty(value = "类路径，固定值", hidden = true)
    private String beanClass = "pro.dengyi.myhome.servicescene.jobs.RealJob";

    @ApiModelProperty("控制数据集合")
    @TableField(exist = false)
    private List<ControlData> datas;

    @ApiModelProperty("是否在运行中")
    private Boolean running;

    @Version
    private Integer version;


}
