package pro.dengyi.myhome.controller.location;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.service.LocationService;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/28 11:08
 * @description：定位controller
 * @modified By：
 */
@Api(tags = "位置接口")
@RestController
@Permission
@RequestMapping("/location")
public class LocationController {

  @Autowired
  private LocationService locationService;


  @ApiOperation("根据最强信号强度beacon查询位置")
  @Permission(needValidate = false)
  @GetMapping("/checkLocation")
  public CommonResponse checkLocation(String beaconUuid) {
    locationService.checkLocation(beaconUuid);
    return CommonResponse.success();
  }


}
