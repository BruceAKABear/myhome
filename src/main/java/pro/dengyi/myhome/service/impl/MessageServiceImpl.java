package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.dao.MessageDao;
import pro.dengyi.myhome.model.system.Message;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.service.MessageService;
import pro.dengyi.myhome.common.utils.UserHolder;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/1/3 8:37
 * @description：
 * @modified By：
 */
@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageDao messageDao;

    @Override
    public IPage<Message> getAllMessage(Integer page, Integer size, Boolean read) {
        User currentUser = UserHolder.getUser();
        IPage<Message> pageParams = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
        LambdaQueryWrapper<Message> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Message::getUserId, currentUser.getId());
        if (read != null) {
            queryWrapper.eq(Message::getReaded, read);
        }
        return messageDao.selectPage(pageParams, queryWrapper);
    }

    @Override
    public Integer getHaveNotRead() {
        User currentUser = UserHolder.getUser();
        return Math.toIntExact(messageDao.selectCount(
                new LambdaQueryWrapper<Message>().eq(Message::getUserId, currentUser.getId())
                        .eq(Message::getReaded, false)));
    }

    @Transactional
    @Override
    public void readMessage(String messageId) {
        Message message = messageDao.selectById(messageId);
        message.setReaded(true);
        messageDao.updateById(message);
    }
}
