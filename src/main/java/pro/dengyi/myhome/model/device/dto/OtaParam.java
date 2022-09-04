package pro.dengyi.myhome.model.device.dto;

import lombok.Data;

/**
 * ota参数
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-09-04
 */
@Data
public class OtaParam {

  private String deviceId;
  private Integer targetVersion;
  private String targetUrl;

}
