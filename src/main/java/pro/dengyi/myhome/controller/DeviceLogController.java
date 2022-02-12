package pro.dengyi.myhome.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.DeviceLog;
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
    public DataResponse<IPage<DeviceLog>> page(Integer pageNumber, Integer pageSize, String deviceId) {
        IPage<DeviceLog> pageRes = deviceLogService.page(pageNumber, pageSize, deviceId);
        return new DataResponse<>(pageRes);
    }

}
