package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.DeviceCategory;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-28
 */
public interface DeviceCategoryService {

  void addUpdate(DeviceCategory deviceCategory);

  void delete(String id);

  IPage<DeviceCategory> page(Integer pageNumber, Integer pageSize, String name);

  List<DeviceCategory> categoryList();

}
