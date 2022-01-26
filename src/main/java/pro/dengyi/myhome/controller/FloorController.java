package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.Floor;
import pro.dengyi.myhome.model.dto.FloorDto;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.FloorService;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 楼层controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "楼层接口")
@RestController
@RequestMapping("/floor")
public class FloorController {
    @Autowired
    private FloorService floorService;

    @ApiOperation("新增或修改楼层")
    @PostMapping("/addUpdate")
    public CommonResponse addUpdate(@RequestBody @Validated Floor floor) {
        floorService.addUpdate(floor);
        return CommonResponse.success();
    }

    @ApiOperation("楼层集合")
    @GetMapping("/floorList")
    public DataResponse<List<FloorDto>> floorList() {
        List<FloorDto> floorDtoList = floorService.floorList();
        return new DataResponse<>(floorDtoList);
    }

    @ApiOperation("删除楼层")
    @PostMapping("/delete/{id}")
    public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        floorService.delete(id);
        return CommonResponse.success();
    }



}
