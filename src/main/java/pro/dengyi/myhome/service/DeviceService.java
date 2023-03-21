package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.dto.DeviceControlLogDto;
import pro.dengyi.myhome.model.device.dto.DeviceDto;
import pro.dengyi.myhome.model.device.dto.DeviceForScene;
import pro.dengyi.myhome.model.device.dto.FavoriteDevicesModel;
import pro.dengyi.myhome.model.device.dto.RoomDeviceTree;
import pro.dengyi.myhome.model.dto.ChangeFavoriteDto;

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

  List<DeviceDto> listByRoomId(String roomId, Boolean favorite);

  void changeFavorite(ChangeFavoriteDto favoriteDto);

  List<Map<String, Object>> mapModeLamps(String floorId);

  List<DeviceForScene> allDeviceList(String floorId, String roomId);

  List<DeviceControlLogDto> deviceControlLog(String userId, String roomId, String deviceId,
      LocalDateTime startTime, LocalDateTime endTime, Integer page, Integer size);

  List<FavoriteDevicesModel> favoriteDevices();

  void oneButton(Map<String, Object> orderMap);
}
