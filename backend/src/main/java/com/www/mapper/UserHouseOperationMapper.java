package com.www.mapper;

import com.www.pojo.UserHouseOperation;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* @author Alin
* @description 针对表【user_house_operation】的数据库操作Mapper
* @createDate 2024-05-11 12:30:38
* @Entity com.wfzm.pojo.UserHouseOperation
*/
@Mapper
public interface UserHouseOperationMapper extends BaseMapper<UserHouseOperation> {


    List<UserHouseOperation> getAllUserOperation();

    List<UserHouseOperation> getAllHouseOperation();
}




