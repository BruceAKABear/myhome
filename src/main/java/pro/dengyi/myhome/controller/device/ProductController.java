package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import javax.validation.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.dto.ProductAddDto;
import pro.dengyi.myhome.model.device.dto.ProductPageDto;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.ProductService;

/**
 * 设备分类controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "产品接口")
@Validated
@RestController
@RequestMapping("/product")
public class ProductController {

  @Autowired
  private ProductService productService;


  @ApiOperation("新增或修改产品")
  @PostMapping("/addUpdate")
  public CommonResponse addUpdate(@RequestBody @Validated ProductAddDto productAddDto) {
    productService.addUpdate(productAddDto);
    return CommonResponse.success();
  }

  @ApiOperation("删除分类")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
    productService.delete(id);
    return CommonResponse.success();
  }

  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<ProductPageDto>> page(Integer page, Integer size, String name) {
    IPage<ProductPageDto> pageResult = productService.page(page, size, name);
    return new DataResponse<>(pageResult);
  }

  @ApiOperation("查询产品下拉")
  @GetMapping("/list")
  public DataResponse<List<Product>> categoryList() {
    List<Product> products = productService.categoryList();
    return new DataResponse<>(products);
  }


}
