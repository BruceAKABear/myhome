package pro.dengyi.myhome.model.device.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.ProductField;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 设备新增数据传输实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@ApiModel("产品新增实体")
public class ProductAddDto extends Product {


    @ApiModelProperty(value = "分类控制字段")
    @TableField(exist = false)
    @NotNull(message = "控制字段不能为空")
    private List<ProductField> productFields;

}
