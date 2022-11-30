package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.time.LocalDateTime;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Data
@Builder
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_log")
@ApiModel("设备消息实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DeviceLog extends BaseModel {

  @ApiModelProperty(value = "产品ID")
  private String productId;

  @ApiModelProperty(value = "设备ID")
  private String deviceId;

  @ApiModelProperty(value = "对列名")
  private String topicName;

  @ApiModelProperty(value = "数据内容")
  private String payload;

  @ApiModelProperty(value = "数据流向：down平台下发，up设备上报")
  private String direction;


  public DeviceLog(String productId, String deviceId, String topicName, String payload,
      String direction) {
    this.productId = productId;
    this.deviceId = deviceId;
    this.topicName = topicName;
    this.payload = payload;
    this.direction = direction;
    this.setCreateTime(LocalDateTime.now());
    this.setUpdateTime(LocalDateTime.now());
  }
}
