package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.service.DeviceService;

/**
 * 设备controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "房间接口")
@RestController
@RequestMapping("/device")
public class DeviceController {
    @Autowired
    private DeviceService deviceService;


}
