package com.www.common.aop;

import com.www.pojo.SysLog;
import com.www.service.SysLogService;
import com.www.utils.JwtUtils;
import com.www.vo.Result;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * @Author Alin
 * @date 2024/5/12 012 11:16
 * @Description:
 */
@Component
@Aspect
public class LogAspect {


    private final JwtUtils jwtUtils;

    private final SysLogService sysLogService;

    public LogAspect(JwtUtils jwtUtils,
                     SysLogService sysLogService) {
        this.jwtUtils = jwtUtils;
        this.sysLogService = sysLogService;
    }

    /**
     * 环绕（围绕）通知
     *
     * @param joinPoint 切入点
     * @param autoLog   注解
     * @return
     */
    @Around("@annotation(autoLog)")
    public Object doAround(ProceedingJoinPoint joinPoint, AutoLog autoLog) throws Throwable {
        // 操作内容，我们在注解里已经定义了Value()，然后再需要切入的接口上面去写上对应的操作内容即可
        String name = autoLog.value();
        // 操作时间
        Date time = new Date();
        // 操作人，即当前登录用户的用户名
        // 获取JWT
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        // 从请求头中拿jwt
        String jwt = request.getHeader(jwtUtils.getHeader());
        // 解析jwt获取用户名
        String username = jwtUtils.getUsernameFromToken(jwt);

        // 操作人ip
        String ip = request.getRemoteAddr();

        // 执行具体的接口
        Result result = (Result) joinPoint.proceed();

        SysLog log = new SysLog();
        log.setUsername(username);
        log.setOperateName(name);
        log.setCreateTime(time);
        log.setIp(ip);
        // 将日志写入数据库
        sysLogService.save(log);
        return result;
    }

    /**
     * 记录登录日志
     */
    public void logLogin(String username, String ipAddress, Long userId) {
        // 构造 SysLog 对象
        SysLog log = new SysLog();
        log.setUsername(username);
        log.setOperateName("用户登录");
        log.setCreateTime(new Date());
        log.setIp(ipAddress);
        log.setUserId(userId);

        // 将日志写入数据库或者其他存储介质
        sysLogService.save(log);
    }
}
