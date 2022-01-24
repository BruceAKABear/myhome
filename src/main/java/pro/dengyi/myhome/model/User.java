package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @author BLab
 */
@Data
@TableName("user")
@ApiModel("用户")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class User {

    @ApiModelProperty(value = "用户ID")
    private String id;

    @ApiModelProperty(value = "是否是户主")
    private Boolean houseHolder;

    @ApiModelProperty(value = "用户名")
    @Length(min = 2, max = 10)
    @NotBlank
    private String name;

    @ApiModelProperty(value = "头像")
    private String avatar;

    @ApiModelProperty(value = "密码")
    private String password;

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

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "更新时间")
    private Date updateTime;

}
