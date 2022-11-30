package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.dengyi.myhome.dao.AppVersionDao;
import pro.dengyi.myhome.model.system.AppVersion;
import pro.dengyi.myhome.service.AppVersionService;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/21 16:36
 * @description：
 * @modified By：
 */
@Service
public class AppVersionServiceImpl implements AppVersionService {

  @Autowired
  private AppVersionDao appVersionDao;


  @Override
  public Map<String, Object> versionCheck(String version, Integer versionCode) {
    Map<String, Object> resMap = new HashMap<>();
    resMap.put("haveUpdate", false);
    AppVersion appVersion = appVersionDao.selectOne(
        new LambdaQueryWrapper<AppVersion>().orderByDesc(AppVersion::getVersionCode)
            .last("limit 1"));

    if (appVersion != null && appVersion.getVersionCode() > versionCode) {
      resMap.put("haveUpdate", true);
      resMap.put("updateType", appVersion.getUpdateType());
      resMap.put("wgetUrl", appVersion.getWgetUrl());
    }

    return resMap;
  }
}
