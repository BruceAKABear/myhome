package pro.dengyi.myhome.common.threads;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.PermRoleDeviceDao;
import pro.dengyi.myhome.dao.PermUserDeviceDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.perm.PermRoleDevice;
import pro.dengyi.myhome.model.perm.PermUserDevice;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.common.utils.PasswordUtil;
import pro.dengyi.myhome.common.utils.SwitchUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/3/6 8:19
 * @description：人员同步线程
 * @modified By：
 */
@Slf4j
@Component
@EnableScheduling
public class UserSyncThread {

    @Autowired
    private UserDao userDao;
    @Autowired
    private Cache cache;
    @Autowired
    private PermRoleDeviceDao permRoleDeviceDao;
    @Autowired
    private PermUserDeviceDao permUserDeviceDao;


    @Async
    @Scheduled(cron = "0 0 2 * * ? ")
    @Transactional
    public void doSync() {

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection connection = DriverManager.getConnection(
                    "jdbc:sqlserver://10.18.2.209\\GDC1CONCUR01:1433;database=PeopleSoft_Sync", "FF_USER",
                    "FF2021");
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(
                    "select  EMAIL,EMPLID,EMPNAME from  PS_EMP_NEW_VW where COMPANYID='261'");
            List<Map<String, String>> ulist = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                ResultSetMetaData md = rs.getMetaData();
                int columnCount = md.getColumnCount();
                for (int i = 1; i <= columnCount; i++) {
                    map.put(md.getColumnName(i), (String) rs.getObject(i));
                }
                ulist.add(map);
            }
            rs.close();
            connection.close();

            List<String> ouids = new ArrayList<>();
            List<User> oldUsers = userDao.selectList(new LambdaQueryWrapper<>());
            if (!CollectionUtils.isEmpty(oldUsers)) {
                for (User oldUser : oldUsers) {
                    ouids.add(oldUser.getId());
                }

            }

            List<User> newUser = new ArrayList<>();
            if (!CollectionUtils.isEmpty(ulist)) {
                for (Map<String, String> newU : ulist) {
                    if (!ouids.contains(newU.get("EMPLID"))) {
                        User user = new User();
                        user.setId(newU.get("EMPLID"));
                        user.setName(newU.get("EMPNAME"));
                        user.setEmail(newU.get("EMAIL"));
                        user.setCreateTime(LocalDateTime.now());
                        user.setUpdateTime(LocalDateTime.now());
                        user.setSuperAdmin(false);
                        user.setEnable(true);
                        user.setPassw(PasswordUtil.encodePassword("12345678"));
                        //设置初始化角色为普通员工
                        user.setRoleId("1");
                        newUser.add(user);
                    }

                }
            }

            if (!CollectionUtils.isEmpty(newUser)) {
                for (User user : newUser) {
                    if (!ObjectUtils.isEmpty(user.getEmail())) {
                        userDao.insert(user);
                        List<String> deviceIds = (List<String>) cache.get("roleDvice:1",
                                (key) -> SwitchUtil.objToList(permRoleDeviceDao.selectObjs(
                                        new LambdaQueryWrapper<PermRoleDevice>().eq(PermRoleDevice::getRoleId, "1")
                                                .select(PermRoleDevice::getDeviceId)), String.class
                                ));

                        if (!CollectionUtils.isEmpty(deviceIds)) {
                            for (String deviceId : deviceIds) {
                                PermUserDevice userDevice = new PermUserDevice();
                                userDevice.setUserId(user.getId());
                                userDevice.setDeviceId(deviceId);
                                userDevice.setCreateTime(LocalDateTime.now());
                                userDevice.setUpdateTime(LocalDateTime.now());
                                permUserDeviceDao.insert(userDevice);
                            }

                        }


                    }

                }

            }


        } catch (ClassNotFoundException e) {
            log.error("驱动不存在异常:", e);
        } catch (SQLException e) {
            log.error("SQL不存在异常:", e);
        }


    }

}
