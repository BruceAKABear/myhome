package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.service.DeviceLogService;
import pro.dengyi.myhome.model.device.DeviceLog;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Service
public class DeviceLogServiceImpl implements DeviceLogService {

  @Autowired
  private DeviceLogDao deviceLogDao;

  @Override
  public IPage<DeviceLog> page(Integer page, Integer size, String deviceId) {
    IPage<DeviceLog> pageParam = new Page<>(page == null ? 1 : page,
        size == null ? 10 : size);
    return deviceLogDao.selectPage(pageParam,
        new LambdaQueryWrapper<DeviceLog>().eq(DeviceLog::getDeviceId, deviceId)
            .orderByDesc(DeviceLog::getCreateTime));
  }
}
