package pro.dengyi.myhome.controller.common;

import com.alibaba.fastjson.JSON;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.response.DataResponse;

/**
 * 文件controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Slf4j
@Api(tags = "通用接口")
@RestController
@RequestMapping
public class CommonController {

  @ApiOperation("请求主页")
  @GetMapping
  public DataResponse<String> index() {
    return new DataResponse<>("this is no any functions to visit this api");
  }

  @ApiOperation("请求异常")
  @GetMapping("/error")
  public DataResponse<String> error(HttpServletRequest request) {
    log.error("错误请求，信息为：{}", JSON.toJSONString(request.getRequestURI()));
    return new DataResponse<>("you may meet some error,you need to concat the system manager");
  }

}
