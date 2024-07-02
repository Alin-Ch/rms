package com.www.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;
import org.springframework.data.annotation.Transient;

/**
 * @TableName sys_order
 */
@TableName(value = "sys_order")
@Data
public class SysOrder implements Serializable {

    @TableId(value = "id")
    @JsonSerialize(using = ToStringSerializer.class) //雪花算法会丢失精度，故使其变成json字符串
    private Long id;

    @TableField(value = "order_no")
    @JsonSerialize(using = ToStringSerializer.class) //雪花算法会丢失精度，故使其变成json字符串
    private Long orderNo;

    /**
     * 阿里支付的支付号码
     */
    @TableField(value = "alipay_no")
    private String alipayNo;

    @TableField(value = "create_time")
    private Date createTime;
    @TableField(value = "update_time")
    private Date updateTime;
    @TableField(value = "payment_time")
    private Date paymentTime;

    /**
     * 0：未支付   1：已支付
     */
    @TableField(value = "status")
    private Integer status;

    /**
     * 订单金额
     */
    @TableField(value = "money")
    private BigDecimal money;

    /**
     * 支付方式
     */
    @TableField(value = "pay_type")
    private String payType;


    @TableField(value = "house_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long houseId;

    @TableField(value = "owner_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long ownerId;

    @TableField(value = "user_id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long userId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Transient
    @TableField(exist = false)
    private SysHouse house;
    @TableField(exist = false)
    private SysUser owner;
    @TableField(exist = false)
    private SysUser user;

}