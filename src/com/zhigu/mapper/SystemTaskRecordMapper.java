package com.zhigu.mapper;

import com.zhigu.model.SystemTaskRecord;

public interface SystemTaskRecordMapper {
	int deleteByPrimaryKey(Long id);

	int insert(SystemTaskRecord record);

	int insertSelective(SystemTaskRecord record);

	SystemTaskRecord selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(SystemTaskRecord record);

	int updateByPrimaryKey(SystemTaskRecord record);

	SystemTaskRecord selectLast(String type);
}