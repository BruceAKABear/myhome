package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * 设备类型实体
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@TableName("device_category")
@ApiModel("设备分类实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DeviceCategory {

    @ApiModelProperty(value = "分类Id")
    private String id;

    @ApiModelProperty(value = "设备类型名")
    @NotBlank
    private String name;

    @ApiModelProperty(value = "是否可以下发命令")
    @NotNull
    private Boolean canControl;

    @ApiModelProperty(value = "分类下设备总数")
    @TableField(exist = false)
    private Integer deviceCount;
}
