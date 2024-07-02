package com.www.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.SysLog;
import com.www.pojo.SysUser;
import com.www.service.SysLogService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @Author Alin
 * @date 2024/5/12 012 11:20
 * @Description:
 */
@RestController
@Api(tags = "日志管理")
@RequestMapping("/sys/logs")
public class SysLogController {
    private final SysLogService sysLogService;
    private final MyPage myPage;

    public SysLogController(SysLogService sysLogService,
                            MyPage myPage) {
        this.sysLogService = sysLogService;
        this.myPage = myPage;
    }

    @GetMapping("/list")
    public Result LogList(String username, String operateName) {
        // 分页查询、模糊查询
        Page<SysUser> pageData = sysLogService.page(myPage.getPage(),
                new QueryWrapper<SysLog>().like(StrUtil.isNotBlank(username), "username", username)
                        .like(StrUtil.isNotBlank(operateName), "operate_name", operateName)
                        .orderByDesc("create_time"));
        return Result.success(pageData);
    }

    /**
     * 日志删除
     */
    @PostMapping("/delete")
    public Result delete(@RequestBody Long[] ids) {
        sysLogService.removeByIds(Arrays.asList(ids));
        sysLogService.remove(new QueryWrapper<SysLog>().in("id", ids));
        return Result.success("删除成功");
    }



}
