package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.Device;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.service.DeviceService;

import javax.validation.constraints.NotBlank;

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


    //todo 控制设备


}
