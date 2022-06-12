package pro.dengyi.myhome.model.device.dto;

import lombok.Data;

/**
 * 设备连接参数dto
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-12
 * <p>
 * <p>
 * %u：用户名 %c：Client ID %a：客户端 IP 地址 %r：客户端接入协议 %P：明文密码 %p：客户端端口 %C：TLS 证书公用名（证书的域名或子域名），仅当 TLS 连接时有效
 * %d：TLS 证书 subject，仅当 TLS 连接时有效
 */
@Data
public class DeviceLoginDto {

  private String clientId;

  private String userName;

  private String password;

}
