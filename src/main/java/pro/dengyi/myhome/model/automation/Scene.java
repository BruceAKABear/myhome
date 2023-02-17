package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.util.List;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/2 14:32
 * @description： 场景 条件及结果参见readme文档
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("scene_scene")
@ApiModel("设备关联实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Scene extends BaseModel {

  @ApiModelProperty("名称")
  @NotBlank(message = "场景名称不能为空")
  private String name;


  @ApiModelProperty("名称")
  @NotBlank(message = "场景名称不能为空")
  private String description;

  @ApiModelProperty("启用状态")
  private Boolean enable;

  @NotBlank(message = "条件集合不能为空")
  @ApiModelProperty("条件集合")
  @TableField(exist = false)
  private List<SceneCondition> conditions;

  @NotBlank(message = "执行集合不能为空")
  @ApiModelProperty("执行集合")
  @TableField(exist = false)
  private List<SceneAction> actions;


}