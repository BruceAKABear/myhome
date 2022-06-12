package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.CategoryFieldDao;
import pro.dengyi.myhome.dao.DeviceCategoryDao;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.CategoryField;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.DeviceCategory;
import pro.dengyi.myhome.service.DeviceCategoryService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-28
 */
@Service
public class DeviceCategoryServiceImpl implements DeviceCategoryService {

  @Autowired
  private DeviceCategoryDao deviceCategoryDao;
  @Autowired
  private CategoryFieldDao categoryFieldDao;

  @Autowired
  private DeviceDao deviceDao;


  @Transactional
  @Override
  public void addUpdate(DeviceCategory deviceCategory) {
    if (ObjectUtils.isEmpty(deviceCategory.getId())) {
      boolean exists = deviceCategoryDao.exists(
          new LambdaQueryWrapper<DeviceCategory>().eq(DeviceCategory::getName,
              deviceCategory.getName()));
      if (exists) {
        throw new BusinessException(15001, "同名设备分类已存在");
      }
//      deviceCategory.setCreateTime(new Date());
//      deviceCategory.setUpdateTime(new Date());
      deviceCategoryDao.insert(deviceCategory);

    } else {
//      deviceCategory.setUpdateTime(new Date());
      deviceCategoryDao.updateById(deviceCategory);
      categoryFieldDao.delete(
          new LambdaQueryWrapper<CategoryField>().eq(CategoryField::getCategoryId,
              deviceCategory.getId()));
    }
    List<CategoryField> categoryFieldList = deviceCategory.getCategoryFieldList();
    for (CategoryField categoryField : categoryFieldList) {
      categoryField.setCategoryId(deviceCategory.getId());
      categoryFieldDao.insert(categoryField);
    }


  }

  @Transactional
  @Override
  public void delete(String id) {
//    List<Device> devices = deviceDao.selectList(
//        new LambdaQueryWrapper<Device>().eq(Device::getCategoryId, id));
//    if (!CollectionUtils.isEmpty(devices)) {
//      throw new BusinessException(20001, "设备分类包含设备，不能删除");
//    }
    deviceCategoryDao.deleteById(id);
    //删除字段
    categoryFieldDao.delete(
        new LambdaQueryWrapper<CategoryField>().eq(CategoryField::getCategoryId, id));
  }

  @Override
  public IPage<DeviceCategory> page(Integer pageNumber, Integer pageSize, String name) {
    IPage<DeviceCategory> page = new Page<>(pageNumber == null ? 1 : pageNumber,
        pageSize == null ? 10 : pageSize);
    QueryWrapper<DeviceCategory> qr = new QueryWrapper<>();
    if (!ObjectUtils.isEmpty(name)) {
      qr.likeRight("name", name);
    }
    IPage<DeviceCategory> deviceCategoryIPage = deviceCategoryDao.selectPage(page, qr);
    List<DeviceCategory> records = deviceCategoryIPage.getRecords();
    if (!CollectionUtils.isEmpty(records)) {
      for (DeviceCategory record : records) {
//        record.setDeviceCount(Math.toIntExact(deviceDao.selectCount(
//            new LambdaQueryWrapper<Device>().eq(Device::getCategoryId, record.getId()))));
        record.setCategoryFieldList(categoryFieldDao.selectList(
            new LambdaQueryWrapper<CategoryField>().eq(CategoryField::getCategoryId,
                record.getId())));
      }

    }
    return deviceCategoryIPage;
  }

  @Override
  public List<DeviceCategory> categoryList() {
    return deviceCategoryDao.selectList(new LambdaQueryWrapper<>());
  }
}
