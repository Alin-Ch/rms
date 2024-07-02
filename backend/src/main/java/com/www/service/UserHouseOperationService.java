package com.www.service;

import com.www.pojo.SysHouse;
import com.www.pojo.SysUser;
import com.www.pojo.UserHouseOperation;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
* @author Alin
* @description 针对表【user_house_operation】的数据库操作Service
* @createDate 2024-05-11 12:30:38
*/
public interface UserHouseOperationService extends IService<UserHouseOperation> {

    List<UserHouseOperation> getAllUserOperation();

    List<SysHouse> BaseUserRecommend(Map<Long, Map<Long, Double>> data, Long id, int i, int i1);

    List<SysHouse> randomRecommend(int howMany);

    List<SysUser> BaseBusinessRecommend(Map<Long, Map<Long, Double>> data, Long id, int i, int i1);

    List<UserHouseOperation> getAllHouseOperation();


    List<SysUser> userRecommend(Map<Long, Map<Long, Double>> data, Long id, int i, int i1);
}
