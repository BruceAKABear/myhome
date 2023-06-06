package pro.dengyi.myhome.controller.message;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.model.system.Message;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.MessageService;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/1 17:01
 * @description：消息controller
 * @modified By：
 */

@Api(tags = "消息接口")
@RestController
@RequestMapping("/message")
public class MessageController {

    @Autowired
    private MessageService messageService;


    @Permission(needValidate = false)
    @ApiOperation("查询所有消息")
    @GetMapping("/getAllMessage")
    public DataResponse<IPage<Message>> getAllMessage(@RequestParam Integer page,
                                                      @RequestParam Integer size, @RequestParam(required = false) Boolean read) {
        IPage<Message> res = messageService.getAllMessage(page, size, read);
        return new DataResponse<>(res);
    }

    @Permission(needValidate = false)
    @ApiOperation("查询纬度消息数量")
    @GetMapping("/getHaveNotRead")
    public DataResponse<Integer> getHaveNotRead() {
        Integer count = messageService.getHaveNotRead();
        return new DataResponse<>(count);
    }

    @Permission(needValidate = false)
    @ApiOperation("查询纬度消息数量")
    @GetMapping("/readMessage")
    public CommonResponse readMessage(@RequestParam String messageId) {
        messageService.readMessage(messageId);
        return CommonResponse.success();
    }


}
