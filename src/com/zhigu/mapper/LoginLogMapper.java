package com.zhigu.mapper;

import com.zhigu.model.LoginLog;

public interface LoginLogMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(LoginLog record);

	int insertSelective(LoginLog record);

	LoginLog selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(LoginLog record);

	int updateByPrimaryKey(LoginLog record);

	/**
	 * 根据用户ID查询登录日志
	 * 
	 * @param userId
	 * @return
	 */
	public LoginLog queryPreviousLoginLogByUserId(int userId);
}