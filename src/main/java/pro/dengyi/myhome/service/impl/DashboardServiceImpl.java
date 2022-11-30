package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.dengyi.myhome.controller.push.AppWebsocket;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.FloorDao;
import pro.dengyi.myhome.dao.RoomDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.dto.DashboardDto;
import pro.dengyi.myhome.service.DashboardService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-28
 */
@Service
public class DashboardServiceImpl implements DashboardService {

  @Autowired
  private UserDao userDao;

  @Autowired
  private FloorDao floorDao;
  @Autowired
  private RoomDao roomDao;
  @Autowired
  private DeviceDao deviceDao;

  @Override
  public DashboardDto dashboardInfo() {
    DashboardDto dashboardDto = new DashboardDto();
    dashboardDto.setUserCount(Math.toIntExact(userDao.selectCount(new QueryWrapper<>())));
    dashboardDto.setOnlineUserCount(AppWebsocket.ONLINE_DEVICES_COUNT.get());
    dashboardDto.setFamilyCount(1);
    dashboardDto.setFloorCount(Math.toIntExact(floorDao.selectCount(new QueryWrapper<>())));
    dashboardDto.setRoomCount(Math.toIntExact(roomDao.selectCount(new QueryWrapper<>())));
    dashboardDto.setDeviceCount(Math.toIntExact(deviceDao.selectCount(new QueryWrapper<>())));
    dashboardDto.setOnlineDeviceCount(Math.toIntExact(
        deviceDao.selectCount(new LambdaQueryWrapper<Device>().eq(Device::getOnline, true))));
    dashboardDto.setOfflineDeviceCount(Math.toIntExact(
        deviceDao.selectCount(new LambdaQueryWrapper<Device>().eq(Device::getOnline, false))));

    return dashboardDto;
  }
}
