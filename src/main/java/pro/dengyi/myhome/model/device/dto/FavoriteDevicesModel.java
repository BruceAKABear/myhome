package pro.dengyi.myhome.model.device.dto;

import java.util.List;
import lombok.Data;
import pro.dengyi.myhome.model.system.Room;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/27 16:27
 * @description：
 * @modified By：
 */
@Data
public class FavoriteDevicesModel {

  private Room room;

  private List<DeviceDto> deviceDtos;

}
