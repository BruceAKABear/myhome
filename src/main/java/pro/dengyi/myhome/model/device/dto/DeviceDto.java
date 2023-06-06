package pro.dengyi.myhome.model.device.dto;

import lombok.Data;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.ProductField;

import java.util.List;

/**
 * @author BLab
 */
@Data
public class DeviceDto extends Device {

    /**
     * 所属产品
     */
    private Product product;

    /**
     * 产品对应字段
     */
    private List<ProductField> productFieldList;

    /**
     * 当前状态
     */
    private String currentStatus;


    private String floorName;
    private String roomName;
    private String productName;


}
