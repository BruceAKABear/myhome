package pro.dengyi.myhome.service;

import java.io.File;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
public interface FileService {

  String uploadFile(MultipartFile file);

  File preview(String fileId);
}
