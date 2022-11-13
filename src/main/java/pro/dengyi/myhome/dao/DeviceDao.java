package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.dto.DeviceDto;
import pro.dengyi.myhome.model.system.User;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
@Repository
public interface DeviceDao extends BaseMapper<Device> {

  IPage<DeviceDto> selectCustomPage(IPage<DeviceDto> page, @Param("floorId") String floorId,
      @Param("roomId") String roomId, @Param("categoryId") String categoryId);

  List<Device> listByRoomId(@Param("roomId") String roomId, @Param("user") User user);
}
