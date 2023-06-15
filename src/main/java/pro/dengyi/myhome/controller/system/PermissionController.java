package pro.dengyi.myhome.controller.system;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.benmanes.caffeine.cache.Cache;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.model.perm.PermissionFunction;
import pro.dengyi.myhome.model.perm.Role;
import pro.dengyi.myhome.model.perm.dto.PermissionDto;
import pro.dengyi.myhome.common.response.CommonResponse;
import pro.dengyi.myhome.common.response.DataResponse;
import pro.dengyi.myhome.service.PermissionService;

import java.util.List;

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


    @ApiOperation("获取个人权限")
    @GetMapping("/getPerm")
    @Permission
    public DataResponse<PermissionDto> getPerm() {
        PermissionDto permissionDto = permissionService.getPerm();
        return new DataResponse<>(permissionDto);
    }

    @ApiOperation("权限树")
    @GetMapping("/allPermTree")
    @Permission
    public DataResponse<List<PermissionFunction>> allPermTree() {
        List<PermissionFunction> permissionFunctions = (List<PermissionFunction>) cache.get(
                "allPermTree", key -> {
                    return permissionService.allPermTree();
                });
        return new DataResponse<>(permissionFunctions);
    }


    @ApiOperation("角色分页查询")
    @GetMapping("/rolePage")
    @Permission
    public DataResponse<IPage<Role>> rolePage(Integer page, Integer size, String roleName) {
        IPage<Role> pageR = permissionService.rolePage(page, size, roleName);
        return new DataResponse<>(pageR);
    }


    @ApiOperation("角色下拉列表")
    @GetMapping("/roleList")
    @Permission
    public DataResponse<List<Role>> roleList() {
        List<Role> pageR = permissionService.roleList();
        return new DataResponse<>(pageR);
    }


    @ApiOperation("添加角色")
    @PostMapping("/roleAdd")
    @Permission
    public CommonResponse roleAdd(@RequestBody Role role) {
        permissionService.roleAdd(role);
        return CommonResponse.success();
    }


    @ApiOperation("删除角色")
    @DeleteMapping("/roleDel/{roleId}")
    @Permission
    public CommonResponse roleDel(@PathVariable String roleId) {
        permissionService.roleDel(roleId);
        return CommonResponse.success();
    }

}
