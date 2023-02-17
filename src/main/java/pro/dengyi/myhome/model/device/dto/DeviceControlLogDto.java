package pro.dengyi.myhome.model.device.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.time.LocalDateTime;
import lombok.Data;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/6 10:06
 * @description：
 * @modified By：
 */
@Data
public class DeviceControlLogDto {

  private String userName;

  private String userId;


  private String deviceId;
  private String deviceName;

  private String controlPayload;

  private String floorId;
  private String floorName;

  private String roomId;
  private String roomName;

  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime opTime;


}
