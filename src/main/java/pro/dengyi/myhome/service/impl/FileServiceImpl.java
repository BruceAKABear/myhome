package pro.dengyi.myhome.service.impl;

import java.io.File;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pro.dengyi.myhome.service.FileService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-30
 */
@Service
public class FileServiceImpl implements FileService {

  @Override
  public String uploadFile(MultipartFile file) {
    return null;
  }

  @Override
  public File preview(String fileId) {
    return null;
  }
}
