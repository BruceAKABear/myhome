package pro.dengyi.myhome.common.mdns;

import javax.jmdns.JmDNS;
import javax.jmdns.ServiceEvent;
import javax.jmdns.ServiceInfo;
import javax.jmdns.ServiceListener;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class ExampleServiceDiscovery {

    private static class SampleListener implements ServiceListener {
        @Override
        public void serviceAdded(ServiceEvent event) {
            System.out.println("Service added: " + event.getInfo());
        }

        @Override
        public void serviceRemoved(ServiceEvent event) {
            System.out.println("Service removed: " + event.getInfo());
        }

        @Override
        public void serviceResolved(ServiceEvent event) {
            System.out.println("Service resolved: " + event.getInfo());
        }
    }

    public static void main(String[] args) throws InterruptedException {
        try {
            // Create a JmDNS instance
            JmDNS jmdns = JmDNS.create(InetAddress.getLocalHost());
            ServiceInfo[] list = jmdns.list("_http._tcp.local.");
            System.out.println(list.length);

            for (ServiceInfo serviceInfo : list) {
                System.err.println(serviceInfo);
            }
//            Java™

            // Add a service listener
            jmdns.addServiceListener("_http._tcp.local.", new SampleListener());

            // Wait a bit
            Thread.sleep(30000);
        } catch (UnknownHostException e) {
            System.err.println(e.getMessage());
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }
}