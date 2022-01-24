package pro.dengyi.myhome.model.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 登录数据实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Data
@ApiModel("登录实体")
public class LoginVo {

    @ApiModelProperty(required = true, value = "邮箱",example = "dengyi@dengyi.pro")
    @NotBlank
    private String email;

    @ApiModelProperty(required = true, value = "密码",example = "12345678")
    @NotBlank
    private String password;
}
