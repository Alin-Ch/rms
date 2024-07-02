package com.www.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @TableName sys_log
 */
@TableName(value ="sys_log")
@Data
public class SysLog implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 操作名称
     */
    @TableField(value = "operate_name")
    private String operateName;

    /**
     * 日志
     */
    @TableField(value = "name")
    private String name;

    @TableField(value = "create_time")
    private Date createTime;

    @TableField(value = "update_time")
    private Date updateTime;

    /**
     * 用户名称
     */
    @TableField(value = "username")
    private String username;

    /**
     * 登录的ip地址
     */
    @TableField(value = "ip")
    private String ip;

    /**
     * 请求接口
     */
    @TableField(value = "uri")
    private String uri;

    /**
     * 请求方式
     */
    @TableField(value = "method")
    private String method;

    /**
     * 描述
     */
    @TableField(value = "method_description")
    private String methodDescription;

    /**
     * 参数
     */
    @TableField(value = "params")
    private String params;

    /**
     * 浏览器类型
     */
    @TableField(value = "browser")
    private String browser;

    @TableField(value = "user_id")
    private Long userId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @TableField(exist = false)
    private String date;
    @TableField(exist = false)
    private Integer value;

}