package pro.dengyi.myhome;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.pubsub.EventType;
import pro.dengyi.myhome.common.utils.JavaScriptEngine;
import pro.dengyi.myhome.common.utils.PasswordUtil;
import pro.dengyi.myhome.common.utils.PubSubUtil;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.PermUserDeviceDao;
import pro.dengyi.myhome.dao.SceneDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.perm.PermUserDevice;
import pro.dengyi.myhome.model.system.User;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@SpringBootTest(classes = MyhomeApplication.class, webEnvironment = WebEnvironment.DEFINED_PORT)
class MyhomeApplicationTests {

    @Autowired
    private UserDao userDao;
    @Autowired
    private DeviceDao deviceDao;
    @Autowired
    private PermUserDeviceDao permUserDeviceDao;


    @Test
    void contextLoads() {
        MemoryMXBean bean = ManagementFactory.getMemoryMXBean();

        MemoryUsage memoryUsage = bean.getHeapMemoryUsage();
        System.out.println(memoryUsage.getUsed());

        File[] roots = File.listRoots();// 获取磁盘分区列表

        for (File file : roots) {

            System.out.println(file.getPath() + "信息如下:");

            long free = file.getFreeSpace();

            long total = file.getTotalSpace();

            long use = total - free;

            System.out.println();

        }

    }


    @Test
    public void addDevice2User() {

        List<User> users = userDao.selectList(new LambdaQueryWrapper<>());

        List<Device> devices = deviceDao.selectList(new LambdaQueryWrapper<>());
        for (User user : users) {

            for (Device device : devices) {
                boolean exists = permUserDeviceDao.exists(
                        new LambdaQueryWrapper<PermUserDevice>().eq(PermUserDevice::getUserId, user.getId())
                                .eq(PermUserDevice::getDeviceId, device.getId()));
                if (!exists) {
                    PermUserDevice pud = new PermUserDevice();
                    pud.setDeviceId(device.getId());
                    pud.setUserId(user.getId());
                    pud.setCreateTime(LocalDateTime.now());
                    pud.setUpdateTime(LocalDateTime.now());
                    permUserDeviceDao.insert(pud);
                }
            }

        }

    }


    @Test
    public void testEngine() throws ScriptException, NoSuchMethodException {
        //1.  如果亮度传感器(哪一个亮度)小于一个值就开灯(哪一个灯)
        //2.  不能和人抢控制权（各种条件都满足的条件下，执行了某一个动作，如果此时人实际做了相反动作，联动情况将不能再次改变违反人抑制）
        //将要执行时，如果将要下发的和人为下发的冲突，将

//    String condi = "时间 >= 18:00 AND 人体传感器.有人 AND 光线传感器.亮度>=1000 ";

        Map<String, Object> prams = new HashMap<>();
        prams.put("lux", 100);
        JavaScriptEngine.engine.eval(
                "function doCal(triggerDevice, conditionRelation, conditionValue, conditionDeviceProperty) {\n"
                        + "    return eval(triggerDevice[conditionDeviceProperty] + conditionRelation + conditionValue)\n"
                        + "\n"
                        + "}\n");

        Invocable invocable = (Invocable) JavaScriptEngine.engine;
        Object o = invocable.invokeFunction("doCal", prams, ">", "100", "lux");
        System.out.println(o);
    }


//    @Test
//    public void syncUser() throws ClassNotFoundException, SQLException {
//        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        Connection connection = DriverManager.getConnection(
//                "jdbc:sqlserver://10.18.2.209\\GDC1CONCUR01:1433;database=PeopleSoft_Sync", "FF_USER",
//                "FF2021");
//
//        Statement statement = connection.createStatement();
//        ResultSet rs = statement.executeQuery(
//                "select  EMAIL,EMPLID,EMPNAME from  PS_EMP_NEW_VW where COMPANYID='261'");
//        List<Map<String, String>> list = new ArrayList<>();
//        while (rs.next()) {
//            Map<String, String> map = new HashMap<>();
//            ResultSetMetaData md = rs.getMetaData();
//            int columnCount = md.getColumnCount();
//            for (int i = 1; i <= columnCount; i++) {
//                map.put(md.getColumnName(i), (String) rs.getObject(i));
//            }
//            list.add(map);
//        }
//        rs.close();
//        connection.close();
//
//        List<String> ouids = new ArrayList<>();
//        List<User> oldUsers = userDao.selectList(new LambdaQueryWrapper<>());
//
//        if (!CollectionUtils.isEmpty(oldUsers)) {
//            for (User oldUser : oldUsers) {
//                ouids.add(oldUser.getId());
//            }
//
//        }
//
//        List<User> newUser = new ArrayList<>();
//        if (!CollectionUtils.isEmpty(list)) {
//            for (Map<String, String> newU : list) {
//                if (!ouids.contains(newU.get("EMPLID"))) {
//                    User user = new User();
//                    user.setId(newU.get("EMPLID"));
//                    user.setName(newU.get("EMPNAME"));
//                    user.setEmail(newU.get("EMAIL"));
//                    user.setCreateTime(LocalDateTime.now());
//                    user.setUpdateTime(LocalDateTime.now());
//                    user.setSuperAdmin(false);
//                    user.setEnable(true);
//                    user.setPassw(PasswordUtil.encodePassword("12345678"));
//                    newUser.add(user);
//                }
//
//            }
//        }
//
//        if (!CollectionUtils.isEmpty(newUser)) {
//            for (User user : newUser) {
//                if (!ObjectUtils.isEmpty(user.getEmail())) {
//                    userDao.insert(user);
//                }
//
//            }
//
//        }
//
//        System.out.println(list);
//
//    }


    @Test
    public void dynamicLogic() {
        /*
         * dynamic conditions parameter
         *
         * conditions:[
         * conditionGroup:{
         *
         * innerConditions:[
         * type:'device',
         * field:'open',
         *
         *
         * ]
         * }
         *
         * ]
         *
         *
         *
         *
         *
         * */


        ScriptEngine scriptEngine = new ScriptEngineManager().getEngineByName("JavaScript");

    }


    @Autowired
    private SceneDao sceneDao;

    @Test
    public void testResMap() {
        List<Scene> scenes = sceneDao.sceneListAndDetails();

        for (Scene scene : scenes) {
            System.out.println(scene);
        }


    }


    @Autowired
    private PubSubUtil pubSubUtil;

    @Test
    public void pubsubTest() throws InterruptedException {
        //理想状态下一个类型只能有一个线程处理
        Map<String, Object> param = new HashMap<>();
        param.put("type", "abc");
        pubSubUtil.publish(EventType.OPERATION_LOG, param);
        pubSubUtil.publish(EventType.DEVICE_REPORT, param);
        pubSubUtil.publish(EventType.NOTIFY_USER, param);

        pubSubUtil.publish(EventType.DEVICE_REPORT, param);
        TimeUnit.SECONDS.sleep(20);

    }


}
