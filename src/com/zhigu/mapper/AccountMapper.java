package com.zhigu.mapper;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Account;

public interface AccountMapper {
	int deleteByPrimaryKey(Integer userId);

	int insert(Account record);

	int insertSelective(Account record);

	Account selectByPrimaryKey(Integer userId);

	int updateByPrimaryKeySelective(Account record);

	int updateByPrimaryKey(Account record);

	Account queryAccountByUserId(int userId);

	int updatePayPasswd(@Param("userId") int userId, @Param("payPasswd") String payPasswd, @Param("salt") String salt);
}