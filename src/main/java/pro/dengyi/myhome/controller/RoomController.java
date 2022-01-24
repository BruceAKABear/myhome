package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.Floor;
import pro.dengyi.myhome.model.Room;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.service.FloorService;
import pro.dengyi.myhome.service.RoomService;

import javax.validation.constraints.NotBlank;

/**
 * 楼层controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "房间接口")
@RestController
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @ApiOperation("新增或修改楼层")
    @PostMapping("/addUpdate")
    public CommonResponse addUpdate(@RequestBody @Validated Room room) {
        roomService.addUpdate(room);
        return CommonResponse.success();
    }

    @ApiOperation("删除楼层")
    @PostMapping("/delete/{id}")
    public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        roomService.delete(id);
        return CommonResponse.success();
    }
}
