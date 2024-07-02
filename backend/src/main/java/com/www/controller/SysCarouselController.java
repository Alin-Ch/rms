package com.www.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.SysCarouselService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * @Author Alin
 * @date 2024/5/3 003 20:25
 * @Description:
 */
@RestController
@RequestMapping("/sys/carousel")
@Api(tags = "轮播图管理")
public class SysCarouselController {
    private final SysCarouselService sysCarouselService;
    private final MyPage myPage;

    public SysCarouselController(SysCarouselService sysCarouselService, MyPage myPage) {
        this.sysCarouselService = sysCarouselService;
        this.myPage = myPage;
    }

    @GetMapping("/banner")
    @ApiOperation("用户端获取轮播图")
    public Result getBannerList() {
        List<SysCarousel> list = sysCarouselService.getBannerList();
        return Result.success(list);
    }

    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list() {
        // 分页查询、模糊查询
        Page<SysCarousel> pageData = sysCarouselService.page(myPage.getPage(),
                new QueryWrapper<SysCarousel>().orderByDesc("create_time"));
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysCarousel sysCarousel) {
        sysCarousel.setCreateTime(new Date());
        sysCarouselService.save(sysCarousel);

        return Result.success(sysCarousel);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysCarousel sysCarousel) {
        sysCarousel.setUpdateTime(new Date());
        sysCarouselService.updateById(sysCarousel);

        return Result.success("修改成功！");
    }

    @PostMapping("/delete/{id}")
    @ApiOperation("删除")
    @Transactional
    public Result info(@PathVariable("id") Integer id) {
        sysCarouselService.removeById(id);
        return Result.success("删除成功");
    }


}
