package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 楼层实体
 *
 * @author BLab
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("feed_back")
@ApiModel("反馈")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class FeedBack extends BaseModel {


  @ApiModelProperty(value = "用户id")
  private String userId;

  @ApiModelProperty(value = "标题")
  @NotBlank(message = "标题不能为空")
  @Length(min = 1, max = 100)
  private String title;


  @ApiModelProperty(value = "描述")
  @NotBlank(message = "描述不能为空")
  @Length(min = 1, max = 250)
  private String description;


}
