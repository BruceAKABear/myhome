package pro.dengyi.myhome.common.threads;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import pro.dengyi.myhome.common.utils.PasswordUtil;
import pro.dengyi.myhome.common.utils.queue.DeviceLogQueue;
import pro.dengyi.myhome.common.utils.queue.RoomSelectQueue;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.FamilyDao;
import pro.dengyi.myhome.dao.OperationLogDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.system.Family;
import pro.dengyi.myhome.model.system.User;

import javax.annotation.PostConstruct;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executor;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/8 14:14
 * @description：
 * @modified By：
 */
@Slf4j
@Component
public class SystemInitializing {
    private static final String INITIAL_DATA_ID = "1";
    @Autowired
    private FamilyDao familyDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private Executor executor;
    @Autowired
    private OperationLogDao operationLogDao;
    @Autowired
    private DeviceLogDao deviceLogDao;


    @EventListener(ApplicationStartedEvent.class)
    @Async
    public void systemBoot() {
        List<Family> families = familyDao.selectList(null);
        if (CollectionUtils.isEmpty(families)) {
            //new family
            Family newFamily = new Family();
            newFamily.setId(INITIAL_DATA_ID);
            newFamily.setName("MyHome");
            newFamily.setCreateTime(LocalDateTime.now());
            newFamily.setUpdateTime(LocalDateTime.now());
            familyDao.insert(newFamily);
            //new admin user
            User newAdmin = new User();
            newAdmin.setId(INITIAL_DATA_ID);
            newAdmin.setName("BLab");
            newAdmin.setPassw(PasswordUtil.encodePassword("admin123"));
            newAdmin.setEmail("admin@myhome.com");
            newAdmin.setSuperAdmin(true);
            newAdmin.setAdmin(true);
            newAdmin.setEnable(true);
            newAdmin.setCreateTime(LocalDateTime.now());
            newAdmin.setUpdateTime(LocalDateTime.now());
            userDao.insert(newAdmin);
        }


        //设备日志队列
        executor.execute(() -> {
            while (true) {
                DeviceLog deviceLog = DeviceLogQueue.consume();
                deviceLogDao.insert(deviceLog);
            }
        });
        //用户选择上报
        executor.execute(() -> {
            while (true) {
                Map<String, String> params = RoomSelectQueue.consume();
                User user = userDao.selectById(params.get("userId"));
                user.setSelectedFloorId(params.get("floorId"));
                user.setSelectedRoomId(params.get("roomId"));
                userDao.updateById(user);
            }
        });


    }



}
