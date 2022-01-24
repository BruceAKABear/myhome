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
 * 楼层实体
 *
 * @author BLab
 */
@Data
@TableName("room")
@ApiModel("房间")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Room {

    @ApiModelProperty(value = "Id")
    private String id;

    @ApiModelProperty(value = "楼层ID")
    private String floorId;

    @ApiModelProperty(value = "房间名")
    @Length(max = 10)
    @NotBlank
    private String name;
}
