package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import pro.dengyi.myhome.model.base.BaseModel;

import javax.validation.constraints.NotBlank;

/**
 * 楼层实体
 *
 * @author BLab
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("family_room")
@ApiModel("房间")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Room extends BaseModel {


    @ApiModelProperty(value = "顺序")
    private Integer sequence;

    @ApiModelProperty(value = "楼层ID")
    @NotBlank(message = "楼层ID不能为空")
    private String floorId;

    @ApiModelProperty(value = "房间名")
    @Length(min = 2, max = 10)
    @NotBlank(message = "房间名不能为空")
    private String name;

    @ApiModelProperty(value = "beacon-uuid")
    private String beaconUuid;
}
