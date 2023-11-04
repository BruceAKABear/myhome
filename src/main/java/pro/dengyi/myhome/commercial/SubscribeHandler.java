package pro.dengyi.myhome.commercial;

import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

/**
 * the handler for control plan
 *
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/11/2 15:01
 * @description：
 * @modified By：
 */

@Component
public class SubscribeHandler {

    private String defaultPlan = "primary";

    @PostConstruct
    public void initSubscribePlan() throws SocketException {
        Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();

        while (networkInterfaces.hasMoreElements()) {
            NetworkInterface networkInterface = networkInterfaces.nextElement();

            if (!networkInterface.isVirtual() && !networkInterface.isLoopback()) {
                byte[] mac = networkInterface.getHardwareAddress();

                // 判断MAC地址是否存在
                if (mac != null) {
                    StringBuilder macAddress = new StringBuilder();
                    for (int i = 0; i < mac.length; i++) {
                        macAddress.append(String.format("%02X", mac[i]));
                        if (i < mac.length - 1) {
                            macAddress.append("-");
                        }
                    }
                    System.err.println("MAC Address: " + macAddress.toString());
                }
            }
        }

        System.err.println("out in post construct");

    }


}
