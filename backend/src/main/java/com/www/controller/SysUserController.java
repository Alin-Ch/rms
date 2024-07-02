package com.www.controller;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.aop.AutoLog;
import com.www.common.dto.PassDto;
import com.www.common.lang.Const;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.*;
import com.www.utils.AliOSSUtils;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/30/13:33
 * @Description: 管理端用户操作
 */
@RestController
@Api(tags = "用户管理")
@RequestMapping("/sys/user")
public class SysUserController {

    private final SysUserService sysUserService;
    private final SysRoleService sysRoleService;
    private final SysUserRoleService sysUserRoleService;
    private final SysOrderService sysOrderService;
    private final SysHistoryService sysHistoryService;
    private final SysFavorService sysFavorService;
    private final SysLogService sysLogService;
    private final SysCommentService sysCommentService;
    private final SysMessageService sysMessageService;
    private final PasswordEncoder passwordEncoder;
    private final AliOSSUtils aliOSSUtils;
    private final MyPage myPage;

    public SysUserController(SysUserService sysUserService,
                             SysRoleService sysRoleService,
                             SysUserRoleService sysUserRoleService,
                             SysOrderService sysOrderService, SysHistoryService sysHistoryService, SysFavorService sysFavorService, SysLogService sysLogService, SysCommentService sysCommentService, SysMessageService sysMessageService, PasswordEncoder passwordEncoder,
                             AliOSSUtils aliOSSUtils,
                             MyPage myPage) {
        this.sysUserService = sysUserService;
        this.sysRoleService = sysRoleService;
        this.sysUserRoleService = sysUserRoleService;
        this.sysOrderService = sysOrderService;
        this.sysHistoryService = sysHistoryService;
        this.sysFavorService = sysFavorService;
        this.sysLogService = sysLogService;
        this.sysCommentService = sysCommentService;
        this.sysMessageService = sysMessageService;
        this.passwordEncoder = passwordEncoder;
        this.aliOSSUtils = aliOSSUtils;
        this.myPage = myPage;
    }

