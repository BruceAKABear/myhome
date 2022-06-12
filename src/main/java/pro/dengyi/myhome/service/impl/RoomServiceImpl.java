package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.RoomDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.Room;
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.service.RoomService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class RoomServiceImpl implements RoomService {

  @Autowired
  private RoomDao roomDao;
  @Autowired
  private DeviceDao deviceDao;

  @Transactional
  @Override
  public void addUpdate(Room room) {
    if (ObjectUtils.isEmpty(room.getId())) {
      Room roomSaved = roomDao.selectOne(
          new LambdaQueryWrapper<Room>().eq(Room::getFloorId, room.getFloorId())
              .eq(Room::getName, room.getName()));
      if (roomSaved != null) {
        throw new BusinessException(14001, "同楼层同名房间已存在");
      }
      roomDao.insert(room);
    } else {
      roomDao.updateById(room);
    }
  }

  @Transactional
  @Override
  public void delete(String id) {
    Long deviceCount = deviceDao.selectCount(
        new LambdaQueryWrapper<Device>().eq(Device::getRoomId, id));
    if (deviceCount!=0) {
      throw new BusinessException(14002, "房间下还存在设备");
    }
    roomDao.deleteById(id);
  }

  @Override
  public IPage<RoomDto> page(Integer pageNumber, Integer pageSize, String floorId,
      String roomName) {
    IPage<RoomDto> page = new Page<>(pageNumber == null ? 1 : pageNumber,
        pageSize == null ? 10 : pageSize);
    return roomDao.selectCustomPage(page, floorId, roomName);
  }

  @Override
  public List<Room> roomList() {
    return roomDao.selectList(new LambdaQueryWrapper<>());
  }
}
