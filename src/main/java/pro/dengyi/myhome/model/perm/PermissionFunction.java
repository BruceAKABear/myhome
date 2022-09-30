package pro.dengyi.myhome.model.perm;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/9/30 14:56
 * @description：权限
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("perm_permission_function")
@ApiModel("功能权限")
public class PermissionFunction extends BaseModel {

  @ApiModelProperty("类型 menu、button、api")
  private String type;

  @ApiModelProperty("标识")
  private String symbol;

  @ApiModelProperty("接口地址,分割")
  private String uris;

}
