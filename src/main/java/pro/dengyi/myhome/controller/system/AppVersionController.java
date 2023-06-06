package pro.dengyi.myhome.controller.system;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.AppVersionService;

import javax.validation.constraints.NotBlank;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/21 16:32
 * @description：版本controller
 * @modified By：
 */
@Permission
@Api(tags = "app版本接口")
@RestController
@RequestMapping("/appVersion")
public class AppVersionController {

    @Autowired
    private AppVersionService appVersionService;

    @ApiOperation("检查app版本")
    @GetMapping("/versionCheck")
    public DataResponse<Map<String, Object>> versionCheck(@RequestParam @NotBlank String version,
                                                          @RequestParam @NotBlank Integer versionCode) {
        Map<String, Object> map = appVersionService.versionCheck(version, versionCode);
        return new DataResponse<>(map);
    }

}
