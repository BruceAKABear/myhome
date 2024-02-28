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
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.service.RoomService;

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
@Api(tags = "房间接口")
@RestController
@Permission
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;
    @Resource
    private Cache systemCache;


    @ApiOperation("分页查询")
    @GetMapping("/page")
    public IPage<RoomDto> page(Integer page, Integer size, String floorId, String roomName) {
        String familyId = FamilyHolder.familyId();
        return roomService.page(page, size, floorId, roomName, familyId);
    }

    @ApiOperation("后台分页查询")
    @GetMapping("/pageBackend")
    public IPage<RoomDto> pageBackend(Integer page, Integer size, String floorId, String roomName, String familyId) {
        return roomService.page(page, size, floorId, roomName, familyId);
    }

    @ApiOperation("查询房间列表")
    @GetMapping("/roomList")
    public List<Room> roomList(String floorId) {
        return roomService.roomList(floorId);
    }

    @ApiOperation("根据楼层id查询房间列表")
    @GetMapping("/roomListByFloorId")
    public List<Room> roomListByFloorId(@RequestParam @NotBlank(message = "楼层id不能为空") String floorId) {
        return (List<Room>) systemCache.get("roomListByFloorId:" + floorId, k -> roomService.roomListByFloorId(floorId));
    }


    @ApiOperation("新增或修改房间")
    @PostMapping("/addUpdate")
    public void addUpdate(@RequestBody @Validated Room room) {
        roomService.addUpdate(room);
    }

    @ApiOperation("删除房间")
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        roomService.delete(id);
    }
}
