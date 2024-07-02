package com.www.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.*;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Arrays;
import java.util.Date;
import java.util.Objects;

/**
 * @Author Alin
 * @date 2024/5/28 028 13:17
 * @Description:
 */
@RestController
@RequestMapping("/sys/apply")
@Api(tags = "商家入驻管理")
public class SysApplyController {
    private final SysApplyService sysApplyService;
    private final SysRoleService sysRoleService;
    private final SysUserRoleService sysUserRoleService;
    private final SysUserService sysUserService;
    private final MyPage myPage;

    public SysApplyController(SysApplyService sysApplyService, SysRoleService sysRoleService, SysUserRoleService sysUserRoleService, SysUserService sysUserService, MyPage myPage) {
        this.sysApplyService = sysApplyService;
        this.sysRoleService = sysRoleService;
        this.sysUserRoleService = sysUserRoleService;
        this.sysUserService = sysUserService;
        this.myPage = myPage;
    }


    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list(String houseName, Principal principal) {
        // 分页查询、模糊查询
        Page<SysApply> pageData = sysApplyService.page(myPage.getPage(),
                new QueryWrapper<SysApply>().orderByDesc("create_time"));
        for (SysApply item : pageData.getRecords()) {
            SysUser sysUser = sysUserService.getById(item.getUserId());
            item.setUser(sysUser);
        }
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysApply sysApply, Principal principal) {
        if (sysApply == null || sysApply.getUserId() == null || Objects.equals(sysApply.getContent(), "")) {
            return Result.fail("缺少参数");
        }
        sysApply.setCreateTime(new Date());
        sysApplyService.save(sysApply);
        return Result.success(sysApply);
    }

    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysApply sysApply) {
        sysApply.setUpdateTime(new Date());
        sysApplyService.updateById(sysApply);
        if (sysApply.getStatus() == 1) {
            SysUser sysUser = sysUserService.getById(sysApply.getUserId());
            SysUserRole sysUserRole = sysUserRoleService.getOne(new QueryWrapper<SysUserRole>()
                    .eq("user_id", sysUser.getId()));
            if (sysUserRole.getRoleId() == 1) {
                sysUserRole.setRoleId(3L);
                sysUserRoleService.updateById(sysUserRole);
            }
        } else if (sysApply.getStatus() == 2) {
            SysUser sysUser = sysUserService.getById(sysApply.getUserId());
            SysUserRole sysUserRole = sysUserRoleService.getOne(new QueryWrapper<SysUserRole>()
                    .eq("user_id", sysUser.getId()));
            if (sysUserRole.getRoleId() == 3) {
                sysUserRole.setRoleId(1L);
                sysUserRoleService.updateById(sysUserRole);
            }
        }
        return Result.success("修改成功！");
    }

    @PostMapping("/delete")
    @ApiOperation("批量删除")
    public Result info(@RequestBody Long[] ids) {
        sysApplyService.removeByIds(Arrays.asList(ids));
        return Result.success("删除成功");
    }

    @PostMapping("/delete/{id}")
    @ApiOperation("单个删除")
    public Result deleteOne(@PathVariable("id") Integer id) {
        sysApplyService.removeById(id);
        return Result.success("删除成功");
    }


}
