package pro.dengyi.myhome.common.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 初始化配置
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Data
@Component
@ConfigurationProperties(prefix = "system")
public class SystemProperties {

    /**
     * 服务端clientId集合
     * <p>
     * 用作同一broker环境下多服务端启动时防止冲突使用
     */
    private List<String> mqttClientIds;

    /**
     * broker ip地址
     */
    private String mqttHostIp;

    /**
     * broker端口
     */
    private String mqttPort;

    /**
     * mqtt是否开启ssl标识
     */
    private Boolean mqttOpenSsl = false;

    /**
     * emqx api key
     */

    private String mqttApiKey;
    /**
     * emqx api secret
     */
    private String mqttApiSecret;


    private String filePrefix;


    //处理时间配置
    private Boolean openProcessTimeLog = true;
    private Long apiProcessLimitation = 60L;
    private String notifyUserEmails;

    //当前订阅模式
    private String currentPayMode;

    //极客模式 开启后将可以自行添加设备
    private Boolean geekMode;

}
