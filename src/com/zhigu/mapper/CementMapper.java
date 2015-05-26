package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.Cement;

public interface CementMapper {
	int deleteByPrimaryKey(Integer id);

	int insertSelective(Cement record);

	Cement selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Cement record);

	List<Cement> queryCements();
}