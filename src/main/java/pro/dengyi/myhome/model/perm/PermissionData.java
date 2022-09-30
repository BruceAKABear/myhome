package pro.dengyi.myhome.model.perm;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
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
@TableName("perm_permission_data")
@ApiModel("数据权限")
public class PermissionData extends BaseModel {

  private String deviceId;

  private String userId;

}
