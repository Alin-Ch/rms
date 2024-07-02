package com.www.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.ChatGroup;
import com.www.pojo.SysMessage;
import com.www.pojo.SysUser;
import com.www.service.SysMessageService;
import com.www.service.SysUserService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.*;

/**
 * @Author Alin
 * @date 2024/5/4 004 11:38
 * @Description:
 */
@RestController
@RequestMapping("/sys/message")
@Api(tags = "发送消息相关")
public class SysMessageController {
    private final SysMessageService sysMessageService;
    private final SysUserService sysUserService;
    private final MyPage myPage;

    public SysMessageController(SysMessageService sysMessageService, SysUserService sysUserService, MyPage myPage) {
        this.sysMessageService = sysMessageService;
        this.sysUserService = sysUserService;
        this.myPage = myPage;
    }

    @GetMapping("/list")
    @ApiOperation("根据登录用户获取消息")
    public Result message(Principal principal) {
        // 从安全上下文获取主体，并根据当前登录用户查询用户实体
        SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));

        List<SysMessage> messageList = sysMessageService.getMessageList(user.getId());

        return Result.success(messageList);
    }

    @GetMapping("/unread/count/{id}")
    @ApiOperation("获取未读消息的数量")
    public Result getUnreadNum(@PathVariable("id") Integer id) {
        int unreadNum = sysMessageService.getUnreadNum(id);
        return Result.success(unreadNum);
    }

    @GetMapping("/group/{id}")
    @ApiOperation("获取左侧聊天栏 跟谁聊天")
    public Result getMessageGroup(@PathVariable("id") Integer id) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        List<Map<String, Object>> chatGroups = sysMessageService.getMessageGroup(id);
        for (Map<String, Object> chatGroup : chatGroups) {
            Map<String, Object> map = new HashMap<>();
            Long chatId1 = ((Long) chatGroup.get("chat_id1"));
            Long chatId2 = ((Long) chatGroup.get("chat_id2"));
            SysUser user1 = sysUserService.getById(chatId1);
            SysUser user2 = sysUserService.getById(chatId2);
            map.put("chatId1", chatId1);
            map.put("chatId2", chatId2);
            map.put("messageCount", chatGroup.get("message_count"));
            map.put("unreadCount", chatGroup.get("unread_count"));
            map.put("latest_create_time", chatGroup.get("latest_create_time"));
            map.put("latest_message_content", chatGroup.get("latest_message_content"));
            map.put("sender", user1);
            map.put("receiver", user2);
            resultList.add(map);
        }
        return Result.success(resultList);
    }


    @PostMapping("/detail")
    @ApiOperation("点击左侧的，显示聊天记录")
    public Result getMessageDetail(@RequestBody ChatGroup chatGroup) {
        // 因为get请求不能携带requestBody，所以改为Post请求
        if (chatGroup.getChatId1() == null || chatGroup.getChatId2() == null) {
            return Result.fail("缺少chatGroup实体，未完整传入！");
        }
        List<SysMessage> list = sysMessageService.getMessageDetail(chatGroup.getChatId1(), chatGroup.getChatId2());
        return Result.success(list);
    }

    @PostMapping("/read/{id}")
    @ApiOperation("根据id将消息的状态改为已读")
    public Result readMessage(@PathVariable("id") Long id) {
        if (id == null) {
            return Result.fail("缺少消息的id");
        }
        sysMessageService.readMessage(id);
        return Result.success("消息已设置为已读");
    }

    @GetMapping("/list/findBySearch")
    @ApiOperation("分页查询")
    public Result list() {
        // 分页查询、模糊查询
        Page<SysMessage> pageData = sysMessageService.page(myPage.getPage(),
                new QueryWrapper<SysMessage>());
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @ApiOperation("新增")
    public Result save(@RequestBody SysMessage sysMessage) {
        sysMessage.setCreateTime(new Date());
        sysMessageService.save(sysMessage);
        return Result.success(sysMessage);
    }

    @PostMapping("/send")
    @ApiOperation("给某人发信息")
    public Result sendMessage(@RequestBody SysMessage sysMessage, Principal principal) {
        if (sysMessage.getContent() == null || sysMessage.getContent().trim().isEmpty()) {
            return Result.fail("不能发送空消息或空格");
        }
        if (sysMessage.getSenderId() == null) {
            return Result.fail("没有发送者");
        }
        if (sysMessage.getReceiverId() == null) {
            return Result.fail("没有接收者");
        }
        sysMessage.setCreateTime(new Date());
        sysMessageService.save(sysMessage);
        if (sysMessage.getTitle() != null) {
            // 如果有title，可以发送邮件提醒
            SysUser user = sysUserService.getById(sysMessage.getReceiverId());
        }
        return Result.success(sysMessage);
    }


    @PostMapping("/update")
    @ApiOperation("修改")
    public Result update(@RequestBody SysMessage sysMessage) {
        sysMessage.setUpdateTime(new Date());
        sysMessageService.updateById(sysMessage);

        return Result.success("修改成功！");
    }

    @PostMapping("/delete/{id}")
    @ApiOperation("删除")
    @Transactional
    public Result info(@PathVariable("id") Integer id) {
        sysMessageService.removeById(id);
        return Result.success("删除成功");
    }

}
