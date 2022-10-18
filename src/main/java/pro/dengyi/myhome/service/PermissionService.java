package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import pro.dengyi.myhome.model.perm.PermissionFunction;
import pro.dengyi.myhome.model.perm.Role;
import pro.dengyi.myhome.model.perm.dto.PermissionDto;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-10-01
 */
public interface PermissionService {

  PermissionDto getPerm();

  IPage<Role> rolePage(Integer page, Integer size, String roleName);

  void roleAdd(Role roleAddDto);

  List<PermissionFunction> allPermTree();

  void roleDel(String roleId);

  List<Role> roleList();
}
