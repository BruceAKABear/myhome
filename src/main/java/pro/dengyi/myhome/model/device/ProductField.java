package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

import javax.validation.constraints.NotBlank;

/**
 * 设备类别字段映射表
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_product_field")
@ApiModel("产品字段实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ProductField extends BaseModel {

    @ApiModelProperty(value = "产品Id")
    private String productId;

    @ApiModelProperty(value = "显示值")
    private String label;

    @ApiModelProperty(value = "字段")
    @NotBlank(message = "字段不能为空")
    private String field;

    //todo 可以删除所有的类型都用字符串
    @ApiModelProperty(value = "字段类型")
    @NotBlank(message = "字段类型不能为空")
    private String fieldType;

}
