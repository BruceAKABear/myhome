package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.dto.RoomDeviceTree;
import pro.dengyi.myhome.model.dto.DeviceDto;

import java.util.List;
import java.util.Map;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
public interface DeviceService {

  Device selectById(String deviceId);

  void addUpdate(Device device);

  void delete(String id);

  IPage<DeviceDto> page(Integer pageNumber, Integer pageSize, String floorId, String roomId,
      String categoryId);

  List<Device> debugDeviceList(String productId);

  void sendDebug(Map<String, Object> orderMap);

  void emqHook(Map<String, Object> params);

  void deviceOnline(String clientId);

  void singleDeviceFirmwareUpdate(DeviceDto deviceDto);

  void sendCmd(Map<String, Object> orderMap);

  List<RoomDeviceTree> roomDeviceTree(String floorId);

  List<Device> listByRoomId(String roomId);
}
