package pro.dengyi.myhome.controller.common;

import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.common.aop.annotations.NoLog;
import pro.dengyi.myhome.common.exception.BusinessException;
import springfox.documentation.annotations.ApiIgnore;

/**
 * 文件controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@ApiIgnore
@NoLog
@Slf4j
@RestController
@RequestMapping
public class CommonController {

    @ApiOperation(hidden = true,value = "")
    @GetMapping
    public void index() {
        throw new BusinessException("system.common.nodata");
    }

    @ApiOperation(hidden = true,value = "")
    @GetMapping("/error")
    public String error() {
        throw new BusinessException("system.common.error");
    }

}
