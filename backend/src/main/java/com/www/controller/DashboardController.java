package com.www.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.www.pojo.EchartsBie;
import com.www.pojo.SysLog;
import com.www.service.*;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author Alin
 * @date 2024/5/13 013 16:33
 * @Description:
 */
@RestController
@RequestMapping("/sys/echarts")
@Api(tags = "首页Echarts数据")
public class DashboardController {
    private final SysUserService sysUserService;
    private final SysHouseService sysHouseService;
    private final SysNoticeService sysNoticeService;
    private final SysLogService sysLogService;
    private final SysOrderService sysOrderService;
    private final SysHistoryService sysHistoryService;
    private final SysFavorService sysFavorService;

    public DashboardController(SysUserService sysUserService, SysHouseService sysHouseService, SysNoticeService sysNoticeService, SysLogService sysLogService, SysOrderService sysOrderService, SysHistoryService sysHistoryService, SysFavorService sysFavorService) {
        this.sysUserService = sysUserService;
        this.sysHouseService = sysHouseService;
        this.sysNoticeService = sysNoticeService;
        this.sysLogService = sysLogService;
        this.sysOrderService = sysOrderService;
        this.sysHistoryService = sysHistoryService;
        this.sysFavorService = sysFavorService;
    }


    @GetMapping("/user/count")
    @ApiOperation("用户数量")
    public Result getUserCount() {
        Long userCount = sysUserService.count();
        return Result.success(userCount);
    }

    @GetMapping("/house/count")
    @ApiOperation("商品数量")
    public Result getHouseCount() {
        Long houseCount = sysHouseService.count();
        return Result.success(houseCount);
    }

    @GetMapping("/visit/count")
    @ApiOperation("访问数量")
    public Result getVisitCount() {
        Long visitCount = sysLogService.count(new QueryWrapper<SysLog>().like("operate_name", "登录"));
        return Result.success(visitCount);
    }

    @GetMapping("/trade/count")
    @ApiOperation("已成交金额")
    public Result getTradedCount() {
        Long tradedCount = sysOrderService.getTradedCount();
        return Result.success(tradedCount);
    }


    @GetMapping("/logs/bie")
    @ApiOperation("日志Echarts柱状图数据")
    public Result getLogBie() {
//        List<EchartsLine> logList = sysLogService.getLogBie();
        List<SysLog> logList = sysLogService.getLogBieData();
        List<Map<String, Object>> mapList = new ArrayList<>();
        for (SysLog log : logList) {
            Map<String, Object> map = new HashMap<>();
            map.put("date", log.getDate());
            map.put("value", log.getValue());
            mapList.add(map);
        }
        return Result.success(mapList);
    }


    @GetMapping("/user/gender/bie")
    @ApiOperation("用户性别的饼状图")
    public Result getGenderBie() {
        List<EchartsBie> list = sysUserService.getGenderBie();
        return Result.success(list);
    }

    @GetMapping("/house/status/bie")
    @ApiOperation("出租与未出租饼状图")
    public Result getHouseStatusBie() {
        List<EchartsBie> list = sysHouseService.getHouseStatusBie();
        return Result.success(list);
    }


}
