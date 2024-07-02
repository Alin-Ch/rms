package com.www.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.mapper.SysHouseMapper;
import com.www.mapper.SysUserMapper;
import com.www.pojo.*;
import com.www.service.SysHouseTypeService;
import com.www.service.SysUserService;
import com.www.service.UserHouseOperationService;
import com.www.mapper.UserHouseOperationMapper;
import com.www.utils.RandomProductUtils;
import com.www.utils.SimilarityCalculator;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @author Alin
 * @description 针对表【user_house_operation】的数据库操作Service实现
 * @createDate 2024-05-11 12:30:38
 */
@Service
public class UserHouseOperationServiceImpl extends ServiceImpl<UserHouseOperationMapper, UserHouseOperation>
        implements UserHouseOperationService {

    private final SysHouseTypeService sysHouseTypeService;  // 这里不建议引入service，这里堆一点屎
    private final SysHouseMapper sysHouseMapper;
    private final SysUserMapper sysUserMapper;
    private final SysUserService sysUserService;
    private final UserHouseOperationMapper userHouseOperationMapper;

    public UserHouseOperationServiceImpl(SysHouseTypeService sysHouseTypeService, SysHouseMapper sysHouseMapper,
                                         SysUserMapper sysUserMapper, SysUserService sysUserService, UserHouseOperationMapper userHouseOperationMapper) {
        this.sysHouseTypeService = sysHouseTypeService;
        this.sysHouseMapper = sysHouseMapper;
        this.sysUserMapper = sysUserMapper;
        this.sysUserService = sysUserService;
        this.userHouseOperationMapper = userHouseOperationMapper;
    }

    @Override
    public List<UserHouseOperation> getAllUserOperation() {
        return userHouseOperationMapper.getAllUserOperation();
    }

    @Override
    public List<UserHouseOperation> getAllHouseOperation() {
        return userHouseOperationMapper.getAllHouseOperation();
    }


    public List<SysHouse> randomRecommend(int howMany) {
        List<SysHouse> list = new ArrayList<>();
        // 分页数
        int limit = 20;
        // 总记录数
        long count = sysHouseMapper.selectCount(null);
        // 循环次数
        long cycles = count / limit + 1;
        // 开始线程
        ExecutorService executorService = Executors.newFixedThreadPool(Math.toIntExact(cycles));
        List<CompletableFuture<List<SysHouse>>> futures = new ArrayList<>();
        for (int i = 0; i < cycles; i++) {
            final int currentIndex = i;
            CompletableFuture<List<SysHouse>> future = CompletableFuture.supplyAsync(() -> {
                int startIdx = currentIndex * limit;
                int endIdx = (currentIndex + 1) * limit;
                if (endIdx > count) {
                    endIdx = Math.toIntExact(count);
                }
                return sysHouseMapper.getPageAllList(startIdx, endIdx);
            }, executorService);
            futures.add(future);
        }

        CompletableFuture<Void> allOf = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));

        try {
            allOf.get();
            futures.forEach(future -> {
                try {
                    list.addAll(future.get());
                } catch (InterruptedException | ExecutionException e) {
                    e.printStackTrace();
                }
            });
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        } finally {
            executorService.shutdown();
        }
        // 随机选择推荐结果
        List<SysHouse> recommendProducts = RandomProductUtils.RandomProducts(list, howMany);
        return recommendProducts;
    }

    @Override
    public List<SysHouse> BaseUserRecommend(Map<Long, Map<Long, Double>> data, Long userId, int k, int howMany) {
        // 从 data 中获取指定 userId 的用户评分数据，并将其存储在 targetUserRatings 变量中
        Map<Long, Double> targetUserRatings = data.get(userId);
        // 没有这个用户的购买记录
        if (targetUserRatings == null || targetUserRatings.isEmpty()) {
            // 如果没有这个用户的购买记录，则随机推荐商品
            return randomRecommend(howMany);
            // return new ArrayList<>();
        }
        /**
         * 创建了一个优先级队列 topKNeighbors，它用于存储与目标用户最相似的前 k 个用户。
         * 这里使用了 Map.Entry<Long, Double> 类型作为队列元素，队列的排序方式是按照相似度值从小到大排列。
         */
        PriorityQueue<Map.Entry<Long, Double>> topKNeighbors = new PriorityQueue<>(
                Comparator.comparingDouble(Map.Entry<Long, Double>::getValue)
        );

        // 用于存储推荐商品的候选集。Key是商品ID，Value是对该商品的加权评分。
        Map<Long, Double> candidateProducts = new HashMap<>();

        // 两个 for 循环，用于计算目标用户与其他用户之间的相似度，并基于相似度来推荐商品。
        // 第一个 for 循环遍历 data 中的每一对键值对，其中Key是其他用户的ID，Value是该用户的评分数据
        for (Map.Entry<Long, Map<Long, Double>> entry : data.entrySet()) {
            // 获取当前循环中的其他用户的ID。
            Long otherUserId = entry.getKey();
            // 排除当前登录用户，不将自己列入计算
            if (otherUserId == userId) {
                continue;
            }
            // 调用 SimilarityCalculator 类中的 pearsonCorrelation 方法计算目标用户与当前其他用户之间的皮尔逊相关系数，并将结果存储在 similarity 变量中
            // 将当前登录用户评分数据和其他用户的评分数据计算皮尔逊相似度
            double similarity = SimilarityCalculator.pearsonCorrelation(targetUserRatings, entry.getValue());

            // 检查当前最相似的前 k 个用户的相似度队列 topKNeighbors 的大小是否小于 k。如果是，则表示队列中还有空间可以添加新的相似度信息。
            if (topKNeighbors.size() < k) {
                // 如果队列的大小小于 k，那么将当前用户的相似度信息（包括用户ID otherUserId 和相似度 similarity）作为一个键值对添加到队列中。
                topKNeighbors.add(new AbstractMap.SimpleEntry<>(otherUserId, similarity));
                // 如果队列已满（即当前最相似的前 k 个用户已经被找到），那么就需要比较新计算出的相似度与当前队列中最不相似的用户的相似度（即队列中的最小值）。
            } else if (topKNeighbors.peek() != null && similarity > topKNeighbors.peek().getValue()) {
                // 如果新计算出的相似度 similarity 大于当前队列中最小的相似度，则将队列中最小相似度的信息移除，以便为新的更相似的用户腾出空间。
                topKNeighbors.poll();
                // 将新的用户的相似度信息（包括用户ID otherUserId 和相似度 similarity）添加到队列中，以更新当前最相似的前 k 个用户的信息。
                topKNeighbors.add(new AbstractMap.SimpleEntry<>(otherUserId, similarity));
            }
        }

        // for 循环遍历 topKNeighbors 队列中的每个元素，每个元素是一个包含用户ID和相似度的键值对。
        for (Map.Entry<Long, Double> neighbor : topKNeighbors) {
            // 获取当前循环中的其他用户的ID。
            Long otherUserId = neighbor.getKey();
            // 从 data 中获取当前循环中的其他用户的评分数据，并将其存储在 otherUserRatings 变量中。
            Map<Long, Double> otherUserRatings = data.get(otherUserId);
            // for 循环遍历当前其他用户的评分数据，其中每个元素是一个包含商品ID和评分的键值对。
            for (Map.Entry<Long, Double> ratingEntry : otherUserRatings.entrySet()) {
                // 获取当前循环中的商品ID。
                Long pid = ratingEntry.getKey();
                // 判断目标用户是否已经对当前商品进行了评分，如果没有评分，则将其他用户对该商品的评分加权添加到 candidateProducts 中。
                if (!targetUserRatings.containsKey(pid)) {
                    candidateProducts.put(pid, candidateProducts.getOrDefault(pid, 0.0) + ratingEntry.getValue());
                }
            }
        }
        // 检查推荐商品列表是否为空或者少于5个
        if (candidateProducts.isEmpty() || candidateProducts.size() < 5) {
            // 如果推荐结果少于5个，或者为空，随机推荐商品
            return randomRecommend(howMany);
            // return new ArrayList<>();
        }
        // 将 candidateProducts 中的商品按照加权评分从高到低排序，并将排好序的商品ID存储在 recommendedProducts 列表中，然后返回该列表作为推荐结果。
        List<Long> recommendedProducts = new ArrayList<>(candidateProducts.keySet());
        // 按照加权评分从高到低排序
        recommendedProducts.sort((p1, p2) -> Double.compare(candidateProducts.get(p2), candidateProducts.get(p1)));
        // 返回指定数量的商品
        List<Long> ids = recommendedProducts.subList(0, Math.min(howMany, recommendedProducts.size()));
        return sysHouseMapper.selectBatchIds(ids);
        // 返回全部
//        return recommendedProducts;
    }

    @Override
    public List<SysUser> userRecommend(Map<Long, Map<Long, Double>> data, Long userId, int k, int howMany) {
        // data的格式：[userId, [{itemId, rete},] ]   这里的userId是用户id，是用户行为数据
        // userId是房东id
        List<SysHouse> houseList = sysHouseMapper.getHouseListByOwnerId(userId);
        List<SysUser> userList = new ArrayList<>();

        Map<Long, List<SysUser>> map = new HashMap<>();

        for (SysHouse sysHouse : houseList) {
            List<SysUser> recommendUserList = calculateUserByItemID(data, sysHouse.getId(), k, howMany);
            map.put(sysHouse.getId(), recommendUserList);
        }
        System.out.println(map);
        // 将每个房源的推荐用户列表合并为一个大列表，并去重
        List<SysUser> users = map.values().stream()
                .flatMap(List::stream)
                .distinct()
                .collect(Collectors.toList());
        // 太多了，随机一下
        List<SysUser> randomUsers = new ArrayList<>();
        Random random = new Random();
        int size = users.size();
        if (size <= 10) {
            randomUsers.addAll(users);
        } else {
            Set<Integer> chosenIndices = new HashSet<>();
            while (randomUsers.size() < 10) {
                int index = random.nextInt(size);
                if (!chosenIndices.contains(index)) {
                    chosenIndices.add(index);
                    randomUsers.add(users.get(index));
                }
            }
        }
        return randomUsers;
    }

    public List<SysUser> randomUserRecommend(int howMany) {
        List<SysUser> list = new ArrayList<>();
        list = sysUserService.getUserList();
        // 随机选择推荐结果
        List<SysUser> randomUserList = RandomProductUtils.randomUsers(list, howMany);
        return randomUserList;
    }

    public List<SysUser> calculateUserByItemID(Map<Long, Map<Long, Double>> data, Long itemId, int k, int howMany) {
        Map<Long, Double> targetItemRatings = data.get(itemId);
        System.out.println(data);
        // 没有这个房屋的操作记录
        if (targetItemRatings == null || targetItemRatings.isEmpty()) {
            // 如果没有这个用户的购买记录，则随机推荐商品
            return randomUserRecommend(howMany);
        }
        /**
         * 创建了一个优先级队列 topKNeighbors，它用于存储与目标用户最相似的前 k 个用户。
         * 这里使用了 Map.Entry<Long, Double> 类型作为队列元素，队列的排序方式是按照相似度值从小到大排列。
         */
        PriorityQueue<Map.Entry<Long, Double>> topKNeighbors = new PriorityQueue<>(
                Comparator.comparingDouble(Map.Entry<Long, Double>::getValue)
        );
        // 用于存储推荐商品的候选集。Key是用户ID，Value是对该商品的加权评分。
        Map<Long, Double> candidateProducts = new HashMap<>();

        // 两个 for 循环，用于计算目标用户与其他用户之间的相似度，并基于相似度来推荐商品。
        // 第一个 for 循环遍历 data 中的每一对键值对，其中Key是其他用户的ID，Value是该用户的评分数据
        for (Map.Entry<Long, Map<Long, Double>> entry : data.entrySet()) {
            // 获取当前循环中的其他用户的ID。
            Long otherItemId = entry.getKey();
            // 不将自己本身列入计算
            if (otherItemId == itemId) {  // Objects.equals(otherItemId, itemId)
                continue;
            }
            // 调用 SimilarityCalculator 类中的 pearsonCorrelation 方法计算目标用户与当前其他用户之间的皮尔逊相关系数，并将结果存储在 similarity 变量中
            // 将当前登录用户评分数据和其他用户的评分数据计算皮尔逊相似度
            // System.out.println("targetItemRatings"+targetItemRatings);
            // System.out.println("entry.getValue()"+entry.getValue());
            if (targetItemRatings == null){  // 如果不加这个，我试过了会有null值出现，然后下面计算皮尔逊的就会报错
                continue;
            }
            double similarity = SimilarityCalculator.userPearsonCorrelation(targetItemRatings, entry.getValue());

            // 检查当前最相似的前 k 个用户的相似度队列 topKNeighbors 的大小是否小于 k。如果是，则表示队列中还有空间可以添加新的相似度信息。
            if (topKNeighbors.size() < k) {
                // 如果队列的大小小于 k，那么将当前用户的相似度信息（包括用户ID otherUserId 和相似度 similarity）作为一个键值对添加到队列中。
                topKNeighbors.add(new AbstractMap.SimpleEntry<>(otherItemId, similarity));
                // 如果队列已满（即当前最相似的前 k 个用户已经被找到），那么就需要比较新计算出的相似度与当前队列中最不相似的用户的相似度（即队列中的最小值）。
            } else if (topKNeighbors.peek() != null && similarity > topKNeighbors.peek().getValue()) {
                // 如果新计算出的相似度 similarity 大于当前队列中最小的相似度，则将队列中最小相似度的信息移除，以便为新的更相似的用户腾出空间。
                topKNeighbors.poll();
                // 将新的用户的相似度信息（包括用户ID otherUserId 和相似度 similarity）添加到队列中，以更新当前最相似的前 k 个用户的信息。
                topKNeighbors.add(new AbstractMap.SimpleEntry<>(otherItemId, similarity));
            }
        }

        // for 循环遍历 topKNeighbors 队列中的每个元素，每个元素是一个包含用户ID和相似度的键值对。
        for (Map.Entry<Long, Double> neighbor : topKNeighbors) {
            // 获取当前循环中的其他用户的ID。
            Long otherUserId = neighbor.getKey();
            // 从 data 中获取当前循环中的其他用户的评分数据，并将其存储在 otherUserRatings 变量中。
            Map<Long, Double> otherUserRatings = data.get(otherUserId);
            // for 循环遍历当前其他用户的评分数据，其中每个元素是一个包含商品ID和评分的键值对。
            for (Map.Entry<Long, Double> ratingEntry : otherUserRatings.entrySet()) {
                // 获取当前循环中的商品ID。
                Long pid = ratingEntry.getKey();
                // 判断目标用户是否已经对当前商品进行了评分，如果没有评分，则将其他用户对该商品的评分加权添加到 candidateProducts 中。
                if (!targetItemRatings.containsKey(pid)) {
                    candidateProducts.put(pid, candidateProducts.getOrDefault(pid, 0.0) + ratingEntry.getValue());
                }
            }
        }
        // 检查推荐商品列表是否为空或者少于2个
        if (candidateProducts.isEmpty() || candidateProducts.size() < 1) {
            // 如果推荐结果少于2个，或者为空，随机推荐商品
            return randomUserRecommend(howMany);
        }
        // 将 candidateProducts 中的商品按照加权评分从高到低排序，并将排好序的商品ID存储在 recommendedProducts 列表中，然后返回该列表作为推荐结果。
        List<Long> recommendUsers = new ArrayList<>(candidateProducts.keySet());
        // 按照加权评分从高到低排序
        recommendUsers.sort((p1, p2) -> Double.compare(candidateProducts.get(p2), candidateProducts.get(p1)));
        // 返回指定数量的商品
        List<Long> ids = recommendUsers.subList(0, Math.min(howMany, recommendUsers.size()));
        if (ids.isEmpty()) {
            return Collections.emptyList(); // 返回一个空列表
        } else {
            return sysUserMapper.selectBatchIds(ids);
        }
        // 返回全部
//        return recommendedProducts;
    }





    // 给商家推荐用户
    @Override
    public List<SysUser> BaseBusinessRecommend(Map<Long, Map<Long, Double>> data, Long userId, int k, int howMany) {
        // 构建一个结果集，用于存储推荐的用户
        List<SysUser> recommendedUsers = new ArrayList<>();
        // 查询房东所拥有的房屋
        List<SysHouse> houseList = sysHouseMapper.getHouseListByOwnerId(userId);
        // 构建一个结果集，用于存储可能对这些房屋感兴趣的用户
        Set<Long> interestedUsers = new HashSet<>();
        // 遍历data，查找可能对这些房屋感兴趣的用户
        for (Map.Entry<Long, Map<Long, Double>> entry : data.entrySet()) {
            // 这个userID是顾客id
            Long userID = entry.getKey();
            Map<Long, Double> itemRatings = entry.getValue();
            // 构建一个结果集，用于存储商品偏好得分
            Map<Long, Double> itemPreferences = new HashMap<>();
            // 遍历用户对商品的评分
            for (Map.Entry<Long, Double> ratingEntry : itemRatings.entrySet()) {
                Long itemID = ratingEntry.getKey();
                Double rating = ratingEntry.getValue();
                // 将商品评分加入到偏好得分中
                itemPreferences.put(itemID, rating);
            }
            // 对商品偏好得分进行降序排序
            List<Map.Entry<Long, Double>> sortedEntries = new ArrayList<>(itemPreferences.entrySet());
            sortedEntries.sort(Map.Entry.<Long, Double>comparingByValue().reversed());
            // 取出排在前5的商品ID
            List<Long> topItems = new ArrayList<>();
            int count = 0;
            for (Map.Entry<Long, Double> entry1 : sortedEntries) {
                if (count >= 5 || entry.getValue() == null) {
                    break;
                }
                topItems.add(entry1.getKey());
                count++;
            }
            // 输出前5个商品ID
            System.out.println("用户 " + userID + " 的前5个商品ID为：" + topItems);
            // 遍历房东所拥有的房屋列表
            for (SysHouse house : houseList) {
                Long houseId = house.getId();
                // 如果商品偏好得分中包含该房屋ID，则将可能对该房屋感兴趣的用户添加到结果集中
                if (topItems.contains(houseId)) {
                    interestedUsers.add(userID);
                    break;
                }
            }
            // 输出可能对这些房屋感兴趣的用户ID
            System.out.println("对这些房屋感兴趣的用户ID为：" + interestedUsers);
        }


        recommendedUsers = sysUserMapper.selectBatchIds(interestedUsers);
        return recommendedUsers;
    }


    // 给商家推荐用户
    // @Override
    public List<SysUser> BaseBusinessRecommend2(Map<Long, Map<Long, Double>> data, Long userId, int k, int howMany) {
        // 构建一个结果集，用于存储推荐的用户
        List<SysUser> recommendedUsers = new ArrayList<>();

        // 查询房东所拥有的房屋
        List<SysHouse> houseList = sysHouseMapper.getHouseListByOwnerId(userId);

        // 构建一个结果集，用于存储可能对这些房屋感兴趣的用户的评分
        Map<Long, Double> houseRatings = new HashMap<>();

        // 遍历data，查找可能对这些房屋感兴趣的用户的评分
        for (Map.Entry<Long, Map<Long, Double>> entry : data.entrySet()) {
            Long userID = entry.getKey();
            Map<Long, Double> itemRatings = entry.getValue();

            // 遍历房东的房屋列表
            for (SysHouse house : houseList) {
                Long houseId = house.getId();

                // 如果用户的评分数据包含当前房屋ID，则将评分加入到结果集中
                if (itemRatings.containsKey(houseId)) {
                    Double rating = itemRatings.get(houseId);
                    houseRatings.put(houseId, rating);
                }
            }
        }

        // 对房屋评分进行排序
        List<Map.Entry<Long, Double>> sortedRatings = new ArrayList<>(houseRatings.entrySet());
        sortedRatings.sort(Map.Entry.comparingByValue(Comparator.reverseOrder()));

        // 取前howMany个评分最高的房屋ID
        List<Long> topHouseIds = sortedRatings.stream()
                .limit(howMany)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        // 根据房屋ID查询对应的用户
        for (Long houseId : topHouseIds) {
            SysUser user = sysUserService.getById(houseId);
            recommendedUsers.add(user);
        }

        return recommendedUsers;
    }


    // 计算当前用户与房东的房屋之间的相似度
    double calculateSimilarity2(Map<Long, Double> itemRatings, List<SysHouse> houseList) {
        double similarity = 0.0;

        // 遍历顾客给出的评分
        for (Map.Entry<Long, Double> entry : itemRatings.entrySet()) {
            Long houseId = entry.getKey();
            Double rating = entry.getValue();

            // 遍历所有房屋
            for (SysHouse house : houseList) {
                if (house.getId() == houseId) {
                    System.out.println("有了");
                }
            }
        }

        return similarity;
    }


    // @Override
    public List<SysUser> BaseBusinessRecommend1(Map<Long, Map<Long, Double>> data, Long userId, int k, int howMany) {
        // 构建一个结果集，用于存储推荐的用户
        List<SysUser> recommendedUsers = new ArrayList<>();
        // 设定相似度计算的阈值
        double similarityThreshold = 0.5;

        // 查询房东所拥有的房屋
        List<SysHouse> houseList = sysHouseMapper.getHouseListByOwnerId(userId);

        // 构建一个结果集，用于存储可能对这些房屋感兴趣的用户
        Set<Long> interestedUsers = new HashSet<>();
        // 遍历data，查找可能对这些房屋感兴趣的用户
        for (Map.Entry<Long, Map<Long, Double>> entry : data.entrySet()) {
            // 这个userID是顾客id
            Long userID = entry.getKey();
            Map<Long, Double> itemRatings = entry.getValue();

            // 计算当前用户与房东的房屋之间的相似度
            double similarity = calculateSimilarity1(itemRatings, houseList);

            // 如果相似度高于阈值，认为该用户对房东的房屋感兴趣
            if (similarity >= similarityThreshold) {
                interestedUsers.add(userID);
            }
        }


        // recommendedUsers = sysUserMapper.selectBatchIds(interestedUsers);
        return recommendedUsers;
    }

    private double calculateSimilarity1(Map<Long, Double> itemRatings, List<SysHouse> houseList) {
        double dotProduct = 0;
        double magnitudeA = 0;
        double magnitudeB = 0;

        // 将房东的房屋属性转换成特征向量，并计算与当前用户之间的余弦相似度
        for (SysHouse house : houseList) {
            // 对于每个房屋，我们可以使用其属性的加权和来构建其特征向量。
            // 在此示例中，我们使用houseType、area和price属性来表示房屋特征向量，
            // 可以根据实际情况添加或删除其他属性。
            double weight = getWeight(house);
            if (house != null && house.getId() != null && itemRatings.containsKey(house.getId())) {
                // 如果用户对该房屋已经有过评分记录，则将该评分作为权重乘以特征向量
                double rating = itemRatings.get(house.getId());
                dotProduct += rating * weight;
            } else {
                // 处理 house 或者 id 为 null 的情况
            }
            magnitudeB += weight * weight;
        }

        // 计算用户向量的模长
        for (Double rating : itemRatings.values()) {
            magnitudeA += rating * rating;
        }
        magnitudeA = Math.sqrt(magnitudeA);

        // 计算余弦相似度
        if (magnitudeA == 0 || magnitudeB == 0) {
            return 0;
        } else {
            return dotProduct / (magnitudeA * Math.sqrt(magnitudeB));
        }
    }

    private double getWeight(SysHouse house) {
        double area = extractNumberFromString(house.getArea());

        // 在此示例中，我们使用houseType、area和price属性来表示房屋特征向量，
        // 可以根据实际情况添加或删除其他属性。
        double weight = 0.0;
        weight += house.getTypeId() * 0.6;
        weight += area * 0.3;
        weight += house.getPrice().doubleValue() * 0.1; // 将 BigDecimal 转换为 double
        return weight;
    }

    private double extractNumberFromString(String input) {
        // 使用正则表达式从字符串中提取数字部分
        String regex = "\\d+";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(input);
        if (matcher.find()) {
            String numberStr = matcher.group();
            try {
                return Double.parseDouble(numberStr);
            } catch (NumberFormatException e) {
                // 处理转换异常
                e.printStackTrace();
            }
        }
        return 0.0;
    }


}




