package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.model.vo.LoginVo;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
public interface UserService {

    String login(LoginVo loginVo, HttpServletRequest request);

    void update(User user);

    User info();

    void addOrUpdate(User user);

    IPage<User> page(Integer pageNumber, Integer pageSize, String name,
                     String familyId);

    void enable(User user);

    void delete(String id);

    void updateSelectLang(Map<String, String> langParam);

    void updateUserInfo(Map<String, Object> updateUserInfo);

    void updateSelectRoom(String roomId);

    void kickOut(User user);

    void logout();

    void updateSelectFamily(String familyId);

    void updateLang(String lang);

    void updateSelectFloor(String floorId);
}
