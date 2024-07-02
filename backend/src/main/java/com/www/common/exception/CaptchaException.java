package com.www.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/13:53
 * @Description:        图形验证码异常
 */
public class CaptchaException extends AuthenticationException {
    public CaptchaException(String msg) {
        super(msg);
    }
}
