package pro.dengyi.myhome.controller.device;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
import pro.dengyi.myhome.annotations.HolderPermission;
import pro.dengyi.myhome.model.device.Frameware;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.FramewareService;

/**
 * 固件controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Api(tags = "固件接口")
@Validated
@RestController
@RequestMapping("/frameware")
public class FramewareController {

  @Autowired
  private FramewareService framewareService;


  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<Frameware>> page(Integer page, Integer size, String productId) {
    IPage<Frameware> pageRes = framewareService.page(page, size, productId);
    return new DataResponse<>(pageRes);
  }

  @HolderPermission
  @ApiOperation("添加固件")
  @PostMapping("/add")
  public CommonResponse add(@RequestBody @Validated Frameware frameware) {
    framewareService.add(frameware);
    return CommonResponse.success();
  }


  @HolderPermission
  @ApiOperation("删除固件")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
    framewareService.delete(id);
    return CommonResponse.success();
  }


}
