package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.DeviceLog;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
public interface DeviceLogService {
    IPage<DeviceLog> page(Integer pageNumber, Integer pageSize, String deviceId);
}
