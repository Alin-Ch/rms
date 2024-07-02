package com.www.utils;

import com.www.pojo.SysHouse;
import com.www.pojo.SysUser;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Author Alin
 * @date 2024/5/11 011 12:25
 * @Description:
 */
public class RandomProductUtils {
    public static List<SysHouse> RandomProducts(List<SysHouse> list, int howMany) {
        List<SysHouse> recommendProducts = new ArrayList<>();
        Random random = new Random();

        List<SysHouse> availableProducts = list.stream()
                .filter(item -> item.getStatus() == 0)     // 过滤出状态为在售的商品
                .collect(Collectors.toList());
        int size = availableProducts.size();
        if (size <= howMany){
            return availableProducts;
        }

        Set<Integer> indexes = new HashSet<>();
        while (indexes.size() < howMany){
            int index = random.nextInt(size);
            if (!indexes.contains(index)){
                indexes.add(index);
                recommendProducts.add(availableProducts.get(index));
            }
        }
        return recommendProducts;
    }

    // 随机推荐用户
    public static List<SysUser> randomUsers(List<SysUser> userList, int howMany) {
        List<SysUser> recommendUserList = new ArrayList<>();
        Random random = new Random();

        int size = userList.size();
        if (size <= howMany) {
            return new ArrayList<>(userList); // 返回原始列表的拷贝
        }

        Set<Integer> chosenIndices = new HashSet<>();
        while (recommendUserList.size() < howMany) {
            int index = random.nextInt(size);
            if (!chosenIndices.contains(index)) {
                chosenIndices.add(index);
                recommendUserList.add(userList.get(index));
            }
        }

        return recommendUserList;
    }


}
