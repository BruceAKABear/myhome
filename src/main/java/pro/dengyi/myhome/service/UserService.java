package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.Map;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.model.vo.LoginVo;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
public interface UserService {

  String login(LoginVo loginVo);

  void update(User user);

  User info();

  void addOrUpdate(User user);

  IPage<User> page(Integer pageNumber, Integer pageSize, String name);

  void enable(User user);

  void delete(String id);

  void updateSelectLang(Map<String, String> langParam);

  void updateUserInfo(Map<String, Object> updateUserInfo);
}
