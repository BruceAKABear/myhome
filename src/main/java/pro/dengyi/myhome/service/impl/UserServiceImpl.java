package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.config.properties.UserProperties;
import pro.dengyi.myhome.common.enums.UserUpdateSelectEnum;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.common.pubsub.EventTypeEnum;
import pro.dengyi.myhome.common.pubsub.PubAndSubService;
import pro.dengyi.myhome.common.utils.PasswordUtil;
import pro.dengyi.myhome.common.utils.SwitchUtil;
import pro.dengyi.myhome.common.utils.UserHolder;
import pro.dengyi.myhome.common.utils.UserUtil;
import pro.dengyi.myhome.dao.PermRoleDeviceDao;
import pro.dengyi.myhome.dao.PermUserDeviceDao;
import pro.dengyi.myhome.dao.RoleDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.perm.PermRoleDevice;
import pro.dengyi.myhome.model.perm.PermUserDevice;
import pro.dengyi.myhome.model.pubsub.UserUpdateSelectDto;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.model.vo.LoginVo;
import pro.dengyi.myhome.service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private UserProperties userProperties;

    @Autowired
    private PermUserDeviceDao permUserDeviceDao;
    @Resource
    private Cache systemCache;
    @Autowired
    private PermRoleDeviceDao permRoleDeviceDao;
    @Autowired
    private PubAndSubService pubAndSubService;


    @Override
    public String login(LoginVo loginVo, HttpServletRequest request) {
        User user = userDao.selectOne(
                new LambdaQueryWrapper<User>().eq(User::getEmail,
                        loginVo.getEmail()));
        if (user != null) {
            if (!user.getEnable()) {
                throw new BusinessException("system.login.user.disable");
            }
            if (PasswordUtil.match(loginVo.getPassword(), user.getPassw())) {
                return UserUtil.genToken(user);
            } else {
                throw new BusinessException(
                        "system.login.usernameorpassworderror");
            }
        } else {
            throw new BusinessException("system.login.usernotexist");
        }
    }

    @Transactional
    @Override
    public void update(User user) {
        //密码为空则不更新密码
        if (!ObjectUtils.isEmpty(user.getPassw())) {
            String encodePassword = PasswordUtil.encodePassword(
                    user.getPassw());
            user.setPassw(encodePassword);
        }
        userDao.updateById(user);
        //更新可控设备
        permUserDeviceDao.delete(new LambdaQueryWrapper<PermUserDevice>().eq(
                PermUserDevice::getUserId, user.getId()));
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
            user.setSuperAdmin(false);
            user.setEnable(true);
            LocalDateTime now = LocalDateTime.now();
            user.setCreateTime(now);
            user.setUpdateTime(now);
            //为空则设置默认密码，如果不配置默认密码为12345678
            if (ObjectUtils.isEmpty(user.getPassw())) {
                user.setPassw(userProperties.getDefaultPassword());
            }
            user.setPassw(PasswordUtil.encodePassword(user.getPassw()));
            //默认语言，获取当前的语言
            String language = LocaleContextHolder.getLocale().getLanguage();
            user.setSelectLang(language);
            userDao.insert(user);
        } else {
            user.setUpdateTime(LocalDateTime.now());
            //更新个人信息时，密码为空则不修改密码
            if (!ObjectUtils.isEmpty(user.getPassw())) {
                user.setPassw(PasswordUtil.encodePassword(user.getPassw()));
            }
            userDao.updateById(user);
        }
        //设备管理
        permUserDeviceDao.delete(new LambdaQueryWrapper<PermUserDevice>().eq(
                PermUserDevice::getUserId, user.getId()));
        //todo

        List<String> deviceIds = (List<String>) systemCache.get(
                "roleDvice:", (key) -> SwitchUtil.objToList(
                        permRoleDeviceDao.selectObjs(
                                new LambdaQueryWrapper<PermRoleDevice>().eq(
                                                PermRoleDevice::getRoleId, "1")
                                        .select(PermRoleDevice::getDeviceId)),
                        String.class));

        //todo
        for (String deviceId : deviceIds) {
            PermUserDevice permUserDevice = new PermUserDevice();
            permUserDevice.setDeviceId(deviceId);
            permUserDevice.setUserId(user.getId());
            permUserDevice.setCreateTime(LocalDateTime.now());
            permUserDevice.setUpdateTime(LocalDateTime.now());
            permUserDeviceDao.insert(permUserDevice);
        }

    }

    @Override
    public IPage<User> page(Integer pageNumber, Integer pageSize, String name,
                            String familyId) {
        IPage<User> pageParam = new Page<>(pageNumber == null ? 1 : pageNumber,
                pageSize == null ? 10 : pageSize);
        IPage<User> userIPage = userDao.selectPage(pageParam,
                new LambdaQueryWrapper<User>().and(!(ObjectUtils.isEmpty(name)),
                                userLambdaQueryWrapper -> userLambdaQueryWrapper.like(
                                        User::getName, name))
                        .select(User::getId, User::getName, User::getAvatar,
                                User::getEmail, User::getGender,
                                User::getHeight, User::getWeight, User::getAge,
                                User::getCreateTime, User::getUpdateTime,
                                User::getSuperAdmin, User::getEnable));

        for (User user : userIPage.getRecords()) {

            List<Object> objects = permUserDeviceDao.selectObjs(
                    new LambdaQueryWrapper<PermUserDevice>().eq(
                                    PermUserDevice::getUserId, user.getId())
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
        userSaved.setEnable(user.getEnable());
        userDao.updateById(userSaved);
    }

    /**
     * 删除用户功能
     * <p>
     * 1. 只有管理员及超级管理员可用
     * 2. 自己不能删除自己
     * 3. 管理员不能删除超级管理员
     *
     * @param id
     */
    @Transactional
    @Override
    public void delete(String id) {
        User user = userDao.selectById(id);
        if (UserHolder.getUser().getId().equals(id)) {
            throw new BusinessException("user.delete.cannotdeleteyourself");
        }
        if (user.getSuperAdmin()) {
            throw new BusinessException("user.delete.cannotdeletesuperadmin");
        }
        userDao.deleteById(id);
        //todo 删除设备关联
        permUserDeviceDao.delete(new LambdaQueryWrapper<PermUserDevice>().eq(
                PermUserDevice::getUserId, id));
    }


    @Transactional
    @Override
    public void updateSelectLang(Map<String, String> langParam) {
        //todo handle this logic in queue
        User user = userDao.selectById(UserHolder.getUser().getId());
        user.setSelectLang(langParam.get("lang"));
        userDao.updateById(user);
    }

    @Transactional
    @Override
    public void updateUserInfo(Map<String, Object> updateUserInfo) {
        User user = userDao.selectById((String) updateUserInfo.get("id"));
        user.setAvatar((String) updateUserInfo.get("avatar"));
        user.setName((String) updateUserInfo.get("name"));
        String pass = (String) updateUserInfo.get("passw");
        if (!ObjectUtils.isEmpty(pass)) {
            String encodePassword = PasswordUtil.encodePassword(pass);
            user.setPassw(encodePassword);
        }
        userDao.updateById(user);
    }


    @Override
    public void kickOut(User user) {
        if (!UserHolder.getUser().getSuperAdmin() && !UserHolder.getUser()
                .getAdmin()) {
            throw new BusinessException(1, "you can not call this method");
        }
        //自己不能踢自己，退出就可以了
        if (UserHolder.getUser().getId().equals(user.getId())) {
            throw new BusinessException(1, "自己不能踢自己");
        }
        //超管踢任何人，任何人都不能踢超管，管理员可以踢其他人
        User userForKick = userDao.selectById(user.getId());
        if (userForKick.getSuperAdmin()) {
            throw new BusinessException(1, "you can not kick out super admin");
        }

    }

    @Override
    public void logout() {
        User user = UserHolder.getUser();
        UserUtil.kickOut(user.getId());
    }

    @Override
    public void updateSelectFamily(String familyId) {
        pubAndSubService.publish(EventTypeEnum.USER_UPDATE_SELECT,
                new UserUpdateSelectDto(UserHolder.getUser().getId(),
                        UserUpdateSelectEnum.SELECT_FAMILY, familyId));
    }

    @Override
    public void updateLang(String lang) {
        pubAndSubService.publish(EventTypeEnum.USER_UPDATE_SELECT,
                new UserUpdateSelectDto(UserHolder.getUser().getId(),
                        UserUpdateSelectEnum.SELECT_LANG, lang));
    }

    @Override
    public void updateSelectFloor(String floorId) {
        pubAndSubService.publish(EventTypeEnum.USER_UPDATE_SELECT,
                new UserUpdateSelectDto(UserHolder.getUser().getId(),
                        UserUpdateSelectEnum.SELECT_FLOOR, floorId));
    }

    @Override
    public void updateSelectRoom(String roomId) {
        pubAndSubService.publish(EventTypeEnum.USER_UPDATE_SELECT,
                new UserUpdateSelectDto(UserHolder.getUser().getId(),
                        UserUpdateSelectEnum.SELECT_ROOM, roomId));
    }


}
