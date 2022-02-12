package pro.dengyi.myhome.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.annotations.NeedHolderPermission;
import pro.dengyi.myhome.model.Device;
import pro.dengyi.myhome.model.dto.DeviceDto;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.DeviceService;

import javax.validation.constraints.NotBlank;
import java.util.List;
import java.util.Map;

/**
 * 设备controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "设备接口")
@Validated
@RestController
@RequestMapping("/device")
public class DeviceController {
    @Autowired
    private DeviceService deviceService;


    @ApiOperation("添加后修改设备")
    @GetMapping("/page")
    public DataResponse<IPage<DeviceDto>> page(Integer pageNumber, Integer pageSize, String floorId, String roomId, String categoryId) {
        IPage<DeviceDto> pageRes = deviceService.page(pageNumber, pageSize, floorId, roomId, categoryId);
        return new DataResponse<>(pageRes);
    }

    @ApiOperation("查询调试所有设备")
    @GetMapping("/debugDeviceList")
    public DataResponse<List<Device>> debugDeviceList() {
        List<Device> deviceList = deviceService.debugDeviceList();
        return new DataResponse<>(deviceList);
    }


    @NeedHolderPermission
    @ApiOperation("添加后修改设备")
    @PostMapping("/addUpdate")
    public CommonResponse addUpdate(@RequestBody @Validated Device device) {
        deviceService.addUpdate(device);
        return CommonResponse.success();
    }

    @NeedHolderPermission
    @ApiOperation("删除设备")
    @DeleteMapping("/delete/{id}")
    public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        deviceService.delete(id);
        return CommonResponse.success();
    }


    @NeedHolderPermission
    @ApiOperation("下发debug命令")
    @PostMapping("/sendDebug")
    public CommonResponse sendDebug(@RequestBody Map<String, Object> orderMap) {
        deviceService.sendDebug(orderMap);
        return CommonResponse.success();
    }

}
