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
@TableName("family_floor")
@ApiModel("楼层")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Floor extends BaseModel {

    @ApiModelProperty(value = "楼层名")
    @NotBlank
    @Length(min = 2, max = 10)
    private String name;

    @NotBlank(message = "家庭id不能为空")
    private String familyId;


}
