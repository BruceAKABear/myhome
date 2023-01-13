package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.dto.LogByConditionDto;
import pro.dengyi.myhome.model.device.dto.LogConditionDto;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.DeviceLogService;

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
  public DataResponse<IPage<DeviceLog>> page(Integer page, Integer size,
      String deviceId) {
    IPage<DeviceLog> pageRes = deviceLogService.page(page, size, deviceId);
    return new DataResponse<>(pageRes);
  }

  @ApiOperation("查询设备log")
  @PostMapping("/logByCondition")
  public DataResponse<List<LogByConditionDto>> logByCondition(@RequestBody LogConditionDto dto) {
    List<LogByConditionDto> list = deviceLogService.logByCondition(dto.getDeviceId(),
        dto.getStartDateTime(),
        dto.getEndDateTime(), dto.getStep());
    return new DataResponse<>(list);
  }

}
