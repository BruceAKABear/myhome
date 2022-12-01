package pro.dengyi.myhome.controller.system;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.HashMap;
import java.util.Map;
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
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.dao.UserDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.model.system.dto.DDLoginDto;
import pro.dengyi.myhome.model.vo.LoginVo;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.DDService;
import pro.dengyi.myhome.service.UserService;
import pro.dengyi.myhome.utils.TokenUtil;

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
  @Autowired
  private DDService ddService;
  @Autowired
  private UserDao userDao;

  @ApiOperation("分页查询")
  @GetMapping("/page")
  @Permission
  public DataResponse<IPage<User>> page(Integer page, Integer size, String name) {
    IPage<User> pageR = userService.page(page, size, name);
    return new DataResponse<>(pageR);
  }

  @ApiOperation("登录")
  @PostMapping("/login")
  @Permission(needLogIn = false, needValidate = false)
  public DataResponse<String> login(@RequestBody @Validated LoginVo loginVo) {
    String token = userService.login(loginVo);
    return new DataResponse<>(token);
  }

  @ApiOperation("更新个人信息")
  @PutMapping("/update")
  @Permission(needValidate = false)
  public CommonResponse update(@RequestBody @Validated User user) {
    userService.update(user);
    return CommonResponse.success();
  }

  @ApiOperation("查询个人信息")
  @GetMapping("/info")
  @Permission(needValidate = false)
  public DataResponse<User> info() {
    User user = userService.info();
    return new DataResponse<>(user);
  }

  @ApiOperation("更新选择的语言")
  @PostMapping("/updateSelectLang")
  @Permission(needLogIn = false, needValidate = false)
  public CommonResponse updateSelectLang(@RequestBody Map<String, String> langParam) {
    userService.updateSelectLang(langParam);
    return CommonResponse.success();
  }

  @ApiOperation("更新选中后的楼层房间")
  @PostMapping("/updateSelectRoom")
  @Permission(needValidate = false)
  public CommonResponse updateSelectRoom(@RequestBody Map<String, String> roomParam) {
    userService.updateSelectRoom(roomParam);
    return CommonResponse.success();
  }


  @ApiOperation("新增用户")
  @PostMapping("/addOrUpdate")
  @Permission
  public CommonResponse addOrUpdate(@RequestBody @Validated User user) {
    userService.addOrUpdate(user);
    return CommonResponse.success();
  }

  @ApiOperation("更新个人信息")
  @PostMapping("/updateUserInfo")
  @Permission(needValidate = false)
  public CommonResponse updateUserInfo(@RequestBody @Validated Map<String, Object> updateUserInfo) {
    userService.updateUserInfo(updateUserInfo);
    return CommonResponse.success();
  }

  @ApiOperation("成员启停")
  @PostMapping("/enable")
  @Permission
  public CommonResponse enable(@RequestBody @Validated User user) {
    userService.enable(user);
    return CommonResponse.success();
  }

  @ApiOperation("删除成员")
  @DeleteMapping("/delete/{id}")
  @Permission
  public CommonResponse delete(@PathVariable @NotBlank(message = "ID不能为空") String id) {
    userService.delete(id);
    return CommonResponse.success();
  }


  @Permission(needLogIn = false, needValidate = false)
  @ApiOperation("钉钉登录")
  @PostMapping("/ddLogin")
  public DataResponse<String> ddLogin(@RequestBody DDLoginDto dto) {
    String appKey = "dingimugdoep70jqwgai";
    String appSecret = "39KG2ZIQR_qGMN2yUNEQyqAFZXE_c00QKBJVrIL9bEwGlkMHenGkG3GWX27vkkk0";
    HashMap<String, Object> tokenMap = ddService.getAccessToken(appKey, appSecret);
    String accessToken = (String) tokenMap.get("access_token");

    HashMap<String, String> userInfoParam = new HashMap<>(1);
    userInfoParam.put("code", dto.getCode());
    HashMap<String, Object> userinfoMap = ddService.userInfo(accessToken, userInfoParam);
    Map<String, String> result = (Map<String, String>) userinfoMap.get("result");
    String userid = result.get("userid");
    User user = userDao.selectById(userid);
    if (user == null) {
      throw new BusinessException(10007, "钉钉登录时用户没在系统中");
    }
    user.setPassw(null);
    String token = TokenUtil.genToken(user);
    return new DataResponse<>(token);
  }


}
