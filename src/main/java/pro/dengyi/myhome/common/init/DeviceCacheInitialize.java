package pro.dengyi.myhome.common.init;

import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.model.device.Device;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/12/13 15:12
 * @description：
 * @modified By：
 */
@Component
public class DeviceCacheInitialize {
    @Autowired
    private DeviceDao deviceDao;
    @Resource
    private Cache deviceCache;


    @EventListener(ApplicationReadyEvent.class)
    @Async
    public void initCache() {
        List<Device> devices = deviceDao.selectList(null);
        devices.forEach(device -> {
            deviceCache.put(device.getId(), device);
        });


    }
}
