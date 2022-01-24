package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.User;
import pro.dengyi.myhome.model.vo.LoginVo;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
public interface UserService {
    String login(LoginVo loginVo);

    void update(User user);

    User info();
}
