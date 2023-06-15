package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.*;
import pro.dengyi.myhome.model.perm.*;
import pro.dengyi.myhome.model.perm.dto.PermissionDto;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.service.PermissionService;
import pro.dengyi.myhome.common.utils.SwitchUtil;
import pro.dengyi.myhome.common.utils.UserHolder;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-10-01
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionFunctionDao permissionFunctionDao;
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private RolePermissionDao rolePermissionDao;
    @Autowired
    private PermRoleDeviceDao permRoleDeviceDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private PermUserDeviceDao permUserDeviceDao;


    @Override
    public PermissionDto getPerm() {
        PermissionDto permissionDto = new PermissionDto();
        List<PermissionFunction> permissionFunctions;
        List<String> buttons;
        if (UserHolder.getUser().isSuperAdmin()) {
            permissionFunctions = permissionFunctionDao.selectAllMenuFunction();
            buttons = permissionFunctionDao.selectAllButton();
        } else {
            permissionFunctions = permissionFunctionDao.selectAllMenuFunctionByPermission(
                    UserHolder.getUser());
            buttons = permissionFunctionDao.selectAllButtonByPermission(UserHolder.getUser());
        }

        List<PermissionFunction> firstMenu = new ArrayList<>();
        permissionFunctions.forEach(item -> {
            if (ObjectUtils.isEmpty(item.getParentId())) {
                iterSub(item, permissionFunctions);
                firstMenu.add(item);
            }
        });
        permissionDto.setMenuPerms(firstMenu);
        permissionDto.setButtonPerm(buttons);
        return permissionDto;
    }

    @Override
    public IPage<Role> rolePage(Integer page, Integer size, String roleName) {
        IPage<Role> pageP = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
        LambdaQueryWrapper<Role> roleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (!ObjectUtils.isEmpty(roleName)) {
            roleLambdaQueryWrapper.like(Role::getName, roleName);
        }
        IPage<Role> roleIPage = roleDao.selectPage(pageP, roleLambdaQueryWrapper);
        List<Role> records = roleIPage.getRecords();
        if (!CollectionUtils.isEmpty(records)) {
            for (Role role : records) {
                Long userCount = userDao.selectCount(
                        new LambdaQueryWrapper<User>().eq(User::getRoleId, role.getId()));
                role.setUserCount(userCount);
                List<Object> objects = rolePermissionDao.selectObjs(
                        new LambdaQueryWrapper<RolePermission>().eq(RolePermission::getRoleId, role.getId())
                                .select(RolePermission::getPermissionId));
                role.setPermIds(objects);

                List<Object> deviceIds = permRoleDeviceDao.selectObjs(
                        new LambdaQueryWrapper<PermRoleDevice>().eq(PermRoleDevice::getRoleId, role.getId())
                                .select(PermRoleDevice::getDeviceId));
                role.setDeviceIds(SwitchUtil.objToList(deviceIds, String.class));


            }

        }
        return roleIPage;
    }

    @Transactional
    @Override
    public void roleAdd(Role role) {
        if (ObjectUtils.isEmpty(role.getId())) {
            role.setCreateTime(LocalDateTime.now());
            role.setUpdateTime(LocalDateTime.now());
            role.setCanDel(true);
            roleDao.insert(role);
        } else {
            role.setUpdateTime(LocalDateTime.now());
            //todo 保证删除状态
            roleDao.updateById(role);
        }
        rolePermissionDao.delete(
                new LambdaQueryWrapper<RolePermission>().eq(RolePermission::getRoleId, role.getId()));
        List<Object> permIds = role.getPermIds();
        if (!CollectionUtils.isEmpty(permIds)) {
            for (Object permId : permIds) {
                RolePermission rolePermission = new RolePermission();
                rolePermission.setPermissionId((String) permId);
                rolePermission.setRoleId(role.getId());
                rolePermission.setCreateTime(LocalDateTime.now());
                rolePermission.setUpdateTime(LocalDateTime.now());
                rolePermissionDao.insert(rolePermission);
            }
        }

        //可控设备管理

        permRoleDeviceDao.delete(
                new LambdaQueryWrapper<PermRoleDevice>().eq(PermRoleDevice::getRoleId, role.getId()));
        for (String deviceId : role.getDeviceIds()) {
            PermRoleDevice permRoleDevice = new PermRoleDevice();
            permRoleDevice.setDeviceId(deviceId);
            permRoleDevice.setRoleId(role.getId());
            permRoleDevice.setCreateTime(LocalDateTime.now());
            permRoleDevice.setUpdateTime(LocalDateTime.now());
            permRoleDeviceDao.insert(permRoleDevice);
        }
        // 更新人设备

        List<User> users = userDao.selectList(
                new LambdaQueryWrapper<User>().eq(User::getRoleId, role.getId()));

        if (!CollectionUtils.isEmpty(users)) {
            for (User user : users) {
                permUserDeviceDao.delete(
                        new LambdaQueryWrapper<PermUserDevice>().eq(PermUserDevice::getUserId, user.getId()));
                List<String> deviceIds = role.getDeviceIds();
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

    @Override
    public List<PermissionFunction> allPermTree() {
        List<PermissionFunction> permissionFunctions = permissionFunctionDao.selectList(
                new LambdaQueryWrapper<>());
        List<PermissionFunction> firstMenu = new ArrayList<>();
        permissionFunctions.forEach(item -> {
            if (ObjectUtils.isEmpty(item.getParentId())) {
                iterSub(item, permissionFunctions);
                firstMenu.add(item);
            }
        });
        return firstMenu;
    }

    @Transactional
    @Override
    public void roleDel(String roleId) {
        if ("1".equals(roleId)) {
            return;
        }
        if ("1632628475547410434".equals(roleId)) {
            return;
        }

        Long userCount = userDao.selectCount(
                new LambdaQueryWrapper<User>().eq(User::getRoleId, roleId));
        if (userCount == 0) {
            roleDao.deleteById(roleId);
            rolePermissionDao.delete(
                    new LambdaQueryWrapper<RolePermission>().eq(RolePermission::getRoleId, roleId));
            //删除角色设备
            permRoleDeviceDao.delete(
                    new LambdaQueryWrapper<PermRoleDevice>().eq(PermRoleDevice::getRoleId, roleId));
            //删除人员角色绑定

//      userDao.upda
        }

    }

    @Override
    public List<Role> roleList() {
        return roleDao.selectList(null);
    }

    private void iterSub(PermissionFunction firstMenu, List<PermissionFunction> permissionFunctions) {
        permissionFunctions.forEach(item -> {
            if (!ObjectUtils.isEmpty(item.getParentId())) {
                if (item.getParentId().equals(firstMenu.getId())) {
                    if (firstMenu.getChildren() == null) {
                        firstMenu.setChildren(new ArrayList<>());
                    }
                    firstMenu.getChildren().add(item);
                    iterSub(item, permissionFunctions);
                }
            }
        });

    }
}
