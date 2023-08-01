package pro.dengyi.myhome.controller.automation;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.response.CommonResponse;
import pro.dengyi.myhome.common.response.DataResponse;
import pro.dengyi.myhome.model.automation.Scene;
import pro.dengyi.myhome.service.SceneService;

import javax.validation.constraints.NotBlank;
import java.util.List;
import java.util.Map;

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

//todo 相同条件不能存在
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
