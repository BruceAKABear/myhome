package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.model.system.Room;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Repository
public interface RoomDao extends BaseMapper<Room> {

  IPage<RoomDto> selectCustomPage(IPage<RoomDto> page, @Param("floorId") String floorId,
      @Param("roomName") String roomName);
}
