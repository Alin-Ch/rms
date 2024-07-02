package com.www.controller;

import com.www.pojo.SysHouseType;
import com.www.service.SysFavorService;
import com.www.service.SysHistoryService;
import com.www.service.SysHouseService;
import com.www.service.SysHouseTypeService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @Author Alin
 * @date 2024/5/14 014 16:01
 * @Description:
 */
@RestController
@RequestMapping("/sys/house/type")
@Api(tags = "房屋类型管理")
public class SysHouseTypeController {
    private final SysHouseTypeService sysHouseTypeService;
    private final SysHouseService sysHouseService;
    private final SysHistoryService sysHistoryService;
    private final SysFavorService sysFavorService;

    public SysHouseTypeController(SysHouseTypeService sysHouseTypeService, SysHouseService sysHouseService, SysHistoryService sysHistoryService, SysFavorService sysFavorService) {
        this.sysHouseTypeService = sysHouseTypeService;
        this.sysHouseService = sysHouseService;
        this.sysHistoryService = sysHistoryService;
        this.sysFavorService = sysFavorService;
    }
    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list() {
        List<SysHouseType> list = sysHouseTypeService.list();
        return Result.success(list);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysHouseType sysHouseType) {
        sysHouseType.setCreateTime(new Date());
        sysHouseTypeService.save(sysHouseType);
        return Result.success(sysHouseType);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysHouseType sysHouseType) {
        sysHouseType.setUpdateTime(new Date());
        sysHouseTypeService.updateById(sysHouseType);
        return Result.success("修改成功！");
    }

    @PostMapping("/delete")
    @ApiOperation("删除")
    @Transactional
    public Result info(@RequestBody Long[] ids) {
        sysHouseTypeService.removeByIds(Arrays.asList(ids));
        // 删除中间表  这点代码不是这样写的，要根据每一个商品的id去favor、history表中删的
//        sysFavorService.remove(new QueryWrapper<SysFavor>().in("house_id", ids));
//        sysHistoryService.remove(new QueryWrapper<SysHistory>().in("house_id", ids));
        return Result.success("删除成功");
    }
}
