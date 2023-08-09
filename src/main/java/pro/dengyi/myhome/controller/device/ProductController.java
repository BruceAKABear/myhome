package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.device.dto.ProductAddDto;
import pro.dengyi.myhome.model.device.dto.ProductPageDto;
import pro.dengyi.myhome.service.ProductService;

import javax.validation.constraints.NotBlank;
import java.util.List;

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
    public void addUpdate(@RequestBody @Validated ProductAddDto productAddDto) {
        productService.addUpdate(productAddDto);
    }

    @ApiOperation("删除分类")
    @DeleteMapping("/delete/{id}")
    public void delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
        productService.delete(id);
    }

    @ApiOperation("分页查询")
    @GetMapping("/page")
    public IPage<ProductPageDto> page(Integer page, Integer size, String name) {
        return productService.page(page, size, name);
    }

    @ApiOperation("查询产品下拉")
    @GetMapping("/list")
    public List<Product> categoryList() {
        return productService.categoryList();
    }


}
