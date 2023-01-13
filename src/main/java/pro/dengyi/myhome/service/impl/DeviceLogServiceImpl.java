package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.dto.LogByConditionDto;
import pro.dengyi.myhome.service.DeviceLogService;

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
    IPage<DeviceLog> pageParam = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
    return deviceLogDao.selectPage(pageParam,
        new LambdaQueryWrapper<DeviceLog>().eq(DeviceLog::getDeviceId, deviceId)
            .orderByDesc(DeviceLog::getCreateTime));
  }

  @Override
  public List<LogByConditionDto> logByCondition(String deviceId, LocalDateTime startDateTime,
      LocalDateTime endDateTime, Integer step) {
    List<LogByConditionDto> logByConditionDtos = deviceLogDao.logByCondition(deviceId,
        startDateTime, endDateTime, step);
    if (!CollectionUtils.isEmpty(logByConditionDtos)) {
      List<LogByConditionDto> newArr = new ArrayList<>();
      for (int i = 0; i < logByConditionDtos.size(); i++) {
        if (i == 0) {
          newArr.add(logByConditionDtos.get(0));
        } else {
          LogByConditionDto pre = newArr.get(newArr.size() - 1);
          LogByConditionDto current = logByConditionDtos.get(i);
          if (Duration.between(pre.getDateTime(), current.getDateTime()).toMinutes() >= step) {
            newArr.add(current);
          }
        }
      }
      if (!CollectionUtils.isEmpty(newArr)) {
        logByConditionDtos = newArr;
      }
    }
    return logByConditionDtos;
  }

}
