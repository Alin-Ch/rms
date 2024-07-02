package com.www.config.alipay;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @Author Alin
 * @date 2024/5/3 003 16:13
 * @Description:
 */
@Data
@ConfigurationProperties(prefix = "alipay")
@Configuration
public class AliPayConfig {
    private String appId;
    private String appPrivateKey;
    private String alipayPublicKey;
    private String notifyUrl;
    private String returnUrl;
}

