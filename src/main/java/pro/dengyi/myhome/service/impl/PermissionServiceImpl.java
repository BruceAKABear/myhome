package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.PermissionFunctionDao;
import pro.dengyi.myhome.dao.RoleDao;
import pro.dengyi.myhome.dao.RolePermissionDao;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.model.perm.PermissionFunction;
import pro.dengyi.myhome.model.perm.Role;
import pro.dengyi.myhome.model.perm.RolePermission;
import pro.dengyi.myhome.model.perm.dto.PermissionDto;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.service.PermissionService;
import pro.dengyi.myhome.utils.UserHolder;

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
  private UserDao userDao;


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
      roleDao.insert(role);
    } else {
      role.setUpdateTime(LocalDateTime.now());
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
    Long userCount = userDao.selectCount(
        new LambdaQueryWrapper<User>().eq(User::getRoleId, roleId));
    if (userCount == 0) {
      roleDao.deleteById(roleId);
      rolePermissionDao.delete(
          new LambdaQueryWrapper<RolePermission>().eq(RolePermission::getRoleId, roleId));
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
