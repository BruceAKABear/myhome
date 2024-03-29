package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.RoomDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.service.RoomService;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

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
    @Resource
    private Cache systemCache;


    @Transactional
    @Override
    public void addUpdate(Room room) {
        Room roomSaved = roomDao.selectOne(new LambdaQueryWrapper<Room>().eq(Room::getFamilyId, room.getFamilyId()).eq(Room::getFloorId, room.getFloorId()).eq(Room::getName, room.getName()));

        if (ObjectUtils.isEmpty(room.getId())) {
            if (roomSaved != null) {
                throw new BusinessException("room.add.name.exist");
            }
            Long size = roomDao.selectCount(new LambdaQueryWrapper<Room>().eq(Room::getFamilyId, room.getFamilyId()).eq(Room::getFloorId, room.getFloorId()));
            room.setSequence((int) (size + 1));
            room.setCreateTime(LocalDateTime.now());
            room.setUpdateTime(LocalDateTime.now());
            roomDao.insert(room);
        } else {
            if (roomSaved != null && !roomSaved.getId().equals(room.getId())) {
                throw new BusinessException("room.update.name.exist");
            }
            room.setUpdateTime(LocalDateTime.now());
            roomDao.updateById(room);
        }


    }

    @Transactional
    @Override
    public void delete(String id) {
        Long deviceCount = deviceDao.selectCount(new LambdaQueryWrapper<Device>().eq(Device::getRoomId, id));
        if (deviceCount != 0) {
            throw new BusinessException("room.delete.fail.contain.devices");
        }
        Room room = roomDao.selectById(id);

        systemCache.invalidate("roomList");
        systemCache.invalidate("roomListByFloorId:" + room.getFloorId());
        roomDao.deleteById(id);
    }

    @Override
    public IPage<RoomDto> page(Integer pageNumber, Integer pageSize, String floorId, String roomName, String familyId) {
        IPage<RoomDto> page = new Page<>(pageNumber == null ? 1 : pageNumber, pageSize == null ? 10 : pageSize);
        return roomDao.selectCustomPage(page, floorId, roomName, familyId);
    }

    @Override
    public List<Room> roomList(String floorId) {
        return roomDao.selectList(new LambdaQueryWrapper<Room>().eq(Room::getFloorId, floorId));
    }

    @Override
    public Object roomListByFloorId(String floorId) {
        return roomDao.selectList(new LambdaQueryWrapper<Room>().eq(Room::getFloorId, floorId));
    }
}
