package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.Device;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
public interface DeviceService {
    Device selectById(String deviceId);

    void addUpdate(Device device);

    void delete(String id);
}
