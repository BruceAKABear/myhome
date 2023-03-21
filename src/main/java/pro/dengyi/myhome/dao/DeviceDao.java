package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.time.LocalDateTime;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.dto.DeviceControlLogDto;
import pro.dengyi.myhome.model.device.dto.DeviceDto;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.model.system.User;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
@Repository
public interface DeviceDao extends BaseMapper<Device> {

  IPage<DeviceDto> selectCustomPage(IPage<DeviceDto> page, @Param("floorId") String floorId,
      @Param("roomId") String roomId, @Param("categoryId") String categoryId);

  List<DeviceDto> listByRoomId(@Param("roomId") String roomId, @Param("user") User user,
      @Param("favorite") Boolean favorite);

  List<DeviceControlLogDto> deviceControlLog(@Param("userId") String userId,
      @Param("roomId") String roomId, @Param("deviceId") String deviceId,
      @Param("startTime") LocalDateTime startTime, @Param("endTime") LocalDateTime endTime,
      @Param("page") Integer page, @Param("size") Integer size);

  List<Room> selectAllRooms(@Param("userId") String id);
}
