package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.CategoryRef;

public interface CategoryRefMapper {
	int deleteByPrimaryKey(Integer id);

	int insertSelective(CategoryRef record);

	CategoryRef selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(CategoryRef record);

	List<CategoryRef> selectAll();

	CategoryRef selectTBCatByPlat(Integer catId);

}