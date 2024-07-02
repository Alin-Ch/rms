package com.www.controller;

import cn.hutool.core.lang.generator.SnowflakeGenerator;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.*;
import com.www.utils.RedisUtil;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @Author Alin
 * @date 2024/5/2 002 19:55
 * @Description:
 */
@RestController
@RequestMapping("/sys/order")
@Api(tags = "订单管理")
public class SysOrderController {
    private final SysOrderService sysOrderService;
    private final SysUserService sysUserService;
    private final SysUserRoleService sysUserRoleService;
    private final SysHouseService sysHouseService;
    private final SysHouseShowService sysHouseShowService;
    private final SysHouseShowVideoService sysHouseShowVideoService;
    private final MyPage myPage;
    private final SnowflakeGenerator snowflakeGenerator;
    private final RedisUtil redisUtil;

    public SysOrderController(SysOrderService sysOrderService, SysUserService sysUserService, SysUserRoleService sysUserRoleService, SysHouseService sysHouseService, SysHouseShowService sysHouseShowService, SysHouseShowVideoService sysHouseShowVideoService, MyPage myPage,
                              SnowflakeGenerator snowflakeGenerator, RedisUtil redisUtil) {
        this.sysOrderService = sysOrderService;
        this.sysUserService = sysUserService;
        this.sysUserRoleService = sysUserRoleService;
        this.sysHouseService = sysHouseService;
        this.sysHouseShowService = sysHouseShowService;
        this.sysHouseShowVideoService = sysHouseShowVideoService;
        this.myPage = myPage;
        this.snowflakeGenerator = snowflakeGenerator;
        this.redisUtil = redisUtil;
    }

    @GetMapping("/detail/{id}")
    @ApiOperation("根据id获取订单详情")
    public Result getOneById(@PathVariable("id") String id) {
        SysOrder sysOrder = sysOrderService.getById(id);
        SysUser sysUser = sysUserService.getById(sysOrder.getUserId());
        SysUser owner = sysUserService.getById(sysOrder.getOwnerId());
        sysOrder.setUser(sysUser);
        sysOrder.setOwner(owner);
        SysHouse sysHouse = sysHouseService.getById(sysOrder.getHouseId());
        List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
        sysHouse.setList(houseShowList);
        List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", sysHouse.getId()));
        sysHouse.setVideoList(houseShowVideoList);
        sysOrder.setHouse(sysHouse);

        return Result.success(sysOrder);
    }

    @GetMapping("/check/{orderNo}")
    public Result checkStatusById(@PathVariable("orderNo") Long orderNo) {
        QueryWrapper<SysOrder> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_no", orderNo);

        SysOrder sysOrder = sysOrderService.getOne(queryWrapper);

        if (sysOrder != null) {
            return Result.success(true);
        } else {
            // 如果没有找到匹配的记录，返回错误的结果
            return Result.fail("false");
        }
    }

    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list(String order_no, Long userId, Integer status, Principal principal) {
        // 分页查询、模糊查询
        Page<SysOrder> page = myPage.getPage();
        IPage<SysOrder> pageData = null;
        // 从安全上下文获取主体，并根据当前登录用户查询用户实体
        SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
        // 连表查询当前登录用户的角色信息
        SysUserRole userRole = sysUserRoleService.getOne(new QueryWrapper<SysUserRole>().eq("user_id", user.getId()));
        // 判断登录用户角色
        if (userRole.getRoleId() == 3L) {
            // 如果是商家登录，则只查询他自己的
            SysUser sysUser = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            pageData = sysOrderService.selectBySeller(page, sysUser.getId(), order_no);
        } else if (userRole.getRoleId() == 2L) {
            // 管理员可以查询所有
            pageData = sysOrderService.selectByAdmin(page, order_no);
        } else if (userRole.getRoleId() == 1L) {
            // 普通用户
            SysUser sysUser = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            pageData = sysOrderService.selectByBuyer(page, sysUser.getId(), order_no, status);
            for (SysOrder sysOrder : pageData.getRecords()) {
                sysOrder.setUser(sysUser);
                sysOrder.setOwner(sysUserService.getById(sysOrder.getOwnerId()));
                SysHouse sysHouse = sysHouseService.getById(sysOrder.getHouseId());
                List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
                sysHouse.setList(houseShowList);
                List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", sysHouse.getId()));
                sysHouse.setVideoList(houseShowVideoList);

                sysOrder.setHouse(sysHouse);
            }
        }
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysOrder sysOrder) {
        sysOrder.setCreateTime(new Date());
        if (sysOrder.getHouseId() == null) {
            return Result.fail("请选择租房");
        }
        if (sysOrder.getUserId() == null) {
            return Result.fail("请选择租房人");
        }

        // 查询数据库，检查是否存在符合条件的订单
//        SysOrder existingOrder = sysOrderService.getOne(new QueryWrapper<SysOrder>()
//                .eq("house_id", sysOrder.getHouseId())
//                .eq("user_id", sysOrder.getUserId()));
//        if (existingOrder != null && existingOrder.getStatus() == 0) {
//            // 如果存在未支付的订单，返回提示信息给用户
//            return Result.fail("已存在未支付订单，请勿重复添加");
//        }

//        List<SysOrder> orderList = sysOrderService.getExisteOrders(sysOrder.getHouseId(),sysOrder.getUserId());
//        if (existingOrder != null && existingOrder.getStatus() == 0) {
//            // 如果存在未支付的订单，返回提示信息给用户
//            return Result.fail("已存在未支付订单，请勿重复添加");
//        }
        Long orderNo = snowflakeGenerator.next();
        sysOrder.setOrderNo(orderNo);
        // 这里应该 先获取house，再根据house的price来设置金额的，但这里只付定金
        BigDecimal money = BigDecimal.valueOf(100.00);
        sysOrder.setMoney(money);
        System.out.println(sysOrder);
        sysOrderService.save(sysOrder);

        // 加入redis，让订单超时未支付就取消订单
        String key = "order_" + sysOrder.getOrderNo();
        redisUtil.set(key, sysOrder.getOrderNo(), 60 );

        return Result.success(sysOrder);
    }



    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysOrder sysOrder) {
        sysOrder.setUpdateTime(new Date());
        if (sysOrder.getHouseId() == null) {
            return Result.fail("请选择租房");
        }
        if (sysOrder.getUserId() == null) {
            return Result.fail("请选择租房人");
        }
        sysOrderService.updateById(sysOrder);
        return Result.success("修改成功！");
    }

    @PostMapping("/delete")
    @ApiOperation("删除")
    @Transactional
    public Result info(@RequestBody Long[] ids) {
//        sysHouseService.removeById(id);
        sysOrderService.removeByIds(Arrays.asList(ids));

        return Result.success("删除成功");
    }


}
