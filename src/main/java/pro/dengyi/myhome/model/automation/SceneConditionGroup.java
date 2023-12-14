package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.common.enums.RelationEnum;
import pro.dengyi.myhome.model.base.BaseModel;

import java.util.List;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/12/12 11:01
 * @description：
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@ApiModel("条件任务实体")
@TableName("scene_condition_group")
public class SceneConditionGroup extends BaseModel {

    private String sceneId;

    private Integer orderNumber;

    private RelationEnum relation;

    @TableField(exist = false)
    private List<SceneCondition> conditions;
}
