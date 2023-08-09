package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.device.Frameware;
import pro.dengyi.myhome.service.FramewareService;

import javax.validation.constraints.NotBlank;

/**
 * 固件controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Api(tags = "固件接口")
@Validated
@RestController
@RequestMapping("/frameware")
public class FramewareController {

    @Autowired
    private FramewareService framewareService;


    @ApiOperation("分页查询")
    @GetMapping("/page")
    public IPage<Frameware> page(Integer page, Integer size, String productId) {
        return framewareService.page(page, size, productId);
    }

    @ApiOperation("添加固件")
    @PostMapping("/add")
    public void add(@RequestBody @Validated Frameware frameware) {
        framewareService.add(frameware);

    }


    @ApiOperation("删除固件")
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        framewareService.delete(id);

    }


}
