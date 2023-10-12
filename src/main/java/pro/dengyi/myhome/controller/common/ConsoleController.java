package pro.dengyi.myhome.controller.common;

import io.swagger.annotations.Api;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.common.aop.annotations.IpRestrict;
import pro.dengyi.myhome.common.response.IgnoreResponseHandler;

/**
 * pc端管理后台只能内网访问
 */
@Api(tags = "管理后台页面接口")
@Validated
@Controller
@RequestMapping("/console")
public class ConsoleController {

    @GetMapping
    @IgnoreResponseHandler
    public String console() {
        return "index.html";
    }

}
