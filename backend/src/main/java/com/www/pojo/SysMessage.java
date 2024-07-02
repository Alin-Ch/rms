package com.www.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

/**
 * @TableName sys_message
 */
@TableName(value = "sys_message")
@Data
public class SysMessage implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @TableField(value = "title")
    private String title;

    @TableField(value = "content")
    private String content;

    @TableField(value = "create_time")
    private Date createTime;

    @TableField(value = "update_time")
    private Date updateTime;

    @TableField(value = "status")
    private Integer status;

    /**
     * 发送者id
     */
    @TableField(value = "sender_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long senderId;

    /**
     * 接收者id
     */
    @TableField(value = "receiver_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long receiverId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @TableField(exist = false)
    private Integer message_count;

}