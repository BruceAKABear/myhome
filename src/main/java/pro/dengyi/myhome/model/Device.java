package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonRawValue;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @author BLab
 */
@Data
@TableName("device")
@ApiModel("设备")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Device {

    @ApiModelProperty(value = "设备在系统中的ID")
    private String id;

    @ApiModelProperty(value = "是否在线")
    private Boolean online;

    @ApiModelProperty(value = "是否启用")
    private Boolean enable;

    @ApiModelProperty(value = "图标地址")
    @TableField(exist = false)
    private String iconUrl;

    @ApiModelProperty(value = "所属分类ID")
    private String categoryId;

    @ApiModelProperty(value = "设备名", notes = "只是用户起的别名")
    @TableField(updateStrategy = FieldStrategy.IGNORED)
    private String nickName;

    @ApiModelProperty(value = "所属楼层ID")
    @TableField(updateStrategy = FieldStrategy.IGNORED)
    private String floorId;

    @ApiModelProperty(value = "所属房间ID")
    @TableField(updateStrategy = FieldStrategy.IGNORED)
    private String roomId;

    @ApiModelProperty(value = "只能户主可见")
    private Boolean onlyHolderCanSee;

    @ApiModelProperty(value = "连接系统用户名")
    private String userName;

    @ApiModelProperty(value = "盐")
    private String salt;

    @ApiModelProperty(value = "设备连接密码")
    private String password;
}
