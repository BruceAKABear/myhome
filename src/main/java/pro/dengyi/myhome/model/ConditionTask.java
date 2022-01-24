package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 定时任务实体
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ApiModel("条件任务实体")
@TableName("schedule_task")
public class ConditionTask {

    @ApiModelProperty("主键")
    private String id;

    @ApiModelProperty("家庭ID")
    @NotBlank(message = "家庭ID不能为空")
    private String familyId;

    @ApiModelProperty("任务名")
    @NotBlank(message = "任务名不能为空")
    private String name;

    @ApiModelProperty("关联数据集合")
    private Object relationData;


}
