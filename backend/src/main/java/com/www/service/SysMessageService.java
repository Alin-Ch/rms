package com.www.service;

import com.www.pojo.ChatGroup;
import com.www.pojo.SysMessage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
* @author Alin
* @description 针对表【sys_message】的数据库操作Service
* @createDate 2024-05-04 11:38:18
*/
public interface SysMessageService extends IService<SysMessage> {

    List<SysMessage> getMessageList(Long id);

    int getUnreadNum(Integer id);

    List<ChatGroup> getMessageGroup1(Integer id);

    List<Map<String, Object>> getMessageGroup(Integer id);

    List<SysMessage> getMessageDetail(Integer chatId1, Integer chatId2);

    void readMessage(Long id);

}
