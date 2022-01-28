package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.User;
import pro.dengyi.myhome.model.vo.LoginVo;
import pro.dengyi.myhome.service.UserService;
import pro.dengyi.myhome.utils.PasswordUtil;
import pro.dengyi.myhome.utils.TokenUtil;
import pro.dengyi.myhome.utils.UserHolder;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;


    @Override
    public String login(LoginVo loginVo) {
        User user = userDao.selectOne(new LambdaQueryWrapper<User>().eq(User::getEmail, loginVo.getEmail()));
        if (user != null) {
            if (PasswordUtil.match(loginVo.getPassword(), user.getPassword())) {
                return TokenUtil.genToken(user);
            } else {
                throw new BusinessException(11002, "邮箱或密码错误");
            }
        } else {
            throw new BusinessException(11001, "用户不存在");
        }
    }

    @Transactional
    @Override
    public void update(User user) {
        //密码为空则不更新密码
        if (!ObjectUtils.isEmpty(user.getPassword())) {
            String encodePassword = PasswordUtil.encodePassword(user.getPassword());
            user.setPassword(encodePassword);
        }
        userDao.updateById(user);
    }

    @Override
    public User info() {
        User user = userDao.selectById(UserHolder.getUserId());
        user.setPassword(null);
        return user;
    }

    @Transactional
    @Override
    public void add(User user) {
        userDao.insert(user);

    }
}
