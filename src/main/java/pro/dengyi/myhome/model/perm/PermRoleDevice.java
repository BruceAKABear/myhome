package pro.dengyi.myhome.model.perm;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/4 13:08
 * @description：人员设备权限中间表
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("perm_role_device")
@ApiModel("数据权限")
public class PermRoleDevice extends BaseModel {

    private String roleId;

    private String deviceId;

}
