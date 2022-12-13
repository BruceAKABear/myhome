package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.RoomDao;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.service.LocationService;
import pro.dengyi.myhome.utils.PushUtil;
import pro.dengyi.myhome.utils.UserHolder;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/28 11:11
 * @description：
 * @modified By：
 */
@Service
public class LocationServiceImpl implements LocationService {

  @Autowired
  private RoomDao roomDao;

  @Override
  public void checkLocation(String beaconUuid) {
    if (!ObjectUtils.isEmpty(beaconUuid)) {
      Room room = roomDao.selectOne(
          new LambdaQueryWrapper<Room>().eq(Room::getBeaconUuid, beaconUuid).last("limit 1"));
      if (room != null) {
        String floorId = room.getFloorId();
        String roomId = room.getId();
        //推送
        PushUtil.positionPush(UserHolder.getUser().getId(), floorId, roomId);
      }
    }
  }
}
