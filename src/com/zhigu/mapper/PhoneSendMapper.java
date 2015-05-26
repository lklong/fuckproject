package com.zhigu.mapper;

import com.zhigu.model.PhoneSend;

public interface PhoneSendMapper {
	int deleteByPrimaryKey(Long id);

	int insert(PhoneSend record);

	int insertSelective(PhoneSend record);

	PhoneSend selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(PhoneSend record);

	int updateByPrimaryKey(PhoneSend record);
}