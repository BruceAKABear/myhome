package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.model.system.Room;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface RoomService {

    void addUpdate(Room room);

    void delete(String id);

    IPage<RoomDto> page(Integer pageNumber, Integer pageSize, String floorId, String roomName, String familyId);

    List<Room> roomList(String floorId);

    Object roomListByFloorId(String floorId);
}
