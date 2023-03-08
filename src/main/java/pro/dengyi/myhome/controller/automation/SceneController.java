package pro.dengyi.myhome.controller.automation;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import java.util.Map;
import javax.validation.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.SceneService;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/10 10:48
 * @description：场景controller
 * @modified By：
 */

@Api(tags = "场景接口")
@Validated
@RestController
@RequestMapping("/scene")
public class SceneController {

  @Autowired
  private SceneService sceneService;


  @ApiOperation("新增或修改场景")
  @PostMapping("/addOrUpdate")
  public CommonResponse addOrUpdate(@RequestBody Scene scene) {
    sceneService.addOrUpdate(scene);
    return CommonResponse.success();

  }

  @ApiOperation("查询供修改")
  @GetMapping("/queryForUpdate")
  public DataResponse<Scene> queryForUpdate(@RequestParam String sceneId) {
    Scene scene = sceneService.queryForUpdate(sceneId);
    return new DataResponse<>(scene);

  }

  @ApiOperation("场景启停")
  @PostMapping("/changeEnable")
  public CommonResponse changeEnable(@RequestBody Map<String, Object> params) {
    sceneService.changeEnable(params);
    return CommonResponse.success();

  }

  @ApiOperation("删除场景")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
    sceneService.delete(id);
    return CommonResponse.success();
  }

  @ApiOperation("列表")
  @GetMapping("/list")
  public DataResponse<List<Scene>> list() {
    List<Scene> list = sceneService.list();
    return new DataResponse<>(list);
  }


}
