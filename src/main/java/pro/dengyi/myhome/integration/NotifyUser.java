package pro.dengyi.myhome.integration;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/28 16:27
 * @description：通知用户接口
 * @modified By：
 */
public interface NotifyUser {

    /**
     * 用邮件通知用户
     */
    void notifyByEmail(String email);

}
