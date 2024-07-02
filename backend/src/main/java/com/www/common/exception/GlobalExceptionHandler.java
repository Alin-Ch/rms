package com.www.common.exception;

import com.www.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;


/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/24/20:28
 * @Description:    全局异常处理器
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    /**
     * Security权限异常处理
     * @param e
     * @return
     */
    @ResponseStatus(HttpStatus.FORBIDDEN)
    @ExceptionHandler(value = AccessDeniedException.class)
    public Result handler(AccessDeniedException e){
        log.info("Security权限不足：--------------{}",e.getMessage());
        return Result.fail("权限不足");
    }

    /**
     * 实体参数校验异常处理
     * @param e
     * @return
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public Result handler(MethodArgumentNotValidException e){
        BindingResult bindingResult = e.getBindingResult();
        ObjectError objectError = bindingResult.getAllErrors().stream().findFirst().get();
        log.info("实体校验异常：----------------{}",objectError.getDefaultMessage());
        return Result.fail(objectError.getDefaultMessage());
    }

    /**
     * 非法数据异常处理
     * @param e
     * @return
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = IllegalArgumentException.class)
    public Result handler(IllegalArgumentException e) {
        log.error("非法参数异常：----------------{}",e.getMessage());
        return Result.fail(e.getMessage());
    }

    /**
     * 运行时异常处理
     * @param e
     * @return
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)     // 400错误，失败请求状态码
    @ExceptionHandler(value = RuntimeException.class)
    public Result handler(RuntimeException e) {
        log.error("运行时异常：-----------------{}",e.getMessage());
        return Result.fail(e.getMessage());
    }

    /**
     * 自定义异常
     * @param e
     * @return
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = CustomException.class)
    public Result handleCustomException(CustomException e) {
        // 捕获 CustomException 异常并返回自定义的错误信息给前端
        return Result.fail(e.getMessage());
    }
}
