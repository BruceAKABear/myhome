package pro.dengyi.myhome.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author DengYi
 * @version v1.0
 */
@Data
@ApiModel("用户收藏设备中间表")
public class UserFavoriteMiddle {

  @ApiModelProperty(value = "id")
  private String id;

  @ApiModelProperty(value = "楼层ID")
  private String floorId;

  @ApiModelProperty(value = "房间ID")
  private String roomId;

  @ApiModelProperty(value = "设备ID")
  private String deviceId;

  @ApiModelProperty(value = "用户ID")
  private String userId;
}
