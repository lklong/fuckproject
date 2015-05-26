package com.zhigu.mapper;

import com.zhigu.model.CategoryValue;

public interface CategoryValueMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(CategoryValue record);

	int insertSelective(CategoryValue record);

	CategoryValue selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(CategoryValue record);

	int updateByPrimaryKey(CategoryValue record);
}