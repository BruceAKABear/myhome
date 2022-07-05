package pro.dengyi.myhome.listener;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.time.LocalDateTime;
import java.util.List;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.FamilyDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.Family;
import pro.dengyi.myhome.model.User;
import pro.dengyi.myhome.properties.SystemProperties;

/**
 * 项目启动监听
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Component
public class ApplicationRunListener implements ApplicationRunner {

  @Autowired
  private SystemProperties systemProperties;
  @Autowired
  private UserDao userDao;
  @Autowired
  private FamilyDao familyDao;


  @Transactional
  @Override
  public void run(ApplicationArguments args) throws Exception {
    System.err.println("系统已经初始化");
    //项目初始化
    Family family = familyDao.selectOne(new LambdaQueryWrapper<>());
    if (ObjectUtils.isEmpty(family)) {
      Family newFamily = new Family();
      newFamily.setName("我的家");
      familyDao.insert(newFamily);
    }
    List<User> userList = userDao.selectList(
        new LambdaQueryWrapper<User>().eq(User::getHouseHolder, true));
    if (CollectionUtils.isEmpty(userList)) {
      //初始化一个默认家庭
      //默认用户不存在，新增一个
      User user = new User();
      user.setName(systemProperties.getDefaultName());
      user.setAvatar(systemProperties.getDefaultAvatar());
      user.setEmail(systemProperties.getDefaultEmail());
      user.setPassw(systemProperties.getDefaultPassword());
      user.setHouseHolder(true);
      LocalDateTime now = LocalDateTime.now();
      user.setCreateTime(now);
      user.setUpdateTime(now);
      userDao.insert(user);
    }
  }

}
