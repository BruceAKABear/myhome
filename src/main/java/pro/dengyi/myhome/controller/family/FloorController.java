package pro.dengyi.myhome.controller.family;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.benmanes.caffeine.cache.Cache;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.common.utils.FamilyHolder;
import pro.dengyi.myhome.model.dto.FloorPageDto;
import pro.dengyi.myhome.model.system.Floor;
import pro.dengyi.myhome.service.FloorService;

import javax.annotation.Resource;
import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 楼层controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Validated
@Api(tags = "楼层接口")
@Permission
@RestController
@RequestMapping("/floor")
public class FloorController {

    @Autowired
    private FloorService floorService;

    @ApiOperation("楼层分页查询")
    @GetMapping("/page")
    public IPage<FloorPageDto> page(Integer page, Integer size, String floorName) {
        String familyId = FamilyHolder.familyId();
        return floorService.page(page, size, floorName, familyId);
    }

    @ApiOperation("后台楼层分页查询")
    @GetMapping("/pageBackend")
    public IPage<FloorPageDto> pageBackend(Integer page, Integer size, String familyId, String floorName) {
        return floorService.page(page, size, floorName, familyId);
    }

    @ApiOperation("新增或修改楼层")
    @PostMapping("/addUpdate")
    public void addUpdate(@RequestBody @Validated Floor floor) {
        floorService.addUpdate(floor);
    }

    @ApiOperation("根据家庭ID楼层集合")
    @GetMapping("/floorList")
    public List<FloorPageDto> floorList(String familyId) {
        return floorService.floorList(familyId);
    }

    @ApiOperation("删除楼层")
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        floorService.delete(id);
    }


}
