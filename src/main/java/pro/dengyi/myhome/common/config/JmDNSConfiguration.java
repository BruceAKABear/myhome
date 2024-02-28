package pro.dengyi.myhome.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.jmdns.JmDNS;
import javax.jmdns.ServiceInfo;
import java.io.IOException;
import java.net.InetAddress;

//@Configuration
public class JmDNSConfiguration {

    @Bean
    public JmDNS jmDNS() throws IOException {
        return JmDNS.create(InetAddress.getLocalHost());
    }

    @Bean
    public ServiceInfo serviceInfo() {
        return ServiceInfo.create("_http._tcp.local.", "myhome", 8080, "path" +
                "=/");
    }

    public static void main(String[] args) throws IOException {
        // Create a JmDNS instance.
        JmDNS jmdns = JmDNS.create(InetAddress.getLocalHost());
        // Get all the services.
        ServiceInfo[] services = jmdns.list("_http._tcp.local.");

        // Iterate over all the services and print their information.
        for (ServiceInfo service : services) {
            System.out.println("Service name: " + service.getName());
            System.out.println("Service type: " + service.getType());
            System.out.println("Service port: " + service.getPort());
        }
    }
}