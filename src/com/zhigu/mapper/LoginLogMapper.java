package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.LoginLog;
import com.zhigu.model.PageBean;

/**
 * 登陆日志数据接口
 * 
 * @author HeSiMin
 * @date 2014年8月18日
 *
 */
public interface LoginLogMapper {
	/**
	 * 添加登陆日志
	 * 
	 * @param loginLog
	 */
	public void addLoginLog(LoginLog loginLog);

	/**
	 * 查询登陆日志
	 * 
	 * @param page
	 * @return
	 */
	public List<LoginLog> queryLoginLogByPage(PageBean<LoginLog> page);

	public LoginLog queryPreviousLoginLogByUserID(int userId);
}
