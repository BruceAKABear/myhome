package pro.dengyi.myhome.controller.common;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.common.response.DataResponse;
import pro.dengyi.myhome.common.utils.IpUtil;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;

/**
 * 文件controller
 * <p>
 * 提供对文件的上传、预览、下载、删除
 * <p>
 * 文件未使用任何文件系统，均存储在本地磁盘中，简化对外界环境的依赖
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

    @Value("${system.file-prefix}")
    private String filePrefix;


    /**
     * 用于上传文件
     * <p>
     * 文件归纳为：普通文件和设备固件
     * <p>
     * 对于设备固件来说，只能内网访问下载
     * <p>
     * 对于图片等文件来说则无要求
     *
     * @param file
     * @return
     * @throws IOException
     */
    @Permission
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
        //同名存在替换
        Files.copy(file.getInputStream(), path.resolve(dirPath + "/" + file.getOriginalFilename()),
                StandardCopyOption.REPLACE_EXISTING);
        String fileUrl;
        if (file.getOriginalFilename().endsWith(".bin")) {
            //固件
            fileUrl = "/file/preview?fileName=" + file.getOriginalFilename();
        } else {
            //其他文件,外网地址未配置使用内网地址
            if (ObjectUtils.isEmpty(filePrefix)) {
                String ip = IpUtil.getIp();
                fileUrl = "http://" + ip + ":" + serverPort + "/file/preview?fileName="
                        + file.getOriginalFilename();
            } else {
                fileUrl = filePrefix + "/file/preview?fileName=" + file.getOriginalFilename();
            }

        }
        return new DataResponse<>(fileUrl);
    }

    @ApiOperation("预览文件")
    @GetMapping("/preview")
    public void preview(String fileName, HttpServletResponse response) throws IOException {
        String path = System.getProperties().get("user.dir") + "/files/" + fileName;
        File file = new File(path);
        FileInputStream fileInputStream = new FileInputStream(path);
        ServletOutputStream outputStream = response.getOutputStream();
        String extName = fileName.substring(fileName.indexOf('.') + 1);

        String[] picExtName = new String[]{"jpg", "png", "jpeg"};
        if (!Arrays.asList(picExtName).contains(extName)) {
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.setContentLength((int) file.length());
        } else {
            response.setContentType("image/jpeg");
            response.setContentLength((int) file.length());
        }
        byte[] buffer = new byte[1024 * 8];
        int bytesRead;
        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        fileInputStream.close();
        outputStream.close();
    }

}
