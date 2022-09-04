package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.system.User;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Repository
public interface UserDao extends BaseMapper<User> {

}
