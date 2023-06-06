package pro.dengyi.myhome.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.dao.FeedBackDao;
import pro.dengyi.myhome.model.system.FeedBack;
import pro.dengyi.myhome.service.FeedBackService;
import pro.dengyi.myhome.utils.UserHolder;

import java.time.LocalDateTime;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/21 13:08
 * @description：
 * @modified By：
 */
@Service
public class FeedBackServiceImpl implements FeedBackService {

    @Autowired
    private FeedBackDao feedBackDao;


    @Transactional
    @Override
    public void add(FeedBack feedBack) {
        feedBack.setUserId(UserHolder.getUser().getId());
        feedBack.setCreateTime(LocalDateTime.now());
        feedBack.setUpdateTime(LocalDateTime.now());
        feedBackDao.insert(feedBack);

    }
}
