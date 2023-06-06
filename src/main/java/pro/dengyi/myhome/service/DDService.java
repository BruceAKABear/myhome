package pro.dengyi.myhome.service;

import com.github.lianjiatech.retrofit.spring.boot.core.RetrofitClient;
import org.springframework.stereotype.Component;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Query;

import java.util.HashMap;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/4/15 9:36
 * @description：钉钉服务类
 * @modified By：
 */
@Component
@RetrofitClient(baseUrl = "https://oapi.dingtalk.com")
public interface DDService {


    /**
     * 登录获取at
     *
     * @return
     */
    @GET("/gettoken")
    HashMap<String, Object> getAccessToken(@Query("appkey") String appkey,
                                           @Query("appsecret") String appsecret);


    @POST("/topapi/v2/user/getuserinfo")
    HashMap<String, Object> userInfo(@Query("access_token") String accessToken,
                                     @Body Map<String, String> params);

    @POST("/topapi/v2/user/get")
    HashMap<String, Object> userDetailInfo(@Query("access_token") String accessToken,
                                           @Body Map<String, String> params);


}
