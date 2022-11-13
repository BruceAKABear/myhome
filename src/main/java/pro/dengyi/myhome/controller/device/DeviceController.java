package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.constraints.NotBlank;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.dto.DeviceLoginDto;
import pro.dengyi.myhome.model.device.dto.RoomDeviceTree;
import pro.dengyi.myhome.model.dto.DeviceDto;
import pro.dengyi.myhome.properties.SystemProperties;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.DeviceService;

/**
 * 设备controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Slf4j
@Api(tags = "设备接口")
@Validated
@RestController
@RequestMapping("/device")
@Permission
public class DeviceController {

  @Autowired
  private DeviceService deviceService;
  @Autowired
  private SystemProperties systemProperties;

  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<DeviceDto>> page(Integer page, Integer size, String floorId,
      String roomId, String productId) {
    IPage<DeviceDto> pageRes = deviceService.page(page, size, floorId, roomId, productId);
    return new DataResponse<>(pageRes);
  }

  @ApiOperation("查询调试所有设备")
  @GetMapping("/debugDeviceList")
  public DataResponse<List<Device>> debugDeviceList(String productId) {
    List<Device> deviceList = deviceService.debugDeviceList(productId);
    return new DataResponse<>(deviceList);
  }

  @ApiOperation("根据房间id查询所有可控设备列表")
  @GetMapping("/listByRoomId")
  public DataResponse<List<Device>> listByRoomId(
      @RequestParam @NotBlank(message = "房间id不能为空") String roomId) {
    List<Device> deviceList = deviceService.listByRoomId(roomId);
    return new DataResponse<>(deviceList);
  }

  @ApiOperation("根据楼层id查询房间设备树")
  @GetMapping("/roomDeviceTree")
  public DataResponse<List<RoomDeviceTree>> roomDeviceTree(String floorId) {
    List<RoomDeviceTree> roomDeviceTrees = deviceService.roomDeviceTree(floorId);
    return new DataResponse<>(roomDeviceTrees);
  }

  @ApiOperation("添加或修改设备")
  @PostMapping("/addUpdate")
  public CommonResponse addUpdate(@RequestBody @Validated Device device) {
    deviceService.addUpdate(device);
    return CommonResponse.success();
  }

  @ApiOperation("删除设备")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
    deviceService.delete(id);
    return CommonResponse.success();
  }

  @ApiOperation("下发debug命令")
  @PostMapping("/sendDebug")
  public CommonResponse sendDebug(@RequestBody Map<String, Object> orderMap) {
    deviceService.sendDebug(orderMap);
    return CommonResponse.success();
  }

  @ApiOperation("下发命令(严格校验)")
  @PostMapping("/sendCmd")
  public CommonResponse sendCmd(@RequestBody Map<String, Object> orderMap) {
    deviceService.sendCmd(orderMap);
    return CommonResponse.success();
  }


  @ApiOperation("设备登录")
  @PostMapping("/deviceLogin")
  public Map<String, String> deviceLogin(@RequestBody DeviceLoginDto loginDto) {
    log.info("设备登录：{}", loginDto);
    Map<String, String> resMap = new HashMap<>(1);

    //无clientId不进行逻辑
    if (ObjectUtils.isEmpty(loginDto.getClientId())) {
      resMap.put("result", "deny");
    }
    //有clientId进行查找设备是否在系统中
    //1. 服务端
    if (loginDto.getClientId().equals(systemProperties.getServerMqttClientId())) {
      resMap.put("result", "allow");
    } else {
      Device device = deviceService.selectById(loginDto.getClientId());
      if (device == null) {
        resMap.put("result", "deny");
      } else {
        resMap.put("result", "allow");
        //更新在线
        deviceService.deviceOnline(loginDto.getClientId());
      }
    }
    return resMap;
  }

  @Transactional
  @ApiOperation("EMQ钩子")
  @PostMapping("/emqHook")
  public CommonResponse emqHook(@RequestBody Map<String, Object> params) {
    deviceService.emqHook(params);
    return CommonResponse.success();
  }

  @ApiOperation("单个设备固件升级")
  @PostMapping("/singleDeviceFirmwareUpdate")
  public CommonResponse singleDeviceFirmwareUpdate(@RequestBody DeviceDto deviceDto) {
    deviceService.singleDeviceFirmwareUpdate(deviceDto);
    return CommonResponse.success();
  }

}
