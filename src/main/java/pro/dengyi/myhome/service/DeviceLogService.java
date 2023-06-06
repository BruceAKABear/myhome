package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.dto.LogByConditionDto;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
public interface DeviceLogService {

    IPage<DeviceLog> page(Integer page, Integer size, String deviceId);

    List<LogByConditionDto> logByCondition(String deviceId, LocalDateTime startDateTime,
                                           LocalDateTime endDateTime, Integer step);
}
