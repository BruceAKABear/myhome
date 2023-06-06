package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.ProductFieldDao;
import pro.dengyi.myhome.model.device.ProductField;
import pro.dengyi.myhome.service.ProductFieldService;

import java.util.ArrayList;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-09
 */
@Service
public class ProductFieldServiceImpl implements ProductFieldService {

    @Autowired
    private ProductFieldDao productFieldDao;

    @Override
    public List<ProductField> fieldList(String deviceId, String productId) {
        if (!ObjectUtils.isEmpty(productId)) {
            return productFieldDao.selectList(
                    new LambdaQueryWrapper<ProductField>().eq(ProductField::getProductId, productId));

        }
        if (!ObjectUtils.isEmpty(deviceId)) {
            return productFieldDao.selectFieldListByDeviceId(deviceId);
        }
        return new ArrayList<>(0);

    }
}
