package pro.dengyi.myhome.controller.system;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.common.utils.UserHolder;
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
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @ApiOperation("分页查询")
    @GetMapping("/page")
    @Permission
    public IPage<User> page(Integer page, Integer size, String name) {
        return userService.page(page, size, name);
    }


    /**
     * 手机端登录永不过期
     * <p>
     * pc端一小时过期
     *
     * @param loginVo
     * @return
     */
    @ApiOperation("登录")
    @PostMapping("/login")
    @Permission(needLogIn = false, needValidate = false)
    public String login(@RequestBody @Validated LoginVo loginVo, HttpServletRequest request) {
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

    @ApiOperation("更新选择的语言")
    @PostMapping("/updateSelectLang")
    @Permission(needLogIn = false, needValidate = false)
    public void updateSelectLang(@RequestBody Map<String, String> langParam) {
        userService.updateSelectLang(langParam);

    }

    @ApiOperation("更新选中后的楼层房间")
    @PostMapping("/updateSelectRoom")
    @Permission(needValidate = false)
    public void updateSelectRoom(@RequestBody Map<String, String> roomParam) {
        roomParam.put("userId", UserHolder.getUser().getId());
        userService.updateSelectRoom(roomParam);

    }

    @ApiOperation("上报显示模式")
    @PostMapping("/updateDisplayMode")
    @Permission(needValidate = false)
    public void updateDisplayMode(@RequestBody Map<String, String> modeParam) {
        userService.updateDisplayMode(modeParam);

    }


    @ApiOperation("新增用户")
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
    public void updateUserInfo(@RequestBody @Validated Map<String, Object> updateUserInfo) {
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
    public void delete(@PathVariable @NotBlank(message = "ID不能为空") String id) {
        userService.delete(id);

    }


}
