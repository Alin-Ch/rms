package com.www.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.SysHistoryService;
import com.www.service.SysHouseService;
import com.www.service.SysHouseShowService;
import com.www.service.SysUserService;
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
 * @date 2024/5/10 010 14:08
 * @Description:
 */
@RestController
@RequestMapping("/sys/history")
@Api(tags = "用户浏览历史管理")
public class SysHistoryController {
    private final SysHistoryService sysHistoryService;
    private final SysUserService sysUserService;
    private final SysHouseService sysHouseService;
    private final SysHouseShowService sysHouseShowService;
    private final MyPage myPage;

    public SysHistoryController(SysHistoryService sysHistoryService, SysUserService sysUserService, SysHouseService sysHouseService, SysHouseShowService sysHouseShowService, MyPage myPage) {
        this.sysHistoryService = sysHistoryService;
        this.sysUserService = sysUserService;
        this.sysHouseService = sysHouseService;
        this.sysHouseShowService = sysHouseShowService;
        this.myPage = myPage;
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
        QueryWrapper<SysHistory> queryWrapper = new QueryWrapper<SysHistory>()
                .like(StrUtil.isNotBlank(houseName), "house_name", houseName)
                .orderByDesc("create_time");
        if (userId != null) {
            queryWrapper.eq("user_id", userId);
        }
        Page<SysHistory> pageData = sysHistoryService.page(myPage.getPage(), queryWrapper);
        for (SysHistory item : pageData.getRecords()) {
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
    public Result save(@RequestBody SysHistory sysHistory) {
        if (sysHistory == null || sysHistory.getUserId() == null || sysHistory.getHouseId() == null) {
            return Result.fail("缺少参数");
        }
        sysHistory.setCreateTime(new Date());
        sysHistoryService.save(sysHistory);
        return Result.success(sysHistory);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysHistory sysHistory) {
        sysHistory.setUpdateTime(new Date());
        sysHistoryService.updateById(sysHistory);
        return Result.success("修改成功！");
    }

    @PostMapping("/delete")
    @ApiOperation("删除")
    public Result info(@RequestBody Long[] ids) {
        sysHistoryService.removeByIds(Arrays.asList(ids));
        return Result.success("删除成功");
    }


}
