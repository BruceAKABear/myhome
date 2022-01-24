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
@TableName("floor")
@ApiModel("楼层")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Floor {

    @ApiModelProperty(value = "ID")
    private String id;

    @ApiModelProperty(value = "楼层名")
    @NotBlank
    @Length(max = 10)
    private String name;


}
