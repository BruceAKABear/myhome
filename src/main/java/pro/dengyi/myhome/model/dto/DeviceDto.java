package pro.dengyi.myhome.model.dto;

import lombok.Data;
import pro.dengyi.myhome.model.device.Device;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-04
 */
@Data
public class DeviceDto extends Device {

  private String floorName;
  private String roomName;
  private String productName;
}
