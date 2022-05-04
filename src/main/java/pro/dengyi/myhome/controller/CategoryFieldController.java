package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.CategoryField;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.CategoryFieldService;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Api(tags = "设备分类字段接口")
@Validated
@RestController
@RequestMapping("/categoryField")
public class CategoryFieldController {

  @Autowired
  private CategoryFieldService categoryFieldService;


  @ApiOperation("根据设备ID查询所有字段")
  @GetMapping("/fieldList")
  public DataResponse<List<CategoryField>> fieldList(
      @NotBlank(message = "设备ID不能为空") String deviceId) {
    List<CategoryField> categoryFieldList = categoryFieldService.fieldList(deviceId);
    return new DataResponse<>(categoryFieldList);
  }


}
