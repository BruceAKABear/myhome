package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.device.Frameware;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
public interface FramewareService {

  IPage<Frameware> page(Integer page, Integer size, String productId);

  void delete(String id);

  void add(Frameware frameware);
}
