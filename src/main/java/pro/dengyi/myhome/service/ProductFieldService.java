package pro.dengyi.myhome.service;

import java.util.List;
import pro.dengyi.myhome.model.device.ProductField;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-09
 */
public interface ProductFieldService {

  List<ProductField> fieldList(String deviceId);
}
