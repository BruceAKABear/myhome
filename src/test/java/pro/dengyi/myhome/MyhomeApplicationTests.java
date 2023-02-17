package pro.dengyi.myhome;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.script.Invocable;
import javax.script.ScriptException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.PermUserDeviceDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.perm.PermUserDevice;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.utils.JavaScriptEngine;

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

}
