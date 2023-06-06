package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author DengYi
 * @version v1.0
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_user_favorite")
@ApiModel("用户收藏中间表")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DeviceUserFavorite extends BaseModel {

    @ApiModelProperty(value = "设备ID")
    private String deviceId;

    @ApiModelProperty(value = "用户ID")
    private String userId;
}
