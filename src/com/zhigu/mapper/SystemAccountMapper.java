package com.zhigu.mapper;

import com.zhigu.model.SystemAccount;

public interface SystemAccountMapper {
	int deleteByPrimaryKey(Long id);

	int insert(SystemAccount record);

	int insertSelective(SystemAccount record);

	SystemAccount selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(SystemAccount record);

	int updateByPrimaryKey(SystemAccount record);
}