package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.system.Message;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/1/3 8:36
 * @description：
 * @modified By：
 */
public interface MessageService {

  IPage<Message> getAllMessage(Integer page, Integer size, Boolean read);

  Integer getHaveNotRead();

  void readMessage(String messageId);
}
