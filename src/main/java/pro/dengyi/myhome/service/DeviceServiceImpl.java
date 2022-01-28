package pro.dengyi.myhome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
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

    @Transactional
    @Override
    public void addUpdate(Device device) {
        //todo 其他什么处理？
        if (ObjectUtils.isEmpty(device.getId())) {
            //新增
            deviceDao.insert(device);
        } else {
            //更新
            deviceDao.updateById(device);
        }

    }

    @Transactional
    @Override
    public void delete(String id) {
        //todo 做其他判断
        deviceDao.deleteById(id);
    }
}
