package pro.dengyi.myhome.controller.family;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.annotations.HolderPermission;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.RoomService;

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
@RequestMapping("/room")
public class RoomController {

  @Autowired
  private RoomService roomService;

  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<RoomDto>> page(Integer pageNumber, Integer pageSize, String floorId,
      String roomName) {
    IPage<RoomDto> pageRes = roomService.page(pageNumber, pageSize, floorId, roomName);
    return new DataResponse<>(pageRes);
  }

  @ApiOperation("查询房间列表")
  @GetMapping("/roomList")
  public DataResponse<List<Room>> roomList() {
    List<Room> roomList = roomService.roomList();
    return new DataResponse<>(roomList);
  }

  @HolderPermission
  @ApiOperation("新增或修改房间")
  @PostMapping("/addUpdate")
  public CommonResponse addUpdate(@RequestBody @Validated Room room) {
    roomService.addUpdate(room);
    return CommonResponse.success();
  }

  @HolderPermission
  @ApiOperation("删除房间")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
    roomService.delete(id);
    return CommonResponse.success();
  }
}
