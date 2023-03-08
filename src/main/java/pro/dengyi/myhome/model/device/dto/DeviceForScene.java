package pro.dengyi.myhome.model.device.dto;

import java.util.List;
import lombok.Data;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.ProductField;
import pro.dengyi.myhome.model.system.Room;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/3 14:55
 * @description：场景模式数据传输实体
 * @modified By：
 */
@Data
public class DeviceForScene extends Device {

  private List<ProductField> productFields;

  private Product product;

  private Room room;


}
