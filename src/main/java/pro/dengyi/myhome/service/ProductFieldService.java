package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.device.ProductField;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-09
 */
public interface ProductFieldService {

    List<ProductField> fieldList(String deviceId, String productId);
}
