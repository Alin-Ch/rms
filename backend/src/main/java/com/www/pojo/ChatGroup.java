package com.www.pojo;

import lombok.Data;

/**
 * @Author Alin
 * @date 2024/5/6 006 13:19
 * @Description:
 */
@Data
public class ChatGroup {
    private Integer chatId1;
    private Integer chatId2;
    private Integer messageCount;
    private Integer unreadCount;

    private SysUser sender;
    private SysUser receiver;
    // 如果需要与数据库字段名映射，可以在MyBatis的映射文件中使用result属性来指定
    // 或者使用@Result注解在Mapper接口的方法上指定字段映射
}
