package com.www.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

/**
 * @TableName sys_house
 */
@TableName(value = "sys_house")
@Data
public class SysHouse implements Serializable {
    /**
     * 主键id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 名称
     */
    @TableField(value = "name")
    private String name;

    /**
     * 描述
     */
    @TableField(value = "description")
    private String description;

    @TableField(value = "detail")
    private String detail;

    @TableField(value = "area")
    private String area;

    @TableField(value = "city_codeOne")
    private String cityCodeOne;
    @TableField(value = "city_codeTwo")
    private String cityCodeTwo;
    @TableField(value = "city_codeThree")
    private String cityCodeThree;
    @TableField(value = "city")
    private String city;

    @TableField(value = "location")
    private String location;

    @TableField(value = "address")
    private String address;

    @TableField(value = "jingdu")
    private String jingdu;
    @TableField(value = "weidu")
    private String weidu;

    /**
     * 月租金
     */
    @TableField(value = "price")
    private BigDecimal price;

    @TableField(value = "favor")
    private Integer favor;

    @TableField(value = "create_time")
    private Date createTime;

    @TableField(value = "update_time")
    private Date updateTime;

    /**
     * 0：禁用   1：正常
     */
    @TableField(value = "status")
    private Integer status;

    @TableField(value = "type_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long typeId;

    @TableField(value = "owner_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long ownerId;

    @TableField(value = "user_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long userId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @TableField(exist = false)
    private String typeName;

    @TableField(exist = false)
    private SysUser owner;
    @TableField(exist = false)
    private SysUser user;
    @TableField(exist = false)
    private List<SysHouseShow> list;
    @TableField(exist = false)
    private List<SysHouseShowVideo> videoList;

    // 图片
    @TableField(exist = false)
    private List<SysHouseShow> delList;
    @TableField(exist = false)
    private List<SysHouseShow> addList;

    // 视频
    @TableField(exist = false)
    private List<SysHouseShowVideo> vdelList;
    @TableField(exist = false)
    private List<SysHouseShowVideo> vaddList;
}