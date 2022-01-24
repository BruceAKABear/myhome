package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 设备类别字段映射表
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@TableName("category_field")
@ApiModel("设备分类实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CategoryField {

    private String id;

    @ApiModelProperty(value = "分类Id")
    private String categoryId;

    @ApiModelProperty(value = "字段")
    @NotBlank(message = "字段不能为空")
    private String field;

    @ApiModelProperty(value = "字段类型")
    @NotBlank(message = "字段类型不能为空")
    private String fieldType;

}
