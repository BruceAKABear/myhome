package pro.dengyi.myhome;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.DelayQueue;
import java.util.concurrent.Delayed;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/9/6 13:37
 * @description：
 * @modified By：
 */
@SpringBootTest(classes = MyhomeApplication.class, webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT
)
public class DelayQueueTest {

    private DelayQueue<Delayed> delayedDelayQueue = new DelayQueue<>();


    @BeforeEach
    public void init() {


        DelayItem delayItem = new DelayItem(30, "abcd");
        DelayItem delayItem2 = new DelayItem(15, "aaaa");

        delayedDelayQueue.add(delayItem);
        delayedDelayQueue.add(delayItem2);

    }


    @Test
    public void getData() throws InterruptedException {
        DelayItem delayItem = (DelayItem) delayedDelayQueue.take();

        System.out.println("delayItem is :"+delayItem.getOrderCode());

    }


}
