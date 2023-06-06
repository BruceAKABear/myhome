package pro.dengyi.myhome.model.base;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 实体类基类
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-05-29
 */
@Data
public class BaseModel {

    @ApiModelProperty(value = "分类Id", hidden = true)
    private String id;

    @ApiModelProperty(value = "创建时间", hidden = true)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "更新时间", hidden = true)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;

}
