package pro.dengyi.myhome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.model.Device;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
@Service
public class DeviceServiceImpl implements DeviceService {
    @Autowired
    private DeviceDao deviceDao;

    @Override
    public Device selectById(String deviceId) {
        return deviceDao.selectById(deviceId);
    }
}
