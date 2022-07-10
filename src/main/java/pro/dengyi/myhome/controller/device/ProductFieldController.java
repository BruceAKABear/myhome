package pro.dengyi.myhome.controller.device;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import javax.validation.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.HolderPermission;
import pro.dengyi.myhome.model.device.ProductField;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.ProductFieldService;

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

  @HolderPermission
  @ApiOperation("查询产品字段集合")
  @GetMapping("/fieldList")
  public DataResponse<List<ProductField>> fieldList(
      @RequestParam @NotBlank(message = "产品ID不能为空") String deviceId) {
    List<ProductField> fieldList = productFieldService.fieldList(deviceId);
    return new DataResponse<>(fieldList);
  }


}
