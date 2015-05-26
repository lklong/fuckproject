package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.LogisticsSpecial;

public interface LogisticsSpecialMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(LogisticsSpecial record);

	int insertSelective(LogisticsSpecial record);

	LogisticsSpecial selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(LogisticsSpecial record);

	int updateByPrimaryKey(LogisticsSpecial record);

	List<LogisticsSpecial> selectByLogisticsId(@Param("logisticsId") Integer logisticsId, @Param("province") String province, @Param("city") String city);
}