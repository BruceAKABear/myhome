package pro.dengyi.myhome.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.dengyi.myhome.dao.CategoryFieldDao;
import pro.dengyi.myhome.model.CategoryField;
import pro.dengyi.myhome.service.CategoryFieldService;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Service
public class CategoryFieldServiceImpl implements CategoryFieldService {
    @Autowired
    private CategoryFieldDao categoryFieldDao;

    @Override
    public List<CategoryField> fieldList(String deviceId) {
        return categoryFieldDao.selectListByDeviceId(deviceId);
    }
}
