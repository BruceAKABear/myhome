package pro.dengyi.myhome.service;

import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/21 16:36
 * @description：
 * @modified By：
 */
public interface AppVersionService {

    Map<String, Object> versionCheck(String version, Integer versionCode);
}
