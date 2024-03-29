package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
        Family familyExist = familyDao.selectOne(
                new LambdaQueryWrapper<Family>().eq(Family::getName,
                        family.getName()));

        if (ObjectUtils.isEmpty(family.getId())) {
            if (familyExist != null) {
                throw new BusinessException("family.add.name.exist");
            }
            family.setCreateTime(LocalDateTime.now());
            family.setUpdateTime(LocalDateTime.now());
            familyDao.insert(family);
        } else {
            //make sure not change to another name exist
            if (familyExist != null && !familyExist.getId()
                    .equals(family.getId())) {
                throw new BusinessException("family.update.name.exist");
            }
            family.setUpdateTime(LocalDateTime.now());
            familyDao.updateById(family);
        }
    }

    @Override
    public Boolean checkIsFirst() {
        return CollectionUtils.isEmpty(familyDao.selectFamilyInfos());
    }


    @Override
    public FamilyDto infoById(String familyId) {
        List<FamilyDto> familyDtos = (List<FamilyDto>) systemCache.get(
                "familyInfos", key -> familyDao.selectFamilyInfos());
        if (CollectionUtils.isEmpty(familyDtos)) {
            List<FamilyDto> familyDtosNew = familyDao.selectFamilyInfos();
            familyDtos = familyDtosNew;
        }
        for (FamilyDto familyDto : familyDtos) {
            if (familyDto.getId().equals(familyId)) {
                return familyDto;
            }
        }
        return null;
    }

    @Override
    public IPage<FamilyDto> page(Integer page, Integer size, String name) {
        page = page == null ? 1 : page;
        size = size == null ? 10 : size;
        return familyDao.selectCustomPage(new Page<>(page, size), name);
    }

    @Transactional
    @Override
    public void delete(String id) {
        //todo 删除所有楼层房间设备？

        familyDao.deleteById(id);
    }

}
