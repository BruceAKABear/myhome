package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.FamilyDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.Family;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.service.FamilyService;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class FamilyServiceImpl implements FamilyService {
    @Autowired
    private FamilyDao familyDao;

    @Transactional
    @Override
    public void addUpdate(Family family) {
        if (ObjectUtils.isEmpty(family.getId())) {
            List<Family> familyList = familyDao.selectList(new QueryWrapper<>());
            if (CollectionUtils.isEmpty(familyList)) {
                familyDao.insert(family);
            } else {
                throw new BusinessException(11001, "只能增加一个家庭");
            }

        } else {
            //更新
            familyDao.updateById(family);
        }
    }

    @Override
    public FamilyDto info() {
        return familyDao.selectFamilyDto();
    }

    @Override
    public Boolean checkIsFirst() {
        List<Family> familyList = familyDao.selectList(new QueryWrapper<>());
        return CollectionUtils.isEmpty(familyList);
    }

}
