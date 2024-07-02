package com.www.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

/**
 * 用户表
 * @TableName sys_user
 */
@TableName(value ="sys_user")
@Data
public class SysUser implements Serializable {
    // 用户表主键ID
    @TableId(type = IdType.AUTO)
    private Long id;

    // 用户名
    @NotBlank(message = "用户名不能为空")
    @Length(min = 1, max = 30, message = "用户名只能在5~30位之间")
    private String username;

    // 密码
//    @JsonIgnore
    private String password;

    // 用户头像
    private String avatar;

    // 邮箱
    @Pattern(regexp = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", message = "邮箱格式不正确")
    private String email;

    //手机号
//    @NotBlank(message = "手机号不能为空")
    @Pattern(regexp = "^[1][345789]\\d{9}$", message = "手机号格式不正确")
    private String phone;

    @TableField(value = "city_codeOne")
    private String cityCodeOne;
    @TableField(value = "city_codeTwo")
    private String cityCodeTwo;
    @TableField(value = "city_codeThree")
    private String cityCodeThree;
    private String city;

    // 创建时间
    private Date created;

    // 更新时间
    private Date updated;

    // 最近登录时间
    private Date lastLogin;

    // 状态  1：正常   0：禁用
    private Integer statu;
    // 状态  1：男   0：女
    private Integer age;
    private Integer gender;
    private String idCard;
    private String introduction;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @TableField(exist = false)
    private List<SysRole> sysRoles = new ArrayList<>();
    @TableField(exist = false)
    private SysRole role;
}