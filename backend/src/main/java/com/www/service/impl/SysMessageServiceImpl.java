package com.www.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.ChatGroup;
import com.www.pojo.SysMessage;
import com.www.service.SysMessageService;
import com.www.mapper.SysMessageMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
* @author Alin
* @description 针对表【sys_message】的数据库操作Service实现
* @createDate 2024-05-04 11:38:18
*/
@Service
public class SysMessageServiceImpl extends ServiceImpl<SysMessageMapper, SysMessage>
    implements SysMessageService{

    private final SysMessageMapper sysMessageMapper;

    public SysMessageServiceImpl(SysMessageMapper sysMessageMapper) {
        this.sysMessageMapper = sysMessageMapper;
    }


    @Override
    public List<SysMessage> getMessageList(Long id) {
        List<SysMessage> messageList = sysMessageMapper.getMessageList(id);
        return messageList;
    }

    @Override
    public int getUnreadNum(Integer id) {
        int unreadNumber = sysMessageMapper.getUnreadNum(id);
        return unreadNumber;
    }

    @Override
    public List<Map<String, Object>> getMessageGroup(Integer id) {
        List<Map<String, Object>> list = sysMessageMapper.getMessageGroup(id);
        return list;
    }

    @Override
    public List<ChatGroup> getMessageGroup1(Integer id) {
        List<ChatGroup> list = sysMessageMapper.getMessageGroup1(id);
        return list;
    }


    @Override
    public List<SysMessage> getMessageDetail(Integer chatId1, Integer chatId2) {
        List<SysMessage> list = sysMessageMapper.getMessageDetail(chatId1, chatId2);
        return list;
    }

    @Override
    public void readMessage(Long id) {
        sysMessageMapper.readMessage(id);
    }
}




