package com.www.utils;

import java.util.Map;

/**
 * @Author Alin
 * @date 2024/5/11 011 12:48
 * @Description:
 */
public class SimilarityCalculator {
    /**
     * 计算两个用户之间的皮尔逊相关系数
     *
     * @param user1 当前登录用户（或目标用户）
     * @param user2 其他用户
     * @return 皮尔逊相似度
     */
    public static double pearsonCorrelation(Map<Long, Double> user1, Map<Long, Double> user2) {
        // sumXY :  存储了当前登录用户（或目标用户）和用户2对同一电影的评分乘积之和
        // sumX  :  存储了当前登录用户（或目标用户）的评分总和，sumY 存储了用户2的评分总和
        // sumX2 :  存储了当前登录用户（或目标用户）评分的平方和，sumY2 存储了用户2评分的平方和
        // n     :  记录了共同评价的电影数量。
        double sumXY = 0, sumX = 0, sumY = 0, sumX2 = 0, sumY2 = 0;
        int n = 0;

        // 遍历当前登录用户（或目标用户）的评分映射中的每个键（商品ID），并检查用户2的评分映射中是否也包含该键，以确保两个用户都对同一部电影进行了评分。
        for (Long pid : user1.keySet()) {
            if (user2.containsKey(pid)) {
                // 获取了当前登录用户（或目标用户）和用户2对当前电影的评分。
                double rating1 = user1.get(pid);
                double rating2 = user2.get(pid);
                // 更新了中间结果变量，计算了评分乘积之和、各自评分的总和以及各自评分的平方和，并增加了共同评价的物品数量。
                sumXY += rating1 * rating2;
                sumX += rating1;        // 用户1的评分总和
                sumY += rating2;        // 用户2的评分总和
                sumX2 += Math.pow(rating1, 2);
                sumY2 += Math.pow(rating2, 2);
                n++;
            }
        }
        // 检查是否存在共同评价的电影，如果不存在，则返回0，表示两个用户之间没有相关性。
        if (n == 0) {
            return 0;
        }
        // 计算了皮尔逊相关系数的分母部分，即两个用户评分的标准差的乘积。
        double denominator = Math.sqrt(sumX2 - Math.pow(sumX, 2) / n) * Math.sqrt(sumY2 - Math.pow(sumY, 2) / n);
        // 检查分母是否为0，如果为0，则返回0，以避免除以0错误。
        if (denominator == 0) {
            return 0;
        }
        // 计算了最终的皮尔逊相关系数，并返回结果。
        return (sumXY - sumX * sumY / n) / denominator;
    }

    /**
     * 计算余弦相似度
     *
     * @param item1 用户当前购买的商品
     * @param item2 其他商品
     * @return
     */
    public static double cosineSimilarityCorrelation(Map<Long, Double> item1, Map<Long, Double> item2) {
        double sumXY = 0, sumX = 0, sumY = 0;
        int n = 0;

        for (Long uid : item1.keySet()) {
            if (item2.containsKey(uid)) {
                double rating1 = item1.get(uid);
                double rating2 = item2.get(uid);
                sumXY += rating1 * rating2;
                sumX += Math.pow(rating1, 2);
                sumY += Math.pow(rating2, 2);
                n++;
            }
        }

        if (n == 0) {
            return 0;
        }

        double denominator = Math.sqrt(sumX) * Math.sqrt(sumY);
        if (denominator == 0) {
            return 0;
        }
        return sumXY / denominator;
    }

    /**
     *
     * @param currentItem 当前物品 / 目标物品
     * @param otherItem 其它物品
     * @return
     */
    public static double userPearsonCorrelation(Map<Long, Double> currentItem, Map<Long, Double> otherItem) {
        double sumXY = 0, sumX = 0, sumY = 0, sumX2 = 0, sumY2 = 0;
        int n = 0;

        for (Long pid : currentItem.keySet()) {
            if (otherItem.containsKey(pid)) {
                //
                double rating1 = currentItem.get(pid);
                double rating2 = otherItem.get(pid);
                // 更新了中间结果变量，计算了评分乘积之和、各自评分的总和以及各自评分的平方和
                sumXY += rating1 * rating2;
                sumX += rating1;        // currentItem的评分总和
                sumY += rating2;        // otherItem的评分总和
                sumX2 += Math.pow(rating1, 2);
                sumY2 += Math.pow(rating2, 2);
                n++;
            }
        }
        // 检查是否存在共同的，如果不存在，则返回0，表示二者之间没有相关性。
        if (n == 0) {
            return 0;
        }
        // 计算了皮尔逊相关系数的分母部分，即两个用户评分的标准差的乘积。
        double denominator = Math.sqrt(sumX2 - Math.pow(sumX, 2) / n) * Math.sqrt(sumY2 - Math.pow(sumY, 2) / n);
        // 检查分母是否为0，如果为0，则返回0，以避免除以0错误。
        if (denominator == 0) {
            return 0;
        }
        // 计算了最终的皮尔逊相关系数，并返回结果。
        return (sumXY - sumX * sumY / n) / denominator;
    }
}

