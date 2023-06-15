package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.dto.DashboardDto;
import pro.dengyi.myhome.common.response.DataResponse;
import pro.dengyi.myhome.service.DashboardService;

/**
 * 控制台controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Api(tags = "管理后台仪表板接口")
@RestController
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;


    @ApiOperation("查询dashboard信息")
    @GetMapping("/dashboardInfo")
    public DataResponse<DashboardDto> dashboardInfo() {
        DashboardDto dashboardDto = dashboardService.dashboardInfo();
        return new DataResponse<>(dashboardDto);
    }

}
