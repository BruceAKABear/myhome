package pro.dengyi.myhome.controller.system;

import com.sun.management.OperatingSystemMXBean;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import pro.dengyi.myhome.common.config.properties.SystemProperties;
import pro.dengyi.myhome.common.response.DataResponse;

import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 系统信息接口
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-06-12
 */
@Api(tags = "系统信息接口")
@RestController
@RequestMapping("/systemInfo")
public class SystemInfoController {

    @Autowired
    private SystemProperties systemProperties;


    @ApiOperation("查询系统基础信息")
    @GetMapping("/basicInfo")
    public DataResponse<Map<String, Object>> basicInfo() {
        Map<String, Object> map = new HashMap<>();
        OperatingSystemMXBean osmxb = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
        Properties properties = System.getProperties();
        map.put("osmxb", osmxb);
        map.put("properties", properties);
        map.put("javaVersion", properties.get("java.version"));
        map.put("jvmVersion", properties.get("java.vm.version"));

        //emqx
        RestTemplateBuilder restTemplateBuilder = new RestTemplateBuilder();
        RestTemplate restTemplate = restTemplateBuilder.basicAuthentication(
                systemProperties.getMqttApiKey(), systemProperties.getMqttApiSecret()).build();
        String url = "http://" + systemProperties.getMqttHostIp() + ":18083/api/v5/nodes";
        ResponseEntity<ArrayList> entity = restTemplate.getForEntity(url, ArrayList.class);
        map.put("emqxInfo", entity.getBody().get(0));

        String urlStatus = "http://" + systemProperties.getMqttHostIp() + ":18083/api/v5/stats";
        ResponseEntity<ArrayList> entityStatus = restTemplate.getForEntity(urlStatus, ArrayList.class);
        map.put("emqxStatus", entityStatus.getBody().get(0));
        return new DataResponse<>(map);
    }

    //6bf8cb828bb8152c
    //Ihde34oYFFGrF9CA9BJJU5LNzPUQxxkiISzbj7g6Q30ZF

}
