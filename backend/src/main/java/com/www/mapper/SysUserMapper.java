package com.www.mapper;

import com.www.pojo.EchartsBie;
import com.www.pojo.SysUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author anxm
 * @description 针对表【sys_user(用户表)】的数据库操作Mapper
 * @createDate 2024-03-24 19:44:08
 * @Entity com.wfzm.pojo.SysUser
 */
@Repository
public interface SysUserMapper extends BaseMapper<SysUser> {

    List<Long> getNavMenuIds(Long userId);

    List<SysUser> listByMenuId(Long menuId);

    @Update("update sys_user set statu = case when statu = 0 then 1 else 0 end where id = #{userId}")
    void updateStatus(Long userId);

    @Select("SELECT gender AS name, COUNT(gender) AS value FROM sys_user GROUP BY gender")
    List<EchartsBie> getGenderBie();


    @Select("SELECT * FROM sys_user WHERE id=#{id}")
    <R> R selectByPrimaryKey(Long id);

    @Select("select * from sys_user limit #{startIdx}, #{endIdx}")
    <U> U getPageAllList(int startIdx, int endIdx);

    List<SysUser> getUserList();
}




