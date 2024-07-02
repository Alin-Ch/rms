package com.www.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.EchartsBie;
import com.www.pojo.SysHouse;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @author Alin
 * @description 针对表【sys_house】的数据库操作Mapper
 * @createDate 2024-04-27 21:40:08
 * @Entity com.wfzm.pojo.SysHouse
 */
@Mapper
public interface SysHouseMapper extends BaseMapper<SysHouse> {

    IPage<SysHouse> findBySearch(Page<SysHouse> page, String name, String username, String ownername);

    @Update("UPDATE sys_house SET watched = watched+1 WHERE id=#{id}")
    void addWatched(Long id);

    @Select("select * from sys_house limit #{startIdx}, #{endIdx}")
    List<SysHouse> getPageAllList(int startIdx, int endIdx);

    @Select("SELECT status AS name, COUNT(status) AS value FROM sys_house GROUP BY status")
    List<EchartsBie> getHouseStatusBie();

    Page<SysHouse> getPageData(Page page, String name, Long owner_id);

    @Select("SELECT * FROM sys_house where owner_id=#{ownerId}")
    List<SysHouse> getHouseListByOwnerId(Long ownerId);
}




