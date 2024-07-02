package com.www.utils;

import java.util.concurrent.atomic.AtomicLong;

public class SnowflakeIdGenerator {
    private static final long START_TIMESTAMP = 1577808000000L; // 起始时间戳，2020-01-01 00:00:00

    private static final long WORKER_ID_BITS = 5L; // 工作节点 ID 的位数
    private static final long DATACENTER_ID_BITS = 5L; // 数据中心 ID 的位数
    private static final long SEQUENCE_BITS = 12L; // 序列号的位数

    private static final long MAX_WORKER_ID = ~(-1L << WORKER_ID_BITS); // 最大工作节点 ID
    private static final long MAX_DATACENTER_ID = ~(-1L << DATACENTER_ID_BITS); // 最大数据中心 ID

    private static final long WORKER_ID_SHIFT = SEQUENCE_BITS; // 工作节点 ID 向左偏移位数
    private static final long DATACENTER_ID_SHIFT = SEQUENCE_BITS + WORKER_ID_BITS; // 数据中心 ID 向左偏移位数
    private static final long TIMESTAMP_LEFT_SHIFT = SEQUENCE_BITS + WORKER_ID_BITS + DATACENTER_ID_BITS; // 时间戳向左偏移位数
    private static final long SEQUENCE_MASK = ~(-1L << SEQUENCE_BITS); // 序列号的掩码

    private final long workerId; // 工作节点 ID
    private final long datacenterId; // 数据中心 ID
    private final AtomicLong sequence = new AtomicLong(0L); // 序列号计数器
    private volatile long lastTimestamp = -1L; // 上次生成 ID 的时间戳

    public SnowflakeIdGenerator(long workerId, long datacenterId) {
        if (workerId > MAX_WORKER_ID || workerId < 0) {
            throw new IllegalArgumentException("工作节点 ID 不能大于 " + MAX_WORKER_ID + " 或小于 0");
        }
        if (datacenterId > MAX_DATACENTER_ID || datacenterId < 0) {
            throw new IllegalArgumentException("数据中心 ID 不能大于 " + MAX_DATACENTER_ID + " 或小于 0");
        }
        this.workerId = workerId;
        this.datacenterId = datacenterId;
    }

    public synchronized long nextId() {
        long timestamp = System.currentTimeMillis();
        if (timestamp < lastTimestamp) {
            throw new RuntimeException("时钟回拨，拒绝生成 " + (lastTimestamp - timestamp) + " 毫秒内的 ID");
        }

        if (timestamp == lastTimestamp) {
            long sequenceValue = sequence.incrementAndGet() & SEQUENCE_MASK;
            if (sequenceValue == 0) {
                timestamp = tilNextMillis(lastTimestamp);
            }
        } else {
            sequence.set(0L);
        }

        lastTimestamp = timestamp;

        return ((timestamp - START_TIMESTAMP) << TIMESTAMP_LEFT_SHIFT) |
                (datacenterId << DATACENTER_ID_SHIFT) |
                (workerId << WORKER_ID_SHIFT) |
                sequence.get();
    }

    private long tilNextMillis(long lastTimestamp) {
        long timestamp = System.currentTimeMillis();
        while (timestamp <= lastTimestamp) {
            timestamp = System.currentTimeMillis();
        }
        return timestamp;
    }

    public static void main(String[] args) {
        SnowflakeIdGenerator idGenerator = new SnowflakeIdGenerator(1, 1);

        // 生成10个订单号示例
        for (int i = 0; i < 1000; i++) {
            long orderId = idGenerator.nextId();
            System.out.println("订单号" + i + ": " + orderId);
        }
    }
}
