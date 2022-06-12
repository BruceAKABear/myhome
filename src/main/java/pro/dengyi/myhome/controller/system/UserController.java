package pro.dengyi.myhome.controller.system;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.validation.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.HolderPermission;
import pro.dengyi.myhome.model.User;
import pro.dengyi.myhome.model.vo.LoginVo;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.UserService;

/**
 * 用户controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Api(tags = "用户接口")
@RestController
@RequestMapping("/user")
public class UserController {

  @Autowired
  private UserService userService;

  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<User>> page(Integer page, Integer size, String name) {
    IPage<User> pageR = userService.page(page, size, name);
    return new DataResponse<>(pageR);
  }

  @ApiOperation("登录")
  @PostMapping("/login")
  public DataResponse<String> login(@RequestBody @Validated LoginVo loginVo) {
    String token = userService.login(loginVo);
    return new DataResponse<>(token);
  }

  @ApiOperation("更新个人信息")
  @PutMapping("/update")
  public CommonResponse update(@RequestBody @Validated User user) {
    userService.update(user);
    return CommonResponse.success();
  }

  @ApiOperation("查询个人信息")
  @GetMapping("/info")
  public DataResponse<User> info() {
    User user = userService.info();
    return new DataResponse<>(user);
  }


  @ApiOperation("新增用户")
  @PostMapping("/addOrUpdate")
  @HolderPermission
  public CommonResponse addOrUpdate(@RequestBody @Validated User user) {
    userService.addOrUpdate(user);
    return CommonResponse.success();
  }

  @ApiOperation("成员启停")
  @PostMapping("/enable")
  @HolderPermission
  public CommonResponse enable(@RequestBody @Validated User user) {
    userService.enable(user);
    return CommonResponse.success();
  }

  @ApiOperation("删除成员")
  @DeleteMapping("/delete/{id}")
  @HolderPermission
  public CommonResponse delete(@PathVariable @NotBlank(message = "ID不能为空") String id) {
    userService.delete(id);
    return CommonResponse.success();
  }


}
