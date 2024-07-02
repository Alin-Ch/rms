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
 * @TableName sys_apply
 */
@TableName(value ="sys_apply")
@Data
public class SysApply implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField(value = "title")
    private String title;

    @TableField(value = "content")
    private String content;

    @TableField(value = "url")
    private String url;

    @TableField(value = "create_time")
    private Date createTime;

    @TableField(value = "update_time")
    private Date updateTime;

    /**
     * 0待审核     1审核通过      2审核不通过
     */
    @TableField(value = "status")
    private Integer status;

    /**
     * 申请人id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 审核人id
     */
    @TableField(value = "admin_id")
    private Integer adminId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @TableField(exist = false)
    private SysUser user;
    @TableField(exist = false)
    private SysUser admin;  // 处理人的id
}