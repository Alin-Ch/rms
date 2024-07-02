package com.www.utils;

import io.jsonwebtoken.*;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/17:11
 * @Description:
 */
@Data
@Component
@ConfigurationProperties(prefix = "wfzm.jwt")
public class JwtUtils {

    // 过期时间
    private long expire;

    // 密钥
    private String secret;

    // 给jwt起名
    private String header;

    // 生成jwt
    public String generateToken(String username) {

        Date nowDate = new Date();
        Date expireDate = new Date(nowDate.getTime() + 1000 * expire);

        return Jwts.builder()
                // 设置类型
                .setHeaderParam("typ", "JWT")
                // 设置主题
                .setSubject(username)
                // 创建时间
                .setIssuedAt(nowDate)
                // 设置过期时间
                .setExpiration(expireDate)
                // 设置加密算法和密钥
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
    }

    // 解析jwt
    public Claims getClaimByToken(String jwt) {

        // 如果jwt被篡改则抛出异常，返回null
        try {
            return Jwts.parser()
                    // 密钥
                    .setSigningKey(secret)
                    // 解析jwt
                    .parseClaimsJws(jwt)
                    // 获取主体
                    .getBody();
        } catch (Exception e) {
            return null;
        }
    }

    // 判断jwt是否过期
    public boolean isTokenExpired(Claims claims) {
        // 是否在当前时间前就过期了
        return claims.getExpiration().before(new Date());
    }

    // 从JWT中解析用户信息
    public String getUsernameFromToken(String jwt) {
        Claims claims = getClaimByToken(jwt);
        if (claims != null) {
            return claims.getSubject();
        }
        return null;
    }

}
