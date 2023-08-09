package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.dto.LogByConditionDto;
import pro.dengyi.myhome.model.device.dto.LogConditionDto;
import pro.dengyi.myhome.service.DeviceLogService;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Api(tags = "设备log接口")
@Validated
@RestController
@RequestMapping("/deviceLog")
public class DeviceLogController {

    @Autowired
    private DeviceLogService deviceLogService;


    @ApiOperation("分页查询")
    @GetMapping("/page")
    public IPage<DeviceLog> page(Integer page, Integer size,
                                 String deviceId) {
        return deviceLogService.page(page, size, deviceId);
    }

    @ApiOperation("条件查询设备log")
    @PostMapping("/logByCondition")
    public List<LogByConditionDto> logByCondition(@RequestBody LogConditionDto dto) {
        return deviceLogService.logByCondition(dto.getDeviceId(),
                dto.getStartDateTime(),
                dto.getEndDateTime(), dto.getStep());
    }

}
