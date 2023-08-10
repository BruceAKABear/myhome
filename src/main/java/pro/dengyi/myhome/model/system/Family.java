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
 * @author BLab
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("family")
@ApiModel("家庭")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Family extends BaseModel {

    @ApiModelProperty(value = "天气appId")
    private String appId;

    @ApiModelProperty(value = "天气appSecret")
    private String appSecret;

    @ApiModelProperty(value = "家庭名")
    @NotBlank
    @Length(min = 3, max = 10)
    private String name;

    @ApiModelProperty(value = "经度")
    @NotBlank
    private String longitude;

    @ApiModelProperty(value = "维度")
    @NotBlank
    private String latitude;

}
