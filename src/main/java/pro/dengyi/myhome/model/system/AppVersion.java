package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 楼层实体
 *
 * @author BLab
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("system_app_version")
@ApiModel("app版本")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AppVersion extends BaseModel {

    private String version;
    private Integer versionCode;
    private String updateType;
    private String wgetUrl;
    private String note;
}
