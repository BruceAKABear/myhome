package pro.dengyi.myhome.controller.device;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.device.ProductField;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.ProductFieldService;

import java.util.List;

/**
 * 设备字段controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "产品字段接口")
@Validated
@RestController
@RequestMapping("/productField")
public class ProductFieldController {

    @Autowired
    private ProductFieldService productFieldService;

    @ApiOperation("查询产品字段集合")
    @GetMapping("/fieldList")
    public DataResponse<List<ProductField>> fieldList(String deviceId, String productId) {
        List<ProductField> fieldList = productFieldService.fieldList(deviceId, productId);
        return new DataResponse<>(fieldList);
    }


}
