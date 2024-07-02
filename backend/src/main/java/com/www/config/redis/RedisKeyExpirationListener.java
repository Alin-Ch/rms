package com.www.config.redis;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.www.mapper.SysOrderMapper;
import com.www.pojo.SysOrder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.listener.KeyExpirationEventMessageListener;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Component;

/**
 * @Author Alin
 * @date 2024/5/22 022 14:46
 * @Description:
 */

@Slf4j
@Component
public class RedisKeyExpirationListener extends KeyExpirationEventMessageListener {

    public RedisKeyExpirationListener(RedisMessageListenerContainer listenerContainer) {
        super(listenerContainer);
    }

    @Autowired
    private SysOrderMapper sysOrderMapper;

    /**
     * 针对redis数据失效事件，进行数据处理
     * @param message
     * @param pattern
     */
    @Override
    public void onMessage(Message message, byte[] pattern) {
        try {
            String key = message.toString();
            //从失效key中筛选代表订单失效的key
            if (key != null && key.startsWith("order_")) {
                //截取订单号，查询订单，如果是未支付状态则为-取消订单
                String orderNo = key.substring(6);

                QueryWrapper<SysOrder> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("order_no",orderNo);
                SysOrder orderInfo = sysOrderMapper.selectOne(queryWrapper);

                if (orderInfo != null) {
                    if (orderInfo.getStatus() == 0) {   //待支付
                        orderInfo.setStatus(4);         //已取消
                        sysOrderMapper.updateById(orderInfo);
                        log.info("订单号为【" + orderNo + "】超时未支付-自动修改为已取消状态");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.error("【修改支付订单过期状态异常】：" + e.getMessage());
        }
    }
}

