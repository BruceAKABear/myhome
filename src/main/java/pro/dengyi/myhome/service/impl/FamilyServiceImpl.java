package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.dao.FamilyDao;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;
import pro.dengyi.myhome.service.FamilyService;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class FamilyServiceImpl implements FamilyService {

    @Resource
    private Cache<String, Object> systemCache;

    @Autowired
    private FamilyDao familyDao;


    @Transactional
    @Override
    public void addUpdate(Family family) {
        if (ObjectUtils.isEmpty(family.getId())) {
            Family familyExist = familyDao.selectOne(new LambdaQueryWrapper<Family>()
                    .eq(Family::getName, family.getName()));
            if (familyExist != null) {
                throw new BusinessException("family.name.exist");
            }
            family.setCreateTime(LocalDateTime.now());
            family.setUpdateTime(LocalDateTime.now());
            familyDao.insert(family);
        } else {
            family.setUpdateTime(LocalDateTime.now());
            familyDao.updateById(family);
        }
        List<FamilyDto> familyDtos = familyDao.selectFamilyInfos();
        systemCache.put("familyInfos", familyDtos);
    }

    @Override
    public Boolean checkIsFirst() {
        return CollectionUtils.isEmpty(familyDao.selectFamilyInfos());
    }

    @Override
    public List<FamilyDto> infoList() {
        return (List<FamilyDto>) systemCache.get("familyInfos", key -> familyDao.selectFamilyInfos());
    }

    @Override
    public FamilyDto infoById(String familyId) {
        List<FamilyDto> familyDtos = (List<FamilyDto>) systemCache.get("familyInfos", key -> familyDao.selectFamilyInfos());
        if (CollectionUtils.isEmpty(familyDtos)) {
            List<FamilyDto> familyDtosNew = familyDao.selectFamilyInfos();
            systemCache.put("familyInfos", familyDtosNew);
            familyDtos = familyDtosNew;
        }
        for (FamilyDto familyDto : familyDtos) {
            if (familyDto.getId().equals(familyId)) {
                return familyDto;
            }
        }
        return null;
    }

}
