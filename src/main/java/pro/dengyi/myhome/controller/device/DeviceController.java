package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.github.benmanes.caffeine.cache.Cache;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.aop.annotations.IpRestrict;
import pro.dengyi.myhome.common.aop.annotations.NoLog;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.dto.*;
import pro.dengyi.myhome.model.dto.ChangeFavoriteDto;
import pro.dengyi.myhome.common.config.properties.SystemProperties;
import pro.dengyi.myhome.common.response.CommonResponse;
import pro.dengyi.myhome.common.response.DataResponse;
import pro.dengyi.myhome.service.DeviceService;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Autowired
    private Cache cache;


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


    @ApiOperation("查询所有设备(包含产品信息、产品字段信息等，供场景使用)")
    @GetMapping("/allDeviceList")
    @Permission(needValidate = false)
    public DataResponse<List<DeviceForScene>> allDeviceList(String floorId, String roomId) {
        List<DeviceForScene> deviceList = deviceService.allDeviceList(floorId, roomId);
        return new DataResponse<>(deviceList);
    }

    @ApiOperation("根据房间id查询所有可控设备列表")
    @GetMapping("/listByRoomId")
    @Permission(needValidate = false)
    public DataResponse<List<DeviceDto>> listByRoomId(
            @RequestParam @NotBlank(message = "房间id不能为空") String roomId,
            @RequestParam Boolean favorite) {
        List<DeviceDto> deviceList = deviceService.listByRoomId(roomId, favorite);
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

    @ApiOperation("扫描添加或修改设备")
    @PostMapping("/scanAddUpdate")
    public CommonResponse scanAddUpdate(@RequestBody @Validated Device device) {
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

    //todo 严格校验格式
    @ApiOperation("下发命令(严格校验)")
    @PostMapping("/sendCmd")
    @Permission(needValidate = false)
    public CommonResponse sendCmd(@RequestBody Map<String, Object> orderMap) {
        deviceService.sendCmd(orderMap);
        return CommonResponse.success();
    }

    @ApiOperation("一键控制")
    @PostMapping("/oneButton")
    @Permission(needValidate = false)
    public CommonResponse oneButton(@RequestBody Map<String, Object> orderMap) {
        deviceService.oneButton(orderMap);
        return CommonResponse.success();
    }

    @ApiOperation("查询地图模式所有灯开关程度")
    @GetMapping("/mapModeLamps")
    @Permission(needValidate = false)
    public DataResponse<List<Map<String, Object>>> mapModeLamps(@RequestParam String floorId) {
        List<Map<String, Object>> res = deviceService.mapModeLamps(floorId);
        return new DataResponse<>(res);
    }


    /**
     * device login controller
     * <p>
     * the most important thing is the device ip must internal ip because the whole system in internal
     * network
     *
     * @param loginDto
     * @return
     */
    @IpRestrict
    @Permission(needLogIn = false, needValidate = false)
    @NoLog
    @ApiOperation("设备登录")
    @PostMapping("/deviceLogin")
    public Map<String, String> deviceLogin(@RequestBody DeviceLoginDto loginDto) {
        log.info("设备登录，设备登录信息为：{}", loginDto);
        Map<String, String> resMap = new HashMap<>(1);
        //无clientId不进行逻辑
        if (ObjectUtils.isEmpty(loginDto.getClientId())) {
            resMap.put("result", "deny");
        }
        //有clientId进行查找设备是否在系统中
        if (systemProperties.getMqttClientIds().contains(loginDto.getClientId())) {
            //1. 服务端
            resMap.put("result", "allow");
        } else {
            //2. 普通设备
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


    /**
     * 指定回调服务器ip
     *
     * @param params
     * @return
     */
    @IpRestrict
    @Permission(needLogIn = false, needValidate = false)
    @Transactional
    @ApiOperation("EMQ钩子")
    @PostMapping("/emqHook")
    @NoLog
    public CommonResponse emqHook(@RequestBody Map<String, Object> params) {
        deviceService.emqHook(params);
        return CommonResponse.success();
    }

    @Deprecated
    @ApiOperation("单个设备固件升级")
    @PostMapping("/singleDeviceFirmwareUpdate")
    public CommonResponse singleDeviceFirmwareUpdate(@RequestBody DeviceDto deviceDto) {
        deviceService.singleDeviceFirmwareUpdate(deviceDto);
        return CommonResponse.success();
    }

    @ApiOperation("改变收藏设备")
    @PostMapping("/changeFavorite")
    @Permission(needValidate = false)
    public CommonResponse changeFavorite(@RequestBody ChangeFavoriteDto favoriteDto) {
        deviceService.changeFavorite(favoriteDto);
        return CommonResponse.success();
    }

    @ApiOperation("收藏设备集合")
    @GetMapping("/favoriteDevices")
    @Permission(needValidate = false)
    public DataResponse<List<FavoriteDevicesModel>> favoriteDevices() {
        List<FavoriteDevicesModel> res = deviceService.favoriteDevices();
        return new DataResponse<>(res);
    }


    @ApiOperation("设备操作日志")
    @GetMapping("/deviceControlLog")
    @Permission(needValidate = false)
    public DataResponse<List<DeviceControlLogDto>> deviceControlLog(String userId, String roomId,
                                                                    String deviceId, @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime startTime,
                                                                    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endTime, Integer page,
                                                                    Integer size) {
        List<DeviceControlLogDto> dtos = deviceService.deviceControlLog(userId, roomId, deviceId,
                startTime, endTime, page, size);
        return new DataResponse<>(dtos);
    }


}
