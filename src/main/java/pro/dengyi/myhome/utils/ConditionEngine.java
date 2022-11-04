package pro.dengyi.myhome.utils;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.dao.ProductDao;
import pro.dengyi.myhome.dao.ProductFieldDao;
import pro.dengyi.myhome.model.device.ProductField;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/3 17:17
 * @description：条件引擎
 * @modified By：
 */
@Component
public class ConditionEngine {

  @Autowired
  private Cache cache;
  @Autowired
  private ProductDao productDao;

  @Autowired
  private ProductFieldDao productFieldDao;

  public void trigger(String sourceMessage) {
    Map messageMap = JSON.parseObject(sourceMessage, Map.class);

    String deviceId = (String) messageMap.get("deviceId");
    String productId = (String) messageMap.get("productId");
    Integer powerLevel = (Integer) messageMap.get("powerLevel");

    cache.get("product:" + productId, k -> productDao.selectById(productId));

    List<ProductField> productFieldList = (List<ProductField>) cache.get(
        "productField:" + productId, k -> productFieldDao.selectList(
            new LambdaQueryWrapper<ProductField>().eq(ProductField::getProductId, productId)));

  }

}
