package com.www.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.SysComment;
import com.www.service.SysCommentService;
import com.www.service.SysHouseService;
import com.www.service.SysUserService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * @Author Alin
 * @date 2024/5/12 012 14:01
 * @Description:
 */
@RestController
@Api(tags = "评论管理")
@RequestMapping("/sys/comment")
public class SysCommentController {
    private final SysCommentService sysCommentService;
    private final SysHouseService sysHouseService;
    private final SysUserService sysUserService;
    private final MyPage myPage;

    public SysCommentController(SysCommentService sysCommentService, SysHouseService sysHouseService, SysUserService sysUserService, MyPage myPage) {
        this.sysCommentService = sysCommentService;
        this.sysHouseService = sysHouseService;
        this.sysUserService = sysUserService;
        this.myPage = myPage;
    }

    @GetMapping("/list")
    @ApiOperation("分页查询评论列表")
    public Result list(Long houseId) {
        // 分页查询、模糊查询
        Page<SysComment> page = myPage.getPage();
        Page<SysComment> pageData = null;
        pageData = sysCommentService.getByHouseId(page, houseId);
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysComment sysComment) {
        sysComment.setCreateTime(new Date());
        sysCommentService.save(sysComment);

        return Result.success(sysComment);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysComment sysComment) {
        sysComment.setUpdateTime(new Date());
        sysCommentService.updateById(sysComment);

        return Result.success("修改成功！");
    }

    @PostMapping("/delete/{id}")
    @ApiOperation("删除")
    @Transactional
    public Result info(@PathVariable("id") Integer id) {
        sysCommentService.removeById(id);
        return Result.success("删除成功");
    }


}
