package com.www.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/04/04/15:45
 * @Description:
 */
public class AliOSSException extends AuthenticationException {
    public AliOSSException(String msg) {
        super(msg);
    }
}
