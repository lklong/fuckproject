package com.zhigu.mapper;

import com.zhigu.model.CategoryProperty;

public interface CategoryPropertyMapper {
	int deleteByPrimaryKey(CategoryProperty key);

	int insert(CategoryProperty record);

	int insertSelective(CategoryProperty record);
}