package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.FamilyDao;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;
import pro.dengyi.myhome.service.FamilyService;

import java.time.LocalDateTime;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class FamilyServiceImpl implements FamilyService {

    @Autowired
    private Cache<String, Object> caffeineCache;

    @Autowired
    private FamilyDao familyDao;


    @Transactional
    @Override
    public void addUpdate(Family family) {
        if (ObjectUtils.isEmpty(family.getId())) {
            family.setCreateTime(LocalDateTime.now());
            family.setUpdateTime(LocalDateTime.now());
            familyDao.insert(family);
            //todo 缓存

        } else {
            family.setUpdateTime(LocalDateTime.now());
            familyDao.updateById(family);
            caffeineCache.invalidate("familyInfo");
        }
    }

    @Override
    public FamilyDto info() {
        return familyDao.selectFamilyDto();
    }

    @Override
    public Boolean checkIsFirst() {
        return CollectionUtils.isEmpty(familyDao.selectList(new QueryWrapper<>()));
    }

}
