package com.www.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.SysNotice;
import com.www.service.SysNoticeService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * @Author Alin
 * @date 2024/5/3 003 22:19
 * @Description:
 */
@RestController
@RequestMapping("/sys/notice")
@Api(tags = "公告管理")
public class SysNoticeController {
    private final SysNoticeService sysNoticeService;
    private final MyPage myPage;

    public SysNoticeController(SysNoticeService sysNoticeService, MyPage myPage) {
        this.sysNoticeService = sysNoticeService;
        this.myPage = myPage;
    }

    @GetMapping("/limit")
    @ApiOperation("getNotice")
    public Result getNotice() {
        List<SysNotice> list = sysNoticeService.getNotice();
        return Result.success(list);
    }
    @GetMapping("/detail/{id}")
    @ApiOperation("公告详情 根据id查")
    public Result getNoticeById(@PathVariable("id") Integer id) {
        SysNotice sysNotice = sysNoticeService.getById(id);
        return Result.success(sysNotice);
    }

    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list() {
        // 分页查询、模糊查询
        Page<SysNotice> page = myPage.getPage();
        IPage<SysNotice> pageData = sysNoticeService.getPageData(page);
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysNotice sysNotice) {
        sysNotice.setCreateTime(new Date());
        sysNoticeService.save(sysNotice);

        return Result.success(sysNotice);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysNotice sysNotice) {
        sysNotice.setUpdateTime(new Date());
        sysNoticeService.updateById(sysNotice);

        return Result.success("修改成功！");
    }

    @PostMapping("/delete/{id}")
    @ApiOperation("删除")
    @Transactional
    public Result info(@PathVariable("id") Integer id) {
        sysNoticeService.removeById(id);
        return Result.success("删除成功");
    }

}
