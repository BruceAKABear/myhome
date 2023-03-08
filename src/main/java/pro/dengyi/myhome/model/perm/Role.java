package pro.dengyi.myhome.model.perm;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.util.List;
import javax.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 系统初始化会默认有户主和普通成员两个角色
 *
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/9/30 14:56
 * @description：角色
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("perm_role")
@ApiModel("角色")
public class Role extends BaseModel {

  @ApiModelProperty("是否可以删除")
  private Boolean canDel;

  @ApiModelProperty("角色名")
  private String name;

  @ApiModelProperty("描述")
  private String describ;

  @TableField(exist = false)
  private List<Object> permIds;


  @TableField(exist = false)
  @NotNull(message = "可控设备不能为空")
  private List<String> deviceIds;

  @TableField(exist = false)
  private long userCount;

}
