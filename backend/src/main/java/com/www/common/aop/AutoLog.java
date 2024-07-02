package com.www.common.aop;

import java.lang.annotation.*;

/**
 * @Author Alin
 * @date 2024/5/12 012 11:15
 * @Description:
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AutoLog {
    String value() default "";
}

