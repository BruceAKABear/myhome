package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.ProductDao;
import pro.dengyi.myhome.dao.ProductFieldDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.ProductField;
import pro.dengyi.myhome.model.device.dto.ProductAddDto;
import pro.dengyi.myhome.model.device.dto.ProductPageDto;
import pro.dengyi.myhome.service.ProductService;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-03
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;
    @Autowired
    private ProductFieldDao productFieldDao;
    @Autowired
    private DeviceDao deviceDao;


    @Transactional
    @Override
    public void addUpdate(ProductAddDto productAddDto) {

        Product product = new Product();
        BeanUtils.copyProperties(productAddDto, product);
        if (ObjectUtils.isEmpty(product.getId())) {
            //同名校验
            boolean exists = productDao.exists(
                    new LambdaQueryWrapper<Product>().eq(Product::getName, product.getName()));

            if (exists) {
                throw new BusinessException(1, "同名产品已存在，不能继续新增");
            }
            product.setCreateTime(LocalDateTime.now());
            product.setUpdateTime(LocalDateTime.now());
            productDao.insert(product);
        } else {
            product.setUpdateTime(LocalDateTime.now());
            productDao.updateById(product);
            productFieldDao.delete(
                    new LambdaQueryWrapper<ProductField>().eq(ProductField::getProductId, product.getId()));
        }
        //字段清理新增
        List<ProductField> productFields = productAddDto.getProductFields();
        productFields.forEach(item -> {
            item.setCreateTime(LocalDateTime.now());
            item.setUpdateTime(LocalDateTime.now());
            item.setProductId(product.getId());
            productFieldDao.insert(item);
        });

    }

    @Transactional
    @Override
    public void delete(String id) {

        Long deviceCount = deviceDao.selectCount(
                new LambdaQueryWrapper<Device>().eq(Device::getProductId, id));
        if (deviceCount != 0) {
            //下属设备不为0则不能修改
            throw new BusinessException(20002, "产品下存在设备，删除产品");
        }
        productDao.deleteById(id);
        //删除产品控制字段
        productFieldDao.delete(
                new LambdaQueryWrapper<ProductField>().eq(ProductField::getProductId, id));
    }

    @Override
    public IPage<ProductPageDto> page(Integer page, Integer size, String name) {
        IPage<ProductPageDto> pageParam = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
        IPage<ProductPageDto> customPage = productDao.selectCustomPage(pageParam, name);
        List<ProductPageDto> records = customPage.getRecords();
        if (!CollectionUtils.isEmpty(records)) {
            records.forEach(item -> {
                item.setProductFields(productFieldDao.selectList(
                        new LambdaQueryWrapper<ProductField>().eq(ProductField::getProductId, item.getId())));
            });
        }

        return customPage;
    }

    @Override
    public List<Product> categoryList() {
        return productDao.selectList(null);
    }
}
