package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;
import pro.dengyi.myhome.model.device.Device;

import javax.validation.constraints.NotBlank;

/**
 * 定时任务实体
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@ApiModel("条件任务实体内容")
@TableName("task_condition_item")
public class ConditionTaskItem extends BaseModel {

    @ApiModelProperty("名称")
    @NotBlank
    private String name;

    private String link;


    private String targetDeviceId;

    @TableField(exist = false)
    private Device targetDevice;

    private String targetFiled;

    private String targetValue;

    private String fid;


}
