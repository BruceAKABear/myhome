package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.perm.PermissionFunction;
import pro.dengyi.myhome.model.system.User;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/9/30 15:13
 * @description：
 * @modified By：
 */
@Repository
public interface PermissionFunctionDao extends BaseMapper<PermissionFunction> {

  List<String> selecAllPermSymbol(@Param("user") User user);
}
