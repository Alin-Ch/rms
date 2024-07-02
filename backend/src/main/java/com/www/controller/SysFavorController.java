package com.www.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.*;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @Author Alin
 * @date 2024/5/10 010 14:23
 * @Description: 商品收藏
 */
@RestController
@RequestMapping("/sys/favor")
@Api(tags = "商品收藏")
public class SysFavorController {
    private final SysFavorService sysFavorService;
    private final SysUserService sysUserService;
    private final SysHouseService sysHouseService;
    private final SysHouseShowService sysHouseShowService;
    private final UserHouseOperationService userHouseOperationService;
    private final MyPage myPage;

    public SysFavorController(SysFavorService sysFavorService, SysUserService sysUserService, SysHouseService sysHouseService, SysHouseShowService sysHouseShowService, UserHouseOperationService userHouseOperationService, MyPage myPage) {
        this.sysFavorService = sysFavorService;
        this.sysUserService = sysUserService;
        this.sysHouseService = sysHouseService;
        this.sysHouseShowService = sysHouseShowService;
        this.userHouseOperationService = userHouseOperationService;
        this.myPage = myPage;
    }

    @GetMapping("/list/origin")
    @ApiOperation("分页查询")
    public Result listOrigin() {
        // 分页查询、模糊查询
        Page<SysFavor> pageData = sysFavorService.page(myPage.getPage(),
                new QueryWrapper<SysFavor>().orderByDesc("create_time"));
        for (SysFavor item : pageData.getRecords()) {
            SysHouse sysHouse = sysHouseService.getById(item.getId());
            item.setHouse(sysHouse);
        }
        return Result.success(pageData);
    }

    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list(String houseName, Principal principal) {
        Long userId = null;
        if (principal != null) {
            SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            userId = user.getId();
        }
        // 分页查询、模糊查询
        QueryWrapper<SysFavor> queryWrapper = new QueryWrapper<SysFavor>()
                .like(StrUtil.isNotBlank(houseName), "house_name", houseName)
                .orderByDesc("create_time");
        if (userId != null) {
            queryWrapper.eq("user_id", userId);
        }
        Page<SysFavor> pageData = sysFavorService.page(myPage.getPage(), queryWrapper);
        for (SysFavor item : pageData.getRecords()) {
            SysHouse sysHouse = sysHouseService.getById(item.getHouseId());
            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
            // 将查询到的数据加入到 SysHouse 对象中
            sysHouse.setList(houseShowList);
            item.setHouse(sysHouse);
        }
        return Result.success(pageData);
    }


    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysFavor sysFavor) {
        if (sysFavor == null || sysFavor.getUserId() == null || sysFavor.getHouseId() == null) {
            return Result.fail("缺少参数");
        }
        sysFavor.setCreateTime(new Date());
        sysFavorService.save(sysFavor);
        return Result.success(sysFavor);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysFavor sysFavor) {
        sysFavor.setUpdateTime(new Date());
        sysFavorService.updateById(sysFavor);
        return Result.success("修改成功！");
    }

    @PostMapping("/delete")
    @ApiOperation("删除")
    public Result info(@RequestBody Long[] ids) {
        sysFavorService.removeByIds(Arrays.asList(ids));
        return Result.success("删除成功");
    }

    @GetMapping("/check/{userid}/{houseid}")
    @ApiOperation("查询用户是否收藏了这个商品")
    public Result isFavor(@PathVariable("userid") Long userid, @PathVariable("houseid") Long houseid, Principal principal) {
        // 其实可以用 security 框架的来先查询登录用户，再去查是否收藏  这里用的其他方法
        QueryWrapper<SysFavor> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userid)
                .eq("house_id", houseid);
        SysFavor sysFavor = sysFavorService.getOne(queryWrapper);
        if (sysFavor != null) {
            return Result.success(true); // 已收藏
        } else {
            return Result.success(false); // 未收藏
        }
    }

    @PostMapping("/add")
    @ApiOperation("加入收藏")
    public Result addFavor(@RequestBody SysFavor sysFavor, Principal principal) {
        sysFavor.setCreateTime(new Date());
        sysFavorService.save(sysFavor);
        // new一个推荐表的实体
        UserHouseOperation userHouseOperation = new UserHouseOperation();
        userHouseOperation.setUserId(sysFavor.getUserId());
        userHouseOperation.setItemId(sysFavor.getHouseId());
        userHouseOperation.setOperationType(2);  // 收藏
        userHouseOperation.setCreateTime(new Date());
        userHouseOperationService.save(userHouseOperation);

        return Result.success("已加入收藏！");
    }

    @PostMapping("/delete/{userid}/{houseid}")
    @ApiOperation("取消收藏")
    public Result deleteFavor(@PathVariable("userid") Long userid, @PathVariable("houseid") Long houseid) {
        sysFavorService.deleteFavor(userid, houseid);
        userHouseOperationService.remove(new QueryWrapper<UserHouseOperation>()
                .eq("user_id", userid)
                .eq("item_id", houseid));
        return Result.success("已取消收藏！");
    }

}
