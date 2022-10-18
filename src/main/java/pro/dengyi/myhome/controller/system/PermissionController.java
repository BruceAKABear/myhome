package pro.dengyi.myhome.controller.system;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.benmanes.caffeine.cache.Cache;
import io.swagger.annotations.Api;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.model.perm.PermissionFunction;
import pro.dengyi.myhome.model.perm.Role;
import pro.dengyi.myhome.model.perm.dto.PermissionDto;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.PermissionService;

/**
 * 权限controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-10-01
 */
@Api(tags = "系统信息接口")
@RestController
@RequestMapping("/permission")
public class PermissionController {

  @Autowired
  private Cache cache;

  @Autowired
  private PermissionService permissionService;


  @GetMapping("/getPerm")
  @Permission
  public DataResponse<PermissionDto> getPerm() {
    PermissionDto permissionDto = permissionService.getPerm();
    return new DataResponse<>(permissionDto);
  }

  @GetMapping("/allPermTree")
  @Permission
  public DataResponse<List<PermissionFunction>> allPermTree() {
    List<PermissionFunction> permissionFunctions = (List<PermissionFunction>) cache.get(
        "allPermTree", key -> {
          return permissionService.allPermTree();
        });
    return new DataResponse<>(permissionFunctions);
  }

  @GetMapping("/rolePage")
  @Permission
  public DataResponse<IPage<Role>> rolePage(Integer page, Integer size, String roleName) {
    IPage<Role> pageR = permissionService.rolePage(page, size, roleName);
    return new DataResponse<>(pageR);
  }

  @GetMapping("/roleList")
  @Permission
  public DataResponse<List<Role>> roleList() {
    List<Role> pageR = permissionService.roleList();
    return new DataResponse<>(pageR);
  }

  @PostMapping("/roleAdd")
  @Permission
  public CommonResponse roleAdd(@RequestBody Role role) {
    permissionService.roleAdd(role);
    return CommonResponse.success();
  }

  @DeleteMapping("/roleDel/{roleId}")
  @Permission
  public CommonResponse roleDel(@PathVariable String roleId) {
    permissionService.roleDel(roleId);
    return CommonResponse.success();
  }

}
