package pro.dengyi.myhome.controller.message;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.model.system.Message;
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
    public IPage<Message> getAllMessage(@RequestParam Integer page,
                                        @RequestParam Integer size, @RequestParam(required = false) Boolean read) {
        return messageService.getAllMessage(page, size, read);
    }

    @Permission(needValidate = false)
    @ApiOperation("查询纬度消息数量")
    @GetMapping("/getHaveNotRead")
    public Integer getHaveNotRead() {
        return messageService.getHaveNotRead();
    }

    @Permission(needValidate = false)
    @ApiOperation("查询纬度消息数量")
    @GetMapping("/readMessage")
    public void readMessage(@RequestParam String messageId) {
        messageService.readMessage(messageId);
    }


}
