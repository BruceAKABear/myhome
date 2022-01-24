package pro.dengyi.myhome.listener;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.User;
import pro.dengyi.myhome.properties.InitProperties;

import java.util.Date;
import java.util.List;

/**
 * 项目启动监听
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Component
public class ApplicationRunListener implements ApplicationRunner {
    @Autowired
    private InitProperties initProperties;

    @Autowired
    private UserDao userDao;

    @Transactional
    @Override
    public void run(ApplicationArguments args) throws Exception {
        //项目初始化

        List<User> userList = userDao.selectList(new LambdaQueryWrapper<User>().eq(User::getHouseHolder, true));
        if (CollectionUtils.isEmpty(userList)) {
            //默认用户不存在，新增一个
            User user = new User();
            user.setName(initProperties.getDefaultName());
            user.setAvatar(initProperties.getDefaultAvatar());
            user.setEmail(initProperties.getDefaultEmail());
            user.setPassword(initProperties.getDefaultPassword());
            user.setHouseHolder(true);
            user.setCreateTime(new Date());
            user.setUpdateTime(new Date());
            userDao.insert(user);
        }
    }

}
