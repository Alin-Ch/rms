package com.www.config.alipay;

import lombok.Data;

/**
 * @Author Alin
 * @date 2024/5/3 003 16:12
 * @Description:
 */
@Data
public class AliPay {
    private String traceNo;
    private double totalAmount;
    private String subject;
    private String alipayTraceNo;
}
