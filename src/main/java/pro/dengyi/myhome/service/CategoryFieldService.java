package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.CategoryField;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
public interface CategoryFieldService {
    List<CategoryField> fieldList(String deviceId);
}
