package com.www.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.SysHouse;
import com.www.pojo.SysHouseShow;
import com.www.service.SysHouseService;
import com.www.service.SysHouseShowService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * @Author Alin
 * @date 2024/4/28 028 14:21
 * @Description:
 */
@RestController
@RequestMapping("/sys/house/show")
@Api(tags = "出租房展示信息的管理")
public class SysHouseShowController {
    private final SysHouseService sysHouseService;
    private final SysHouseShowService sysHouseShowService;
    private final MyPage myPage;

    public SysHouseShowController(SysHouseService sysHouseService, SysHouseShowService sysHouseShowService, MyPage myPage) {
        this.sysHouseService = sysHouseService;
        this.sysHouseShowService = sysHouseShowService;
        this.myPage = myPage;
    }

    @PreAuthorize("hasAuthority('sys:house:list')")
    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list(String name) {
        // 分页查询、模糊查询
        Page<SysHouse> pageData = sysHouseService.page(myPage.getPage(),
                new QueryWrapper<SysHouse>().like(StrUtil.isNotBlank(name), "name", name));
        return Result.success(pageData);
    }

    @PreAuthorize("hasAuthority('sys:house:save')")
    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysHouse sysHouse) {
        sysHouse.setCreateTime(new Date());
        sysHouseService.save(sysHouse);
        return Result.success(sysHouse);
    }

    @PreAuthorize("hasAuthority('sys:house:update')")
    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysHouse sysHouse) {
        sysHouse.setUpdateTime(new Date());
        sysHouseService.updateById(sysHouse);
        return Result.success(sysHouse);
    }

    @PreAuthorize("hasAuthority('sys:house:delete')")
    @PostMapping("/delete")
    @ApiOperation("删除")
    @Transactional
    public Result info(@RequestBody Long[] id) {
        sysHouseService.removeById(id);
        // 删除中间表
        sysHouseShowService.remove(new QueryWrapper<SysHouseShow>().in("house_id", id));
        return Result.success("删除成功");
    }
}
