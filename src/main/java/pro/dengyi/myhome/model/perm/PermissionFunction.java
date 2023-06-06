package pro.dengyi.myhome.model.perm;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

import java.util.List;

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
@JsonInclude(Include.NON_NULL)
public class PermissionFunction extends BaseModel {

    private String parentId;

    @ApiModelProperty("类型 menu、button、api")
    private String type;

    @ApiModelProperty("标识")
    private String symbol;

    @ApiModelProperty("菜单权限前端icon")
    private String menuIcon;

    @ApiModelProperty("接口地址,分割")
    private String uris;

    @TableField(exist = false)
    private List<PermissionFunction> children;

}
