package pro.dengyi.myhome.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import pro.dengyi.myhome.model.User;

import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.Date;

/**
 * token工具类
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public class TokenUtil {

    /**
     * subject
     */
    public static final String SUBJECT = "myhome";
    /**
     * 过期时间
     */
    public static final long EXPIREDAYS = 30;
    /**
     * 加密秘钥
     */
    public static final String APPSECRET = "myhome123!@#";

    /**
     * 生成 jwt token方法
     *
     * @return token字符串
     */
    public static String genToken(User user) {

        String token =
                Jwts.builder()
                        .setSubject(SUBJECT)
                        .claim("userId", user.getId())
                        .claim("houseHolder", user.getHouseHolder())
                        .setIssuedAt(new Date())
                        .setExpiration(
                                Date.from(
                                        LocalDate.now()
                                                .plusDays(EXPIREDAYS)
                                                .atStartOfDay(ZoneOffset.ofHours(8))
                                                .toInstant()))
                        .signWith(SignatureAlgorithm.HS256, APPSECRET)
                        .compact();
        return token;
    }

    /**
     * 解析token
     *
     * @param token
     * @return
     */
    public static User decToken(String token) {

        User user = new User();
        Claims body = Jwts.parser().setSigningKey(APPSECRET).parseClaimsJws(token).getBody();
        String id = (String) body.get("userId");
        Boolean houseHolder = (Boolean) body.get("houseHolder");
        user.setId(id);
        user.setHouseHolder(houseHolder);
        return user;
    }
}
