package com.zhigu.mapper;

import com.zhigu.model.EmailVerify;

public interface EmailVerifyMapper {
	int deleteByPrimaryKey(Long id);

	int insert(EmailVerify record);

	int insertSelective(EmailVerify record);

	EmailVerify selectByPrimaryKey(Long id);

	int updateByPrimaryKeySelective(EmailVerify record);

	int updateByPrimaryKey(EmailVerify record);

	EmailVerify selectByUid(String uid);
}