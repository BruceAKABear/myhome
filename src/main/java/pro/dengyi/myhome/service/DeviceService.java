package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.Device;
import pro.dengyi.myhome.model.dto.DeviceDto;

import java.util.List;
import java.util.Map;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
public interface DeviceService {
    Device selectById(String deviceId);

    void addUpdate(Device device);

    void delete(String id);

    IPage<DeviceDto> page(Integer pageNumber, Integer pageSize, String floorId, String roomId, String categoryId);

    List<Device> debugDeviceList();

    void sendDebug(Map<String, Object> orderMap);
}
