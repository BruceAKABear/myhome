package pro.dengyi.myhome.controller.system;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.model.vo.LoginVo;
import pro.dengyi.myhome.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotBlank;
import java.util.Map;

/**
 * 用户controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Slf4j
@Api(tags = "用户接口")
@Permission
@RestController
@RequestMapping("/user")
@Validated
public class UserController {

    @Autowired
    private UserService userService;

    @ApiOperation("分页查询")
    @GetMapping("/page")
    @Permission
    public IPage<User> page(Integer page, Integer size, String name,
                            String familyId) {
        return userService.page(page, size, name, familyId);
    }

    @ApiOperation("登录，pc端1小时过期，手机端永不过期")
    @PostMapping("/login")
    @Permission(needLogIn = false, needValidate = false)
    public String login(@RequestBody @Validated LoginVo loginVo,
                        HttpServletRequest request) {
        return userService.login(loginVo, request);
    }

    @ApiOperation("退出")
    @GetMapping("/logout")
    public void logout() {
        userService.logout();
    }

    @ApiOperation("更新个人信息")
    @PutMapping("/update")
    @Permission(needValidate = false)
    public void update(@RequestBody @Validated User user) {
        userService.update(user);
    }

    @ApiOperation("查询个人信息")
    @GetMapping("/info")
    @Permission(needValidate = false)
    public User info() {
        return userService.info();
    }

    @ApiOperation("上报选择的语言")
    @GetMapping("/updateSelectLang")
    public void updateSelectLang(
            @NotBlank(message = "lang can not be blank") String lang) {
        userService.updateLang(lang);
    }

    @ApiOperation("上报选择的家庭")
    @GetMapping("/updateSelectFamily")
    @Permission(needValidate = false)
    public void updateSelectFamily(
            @NotBlank(message = "family can not be blank") String familyId) {
        userService.updateSelectFamily(familyId);

    }

    @ApiOperation("上报选择的楼层")
    @GetMapping("/updateSelectFloor")
    @Permission(needValidate = false)
    public void updateSelectFloor(
            @NotBlank(message = "floor can not be blank") String floorId) {
        userService.updateSelectFloor(floorId);

    }

    @ApiOperation("上报选择的")
    @GetMapping("/updateSelectRoom")
    @Permission(needValidate = false)
    public void updateSelectRoom(
            @NotBlank(message = "room can not be blank") String roomId) {
        userService.updateSelectRoom(roomId);

    }

    @ApiOperation("新增或修改用户")
    @PostMapping("/addOrUpdate")
    @Permission
    public void addOrUpdate(@RequestBody @Validated User user) {
        userService.addOrUpdate(user);

    }

    @ApiOperation("强制踢用户下线")
    @PostMapping("/kickOut")
    @Permission
    public void kickOut(@RequestBody User user) {
        userService.kickOut(user);
    }

    @ApiOperation("更新个人信息")
    @PostMapping("/updateUserInfo")
    @Permission(needValidate = false)
    public void updateUserInfo(
            @RequestBody @Validated Map<String, Object> updateUserInfo) {
        userService.updateUserInfo(updateUserInfo);
    }

    @ApiOperation("成员启停")
    @PostMapping("/enable")
    @Permission
    public void enable(@RequestBody @Validated User user) {
        userService.enable(user);
    }

    @ApiOperation("删除成员")
    @DeleteMapping("/delete/{id}")
    @Permission
    public void delete(
            @PathVariable @NotBlank(message = "ID不能为空") String id) {
        userService.delete(id);
    }


}
