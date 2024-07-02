package com.www.mapper;

import com.www.pojo.ChatGroup;
import com.www.pojo.SysMessage;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
* @author Alin
* @description 针对表【sys_message】的数据库操作Mapper
* @createDate 2024-05-04 11:38:18
* @Entity com.wfzm.pojo.SysMessage
*/
@Mapper
public interface SysMessageMapper extends BaseMapper<SysMessage> {

    List<SysMessage> getMessageList(Long id);

    @Select("SELECT COUNT(*) FROM sys_message WHERE receiver_id = #{id} AND status = 0;")
    int getUnreadNum(Integer id);

    List<Map<String, Object>> getMessageGroup(Integer id);

    List<ChatGroup> getMessageGroup1(Integer id);

    List<SysMessage> getMessageDetail(Integer chatId1, Integer chatId2);

    @Update("UPDATE sys_message SET status = 1 WHERE id = #{id}")
    void readMessage(Long id);

}




