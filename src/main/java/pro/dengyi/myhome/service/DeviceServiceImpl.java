package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.model.Device;
import pro.dengyi.myhome.model.dto.DeviceDto;

import java.util.List;

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
            //新增，默认离线，默认启用
            device.setEnable(true);
            device.setOnline(false);

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

    @Override
    public IPage<DeviceDto> page(Integer pageNumber, Integer pageSize, String floorId, String roomId, String categoryId) {
        IPage<DeviceDto> page = new Page<>(pageNumber == null ? 1 : pageNumber, pageSize == null ? 10 : pageSize);
        return deviceDao.selectCustomPage(page, floorId, roomId, categoryId);
    }

    @Override
    public List<Device> debugDeviceList() {
        return deviceDao.selectList(new LambdaQueryWrapper<>());
    }
}
