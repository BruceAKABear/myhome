package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.PermUserDeviceDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.perm.PermUserDevice;
import pro.dengyi.myhome.model.system.User;
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
  @Autowired
  private PermUserDeviceDao permUserDeviceDao;


  @Override
  public String login(LoginVo loginVo) {
    User user = userDao.selectOne(
        new LambdaQueryWrapper<User>().eq(User::getEmail, loginVo.getEmail()));
    if (user != null) {
      if (!user.getEnable()) {
        throw new BusinessException(11001, "用户已停用不能登录");
      }
      if (PasswordUtil.match(loginVo.getPassword(), user.getPassw())) {
        return TokenUtil.genToken(user);
      } else {
        throw new BusinessException(11002, "邮箱或密码错误");
      }
    } else {
      throw new BusinessException(11003, "用户不存在");
    }
  }

  @Transactional
  @Override
  public void update(User user) {
    //密码为空则不更新密码
    if (!ObjectUtils.isEmpty(user.getPassw())) {
      String encodePassword = PasswordUtil.encodePassword(user.getPassw());
      user.setPassw(encodePassword);
    }
    userDao.updateById(user);
  }

  @Override
  public User info() {
    User user = userDao.selectById(UserHolder.getUser().getId());
    user.setPassw(null);
    return user;
  }

  @Transactional
  @Override
  public void addOrUpdate(User user) {
    if (ObjectUtils.isEmpty(user.getId())) {
      user.setEnable(true);
      LocalDateTime now = LocalDateTime.now();
      user.setCreateTime(now);
      user.setUpdateTime(now);
      user.setPassw(PasswordUtil.encodePassword(user.getPassw()));
      String language = LocaleContextHolder.getLocale().getLanguage();
      user.setSelectLang(language);
      //默认语言，获取当前的语言
      userDao.insert(user);
    } else {
      user.setUpdateTime(LocalDateTime.now());
      if (!ObjectUtils.isEmpty(user.getPassw())) {
        user.setPassw(PasswordUtil.encodePassword(user.getPassw()));
      }
      userDao.updateById(user);
    }
    //设备管理
    permUserDeviceDao.delete(
        new LambdaQueryWrapper<PermUserDevice>().eq(PermUserDevice::getUserId, user.getId()));
    for (String deviceId : user.getDeviceIds()) {
      PermUserDevice permUserDevice = new PermUserDevice();
      permUserDevice.setDeviceId(deviceId);
      permUserDevice.setUserId(user.getId());
      permUserDevice.setCreateTime(LocalDateTime.now());
      permUserDevice.setUpdateTime(LocalDateTime.now());
      permUserDeviceDao.insert(permUserDevice);
    }

  }

  @Override
  public IPage<User> page(Integer pageNumber, Integer pageSize, String name) {
    IPage<User> pageParam = new Page<>(pageNumber == null ? 1 : pageNumber,
        pageSize == null ? 10 : pageSize);
    IPage<User> userIPage = userDao.selectPage(pageParam,
        new LambdaQueryWrapper<User>().and(!(ObjectUtils.isEmpty(name)),
                userLambdaQueryWrapper -> userLambdaQueryWrapper.like(User::getName, name))
            .select(User::getId, User::getName, User::getAvatar, User::getEmail, User::getSex,
                User::getHeight, User::getWeight, User::getAge, User::getCreateTime,
                User::getUpdateTime, User::isSuperAdmin,User::getRoleId));

    for (User user : userIPage.getRecords()) {

      List<Object> objects = permUserDeviceDao.selectObjs(
          new LambdaQueryWrapper<PermUserDevice>().eq(PermUserDevice::getUserId, user.getId())
              .select(PermUserDevice::getDeviceId));
      for (Object object : objects) {
        if (user.getDeviceIds() == null) {
          user.setDeviceIds(new ArrayList<>());
        }
        user.getDeviceIds().add((String) object);
      }

    }

    return userIPage;
  }

  @Transactional
  @Override
  public void enable(User user) {
    User userSaved = userDao.selectById(user.getId());
    userSaved.setEnable(!userSaved.getEnable());
    userDao.updateById(userSaved);
  }

  @Transactional
  @Override
  public void delete(String id) {
    //不能删除
    if (UserHolder.getUser().getId().equals(id)) {
      throw new BusinessException(1, "不能删除自己");
    }
    userDao.deleteById(id);
  }

  @Transactional
  @Override
  public void updateSelectLang(Map<String, String> langParam) {
    User user = userDao.selectById(UserHolder.getUser().getId());
    user.setSelectLang(langParam.get("lang"));
    userDao.updateById(user);
  }
}
