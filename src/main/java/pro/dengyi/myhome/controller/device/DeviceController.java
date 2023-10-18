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
import pro.dengyi.myhome.common.config.properties.SystemProperties;
import pro.dengyi.myhome.common.response.IgnoreResponseHandler;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.dto.*;
import pro.dengyi.myhome.model.dto.ChangeFavoriteDto;
import pro.dengyi.myhome.service.DeviceService;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备controller
 * <p>
 * <p>
 * 软件订阅收费模式，订阅收费还要基于设备数进行分级
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
    public IPage<DeviceDto> page(Integer page, Integer size, String floorId,
                                 String roomId, String productId) {
        return deviceService.page(page, size, floorId, roomId, productId);
    }

    @ApiOperation("查询调试所有设备")
    @GetMapping("/debugDeviceList")
    public List<Device> debugDeviceList(String productId) {
        return deviceService.debugDeviceList(productId);
    }


    @ApiOperation("查询所有设备(包含产品信息、产品字段信息等，供场景使用)")
    @GetMapping("/allDeviceList")
    @Permission(needValidate = false)
    public List<DeviceForScene> allDeviceList(String floorId, String roomId) {
        return deviceService.allDeviceList(floorId, roomId);

    }

    @ApiOperation("根据房间id查询所有可控设备列表")
    @GetMapping("/listByRoomId")
    @Permission(needValidate = false)
    public List<DeviceDto> listByRoomId(
            @RequestParam @NotBlank(message = "房间id不能为空") String roomId,
            @RequestParam Boolean favorite) {
        return deviceService.listByRoomId(roomId, favorite);
    }

    @ApiOperation("根据楼层id查询房间设备树")
    @GetMapping("/roomDeviceTree")
    public List<RoomDeviceTree> roomDeviceTree(String floorId) {
        return deviceService.roomDeviceTree(floorId);
    }

    @ApiOperation("添加或修改设备")
    @PostMapping("/addUpdate")
    public void addUpdate(@RequestBody @Validated Device device) {
        deviceService.addUpdate(device);
    }

    @ApiOperation("扫描添加或修改设备")
    @PostMapping("/scanAddUpdate")
    public void scanAddUpdate(@RequestBody @Validated Device device) {
        deviceService.addUpdate(device);
    }

    @ApiOperation("删除设备")
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        deviceService.delete(id);
    }

    @ApiOperation("下发debug命令")
    @PostMapping("/sendDebug")
    public void sendDebug(@RequestBody Map<String, Object> orderMap) {
        deviceService.sendDebug(orderMap);
    }

    //todo 严格校验格式
    @ApiOperation("下发命令(严格校验)")
    @PostMapping("/sendCmd")
    @Permission(needValidate = false)
    public void sendCmd(@RequestBody Map<String, Object> orderMap) {
        deviceService.sendCmd(orderMap);
    }

    @ApiOperation("一键控制")
    @PostMapping("/oneButton")
    @Permission(needValidate = false)
    public void oneButton(@RequestBody Map<String, Object> orderMap) {
        deviceService.oneButton(orderMap);
    }

    @ApiOperation("查询地图模式所有灯开关程度")
    @GetMapping("/mapModeLamps")
    @Permission(needValidate = false)
    public List<Map<String, Object>> mapModeLamps(@RequestParam String floorId) {
        return deviceService.mapModeLamps(floorId);
    }


    /**
     * //todo we need to control the connection devices by subscribe plan
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
    @IgnoreResponseHandler
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
    @IgnoreResponseHandler
    public void emqHook(@RequestBody Map<String, Object> params) {
        deviceService.emqHook(params);

    }

    @Deprecated
    @ApiOperation("单个设备固件升级")
    @PostMapping("/singleDeviceFirmwareUpdate")
    public void singleDeviceFirmwareUpdate(@RequestBody DeviceDto deviceDto) {
        deviceService.singleDeviceFirmwareUpdate(deviceDto);

    }

    @ApiOperation("改变收藏设备")
    @PostMapping("/changeFavorite")
    @Permission(needValidate = false)
    public void changeFavorite(@RequestBody ChangeFavoriteDto favoriteDto) {
        deviceService.changeFavorite(favoriteDto);

    }

    @ApiOperation("收藏设备集合")
    @GetMapping("/favoriteDevices")
    @Permission(needValidate = false)
    public List<FavoriteDevicesModel> favoriteDevices() {
        return deviceService.favoriteDevices();
    }


    @ApiOperation("设备操作日志")
    @GetMapping("/deviceControlLog")
    @Permission(needValidate = false)
    public List<DeviceControlLogDto> deviceControlLog(String userId, String roomId,
                                                      String deviceId, @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime startTime,
                                                      @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endTime, Integer page,
                                                      Integer size) {
        return deviceService.deviceControlLog(userId, roomId, deviceId,
                startTime, endTime, page, size);
    }


}
