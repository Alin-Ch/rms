package com.www.config.aliyun;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @Author Alin
 * @date 2024/5/9 009 13:00
 * @Description:
 */
@ConfigurationProperties(prefix = "aliyun.oss.file")
@Configuration
@Data
public class OSSConfig {
    private String endPoint;
    private String accessKeyID;
    private String accessKeySecret;
    private String bucketName;
}