    /**
     * 根据用户id查询单个用户信息
     *
     * @param id
     * @return
     */
    @GetMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id) {
        SysUser sysUser = sysUserService.getById(id);
        Assert.notNull(sysUser, "找不到该用户");

        List<SysRole> roles = sysRoleService.listRolesByUserId(id);
        sysUser.setSysRoles(roles);
        return Result.success(sysUser);
    }

    @GetMapping("/info/list")
    public Result allUser() {
        List<SysUser> userList = sysUserService.list();
        return Result.success(userList);
    }

    /**
     * 分页查询、模糊查询
     *
     * @param username
     * @return
     */
    @PreAuthorize("hasAuthority('sys:user:list')")
    @GetMapping("/list")
    public Result list(String username, String phone) {
        // 分页查询、模糊查询
        Page<SysUser> pageData = sysUserService.page(myPage.getPage(),
                new QueryWrapper<SysUser>().like(StrUtil.isNotBlank(username), "username", username)
                        .like(StrUtil.isNotBlank(phone), "phone", phone)
        ); //.orderByDesc("created")
        // 循环所查询到的记录，每条记录都查询到对应的角色的记录
        pageData.getRecords().forEach(u -> {
            u.setSysRoles(sysRoleService.listRolesByUserId(u.getId()));
        });
        return Result.success(pageData);
    }

    /**
     * 新增用户
     *
     * @param sysUser
     * @return
     */
    @PreAuthorize("hasAuthority('sys:user:save')")
    @PostMapping("/save")
    public Result save(@Validated @RequestBody SysUser sysUser) throws IOException {

        sysUser.setCreated(new Date());
        // 数据库状态默认为1，表示正常
        // 默认加密密码，123456
        if (sysUser.getPassword() == null) {
            String password = passwordEncoder.encode(Const.DEFAULT_PASSWORD);
            sysUser.setPassword(password);
        }
        // 设置默认头像
        if (sysUser.getAvatar() == null) {
            sysUser.setAvatar(Const.DEFAULT_AVATAR);
        }
        sysUserService.save(sysUser);

        // 添加用户时设置默认角色
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(sysUser.getId());
        sysUserRole.setRoleId(1L);
        sysUserRoleService.save(sysUserRole);
        return Result.success("操作成功");
    }

    /**
     * 更新用户
     *
     * @param sysUser
     * @return
     */
    @PreAuthorize("hasAuthority('sys:user:update')")
    @AutoLog("更新用户信息")
    @PostMapping("/update")
    public Result update(@Validated @RequestBody SysUser sysUser) {
        sysUser.setUpdated(new Date());
        sysUserService.updateById(sysUser);
        // 清除缓存
        sysUserService.clearUserAuthorityInfo(sysUser.getUsername());
        return Result.success(sysUser);
    }

    /**
     * 删除、批量删除
     *
     * @param ids
     * @return
     */
    @PreAuthorize("hasAuthority('sys:user:delete')")
    @AutoLog("删除用户")
    @Transactional
    @PostMapping("/delete")
    public Result delete(@RequestBody Long[] ids) {
        sysUserService.removeByIds(Arrays.asList(ids));
        // 删除中间表
        sysUserRoleService.remove(new QueryWrapper<SysUserRole>().in("user_id", ids));
        sysHistoryService.remove(new QueryWrapper<SysHistory>().in("user_id", ids));
        sysFavorService.remove(new QueryWrapper<SysFavor>().in("user_id", ids));
        sysLogService.remove(new QueryWrapper<SysLog>().in("user_id", ids));
        sysOrderService.remove(new QueryWrapper<SysOrder>().in("user_id", ids));
        sysCommentService.remove(new QueryWrapper<SysComment>().in("user_id", ids));
        return Result.success("删除成功");
    }

    /**
     * 分配角色
     *
     * @param userId
     * @param roleIds
     * @return
     */
    @PreAuthorize("hasAuthority('sys:user:role')")
    @Transactional
    @PostMapping("/role/{userId}")
    public Result rolePerm(@PathVariable("userId") Long userId, @RequestBody Long[] roleIds) {

        List<SysUserRole> userRoles = new ArrayList<>();

        Arrays.stream(roleIds).forEach(r -> {
            SysUserRole sysUserRole = new SysUserRole();
            sysUserRole.setRoleId(r);
            sysUserRole.setUserId(userId);
            userRoles.add(sysUserRole);
        });

        // 删除中间表数据
        sysUserRoleService.remove(new QueryWrapper<SysUserRole>().eq("user_id", userId));
        // 批量保存
        sysUserRoleService.saveBatch(userRoles);

        // 删除缓存
        SysUser sysUser = sysUserService.getById(userId);
        sysUserService.clearUserAuthorityInfo(sysUser.getUsername());

        return Result.success("操作成功");
    }

    /**
     * 重置密码
     *
     * @param userId
     * @return
     */
    @PreAuthorize("hasAuthority('sys:user:repass')")
    @PostMapping("/repass")
    public Result repass(@RequestBody Long userId) {

        SysUser sysUser = sysUserService.getById(userId);
        sysUser.setPassword(passwordEncoder.encode(Const.DEFAULT_PASSWORD));

        sysUserService.updateById(sysUser);
        return Result.success("重置成功");
    }

    /**
     * 当前用户更新密码
     *
     * @param passDto
     * @param principal
     * @return
     */
    @PostMapping("/updatePass")
    @AutoLog("修改密码")
    public Result updatePass(@Validated @RequestBody PassDto passDto, Principal principal) {

        // 查询当前用户
        SysUser sysUser = sysUserService.getByUsername(principal.getName());

        // 匹配旧密码是否正确
        boolean matches = passwordEncoder.matches(passDto.getCurrentPass(), sysUser.getPassword());
        if (!matches) {
            return Result.fail("旧密码不正确");
        }
        // 新密码进行加密
        sysUser.setPassword(passwordEncoder.encode(passDto.getPassword()));
        sysUser.setUpdated(new Date());

        sysUserService.updateById(sysUser);
        return Result.success("重置成功");
    }

    @PostMapping("/status/{userId}")
    public Result changeStatus(@PathVariable("userId") Long userId) {
        sysUserService.updateStatus(userId);
        return Result.success("操作成功");
    }


}
