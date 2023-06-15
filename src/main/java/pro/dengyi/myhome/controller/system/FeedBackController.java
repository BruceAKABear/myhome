package pro.dengyi.myhome.controller.system;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.model.system.FeedBack;
import pro.dengyi.myhome.common.response.CommonResponse;
import pro.dengyi.myhome.service.FeedBackService;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/21 16:32
 * @description：版本controller
 * @modified By：
 */
@Permission
@Api(tags = "反馈")
@RestController
@RequestMapping("/feedBack")
public class FeedBackController {

    @Autowired
    private FeedBackService feedBackService;

    @ApiOperation("新增反馈")
    @PostMapping("/add")
    @Permission(needValidate = false)
    public CommonResponse add(@RequestBody FeedBack feedBack) {
        feedBackService.add(feedBack);
        return CommonResponse.success();
    }

}
