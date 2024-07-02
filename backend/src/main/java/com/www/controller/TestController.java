package com.www.controller;

import cn.hutool.core.lang.generator.SnowflakeGenerator;
import cn.hutool.json.JSONObject;
import com.www.pojo.SysUser;
import com.www.pojo.Test;
import com.www.service.SysUserService;
import com.www.service.TestService;
import com.www.utils.AliOSSUtils;
import com.www.utils.RedisUtil;
import com.www.vo.Result;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/24/19:51
 * @Description:
 */
@RestController
@RequestMapping("/test")
public class TestController {
    private final TestService testService;
    private final SnowflakeGenerator snowflakeGenerator;
    private final RedisUtil redisUtil;

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private PasswordEncoder passwordEncoder;    // 密码加密器

    @Autowired
    private AliOSSUtils aliOSSUtils;

    public TestController(TestService testService, SnowflakeGenerator snowflakeGenerator, RedisUtil redisUtil) {
        this.testService = testService;
        this.snowflakeGenerator = snowflakeGenerator;
        this.redisUtil = redisUtil;
    }

    @PreAuthorize("hasRole('admin')")
    @GetMapping("/list")
    public Result test() {
        return Result.success(sysUserService.list());
    }

    @PostMapping("/add")
    public Result pass(@RequestBody SysUser sysUser) {
        sysUser.setCreated(new Date());
        sysUser.setPassword(passwordEncoder.encode(sysUser.getPassword()));
        sysUserService.save(sysUser);
        return Result.success("成功!");
    }

    // 加密解密
    @GetMapping("/encrypt")
    public Result encrypt(@RequestBody JSONObject req) {
        System.out.println("encrypt params:({})" + req);
        return Result.success(req);
    }

    /**
     * 测试上传头像接口，模拟修改用户信息
     *
     * @param sysUser
     * @param image
     * @return
     * @throws IOException
     */
    @PostMapping("/upload")
    public Result upload(@Validated @RequestPart("req") SysUser sysUser, @RequestPart("image") MultipartFile image) throws IOException {
        // 把图片上传到阿里云OSS服务中
        String url = aliOSSUtils.upload(image);
        sysUser.setUpdated(new Date());
        sysUser.setAvatar(url);
        sysUserService.updateById(sysUser);
        return Result.success(sysUser);
    }


    @PostMapping("/order/save")
    @ApiOperation("新增")
    public Result save(@RequestBody Test sysOrder) {
        sysOrder.setCreateTime(new Date());
        if (sysOrder.getHouseId() == null) {
            return Result.fail("请选择租房");
        }
        if (sysOrder.getUserId() == null) {
            return Result.fail("请选择租房人");
        }

        Long orderNo = snowflakeGenerator.next();
        sysOrder.setOrderNo(orderNo);
        // 这里应该 先获取house，再根据house的price来设置金额的，但这里只付定金
        BigDecimal money = BigDecimal.valueOf(100.00);
        sysOrder.setMoney(money);
        System.out.println(sysOrder);
        testService.save(sysOrder);
        // 加入redis，让订单超时未支付就取消订单
//        String key = "order_" + sysOrder.getOrderNo();
//        redisUtil.set(key, sysOrder.getOrderNo(), 60 );
        return Result.success(sysOrder);
    }










}
