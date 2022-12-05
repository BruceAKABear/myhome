package pro.dengyi.myhome.integration;

import pro.dengyi.myhome.model.system.User;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/12/5 13:51
 * @description：同步人员接口
 * @modified By：
 */
public interface SyncUser {

  Boolean addUser(User user);

}
