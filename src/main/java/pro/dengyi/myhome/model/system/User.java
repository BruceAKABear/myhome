package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author BLab
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("system_user")
@ApiModel("用户")
public class User extends BaseModel {

  @ApiModelProperty(value = "是否是户主")
  private Boolean houseHolder;

  @ApiModelProperty(value = "用户名")
  @Length(min = 2, max = 10)
  @NotBlank
  private String name;

  @ApiModelProperty(value = "头像")
  private String avatar;

  @ApiModelProperty(value = "密码")
  private String passw;

  @ApiModelProperty(value = "邮箱")
  private String email;

  @ApiModelProperty(value = "性别")
  private Integer sex;

  @ApiModelProperty(value = "身高")
  private Integer height;

  @ApiModelProperty(value = "体重")
  private Integer weight;

  @ApiModelProperty(value = "年龄")
  private Integer age;

  @ApiModelProperty(value = "选择的楼层ID")
  private String selectedFloorId;

  @ApiModelProperty(value = "选择的房间ID")
  private String selectedRoomId;

  @ApiModelProperty(value = "是否启用")
  private Boolean enable;

  @ApiModelProperty(value = "选中的语言")
  private String selectLang;


}
