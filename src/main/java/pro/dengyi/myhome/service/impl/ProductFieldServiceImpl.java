package pro.dengyi.myhome.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pro.dengyi.myhome.dao.ProductFieldDao;
import pro.dengyi.myhome.model.device.ProductField;
import pro.dengyi.myhome.service.ProductFieldService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-09
 */
@Service
public class ProductFieldServiceImpl implements ProductFieldService {

  @Autowired
  private ProductFieldDao productFieldDao;

  @Override
  public List<ProductField> fieldList(String deviceId) {
    return productFieldDao.selectFieldListByDeviceId(deviceId);
  }
}
