package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.utils.IpUtil;

/**
 * 文件controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Api(tags = "文件接口")
@Validated
@RestController
@RequestMapping("/file")
public class FileController {

  @Value("${server.port}")
  private Integer serverPort;


  @ApiOperation("上传文件")
  @PostMapping("/uploadFile")
  public DataResponse<String> uploadFile(
      @RequestPart("file") @RequestParam @NotNull(message = "文件不能为空") MultipartFile file)
      throws IOException {
    String dirPath = System.getProperties().get("user.dir") + "/files/";
    Path path = Paths.get(dirPath);
    if (!Files.exists(path)) {
      Files.createDirectories(path);
    }
    Files.copy(file.getInputStream(), path.resolve(dirPath + "/" + file.getOriginalFilename()),
        StandardCopyOption.REPLACE_EXISTING);
    String ip = IpUtil.getLocalIp4Address().get().toString().replaceAll("/", "");
    String fileUrl =
        "http://" + ip + ":" + serverPort + "/file/preview?fileName=" + file.getOriginalFilename();
    return new DataResponse<>(fileUrl);
  }

  @ApiOperation("预览文件")
  @GetMapping("/preview")
  public void preview(String fileName, HttpServletResponse response) throws IOException {
    String path = System.getProperties().get("user.dir") + "/files/" + fileName;
    File file = new File(path);
    FileInputStream fileInputStream = new FileInputStream(path);
    ServletOutputStream outputStream = response.getOutputStream();
    response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
    response.setContentLength((int) file.length());
    byte[] buffer = new byte[1024 * 8];
    int bytesRead;
    while ((bytesRead = fileInputStream.read(buffer)) != -1) {
      outputStream.write(buffer, 0, bytesRead);
    }
    fileInputStream.close();
    outputStream.close();
  }

}
