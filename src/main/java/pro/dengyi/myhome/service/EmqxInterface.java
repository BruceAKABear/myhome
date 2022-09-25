package pro.dengyi.myhome.service;

import com.github.lianjiatech.retrofit.spring.boot.core.RetrofitClient;

/**
 * emqx接口
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-09-25
 */
@RetrofitClient(baseUrl = "${test.baseUrl}")
public interface EmqxInterface {

}
