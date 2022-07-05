package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.FramewareDao;
import pro.dengyi.myhome.model.device.Frameware;
import pro.dengyi.myhome.service.FramewareService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Service
public class FramewareServiceImpl implements FramewareService {

  @Autowired
  private FramewareDao framewareDao;


  @Override
  public IPage<Frameware> page(Integer page, Integer size, String productId) {
    IPage<Frameware> pageParam = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
    LambdaQueryWrapper<Frameware> queryWrapper = new LambdaQueryWrapper<>();
    if (!ObjectUtils.isEmpty(productId)) {
      queryWrapper.eq(Frameware::getProductId, productId);
    }
    return framewareDao.selectPage(pageParam, queryWrapper);
  }

  @Transactional
  @Override
  public void delete(String id) {
    framewareDao.deleteById(id);
  }

  @Transactional
  @Override
  public void add(Frameware frameware) {
    List<Frameware> framewares = framewareDao.selectList(
        new LambdaQueryWrapper<Frameware>().eq(Frameware::getProductId, frameware.getProductId())
            .orderByDesc(Frameware::getVersion));
    if (CollectionUtils.isEmpty(framewares)) {
      frameware.setVersion(1);
    } else {
      frameware.setVersion(framewares.get(0).getVersion() + 1);
    }
    frameware.setCreateTime(LocalDateTime.now());
    frameware.setUpdateTime(LocalDateTime.now());
    framewareDao.insert(frameware);
  }
}
