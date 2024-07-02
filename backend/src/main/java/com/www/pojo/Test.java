package com.www.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @TableName test
 */
@TableName(value ="test")
@Data
public class Test implements Serializable {
    /**
     * id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 
     */
    @TableField(value = "order_no")
    private Long orderNo;

    /**
     * 阿里支付的支付号码
     */
    @TableField(value = "alipay_no")
    private String alipayNo;

    /**
     * 
     */
    @TableField(value = "create_time")
    private Date createTime;

    /**
     * 
     */
    @TableField(value = "update_time")
    private Date updateTime;

    /**
     * 支付时间
     */
    @TableField(value = "payment_time")
    private Date paymentTime;

    /**
     * 0：未支付   1：已支付   2：已退款
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

    /**
     * 房屋的id
     */
    @TableField(value = "house_id")
    private Long houseId;

    /**
     * 房东id
     */
    @TableField(value = "owner_id")
    private Long ownerId;

    /**
     * 租户id
     */
    @TableField(value = "user_id")
    private Long userId;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}