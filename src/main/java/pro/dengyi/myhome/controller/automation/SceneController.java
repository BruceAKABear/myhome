package pro.dengyi.myhome.controller.automation;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
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

    @ApiOperation("新增或修改场景")
    @PostMapping("/addOrUpdate")
    public void addOrUpdate(@RequestBody @Validated Scene scene) {
        sceneService.addOrUpdate(scene);
    }

    @ApiOperation("查询供修改")
    @GetMapping("/queryById")
    public Scene queryById(@RequestParam @NotBlank String sceneId) {
        return sceneService.queryById(sceneId);
    }

    @ApiOperation("场景启停")
    @PostMapping("/changeEnable")
    public void changeEnable(@RequestBody Map<String, Object> params) {
        sceneService.changeEnable(params);
    }

    @ApiOperation("删除场景")
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        sceneService.delete(id);
    }

    @ApiOperation("列表")
    @GetMapping("/list")
    public List<Scene> list() {
        return sceneService.list();
    }


    @ApiOperation("分页查询")
    @GetMapping("/page")
    public IPage<Scene> page(Integer size, Integer page, String name) {
        return sceneService.page(size, page, name);
    }


}
