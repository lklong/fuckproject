package com.zhigu.service.user;

import com.zhigu.model.LoginLog;

public interface ILoginLogService {
	/**
	 * 添加登陆日志
	 * 
	 * @param loginLog
	 */
	public void addLoginLog(LoginLog loginLog);

	/**
	 * 前一次登陆日志（时间倒序，第二条数据）
	 * 
	 * @param userID
	 * @return
	 */
	public LoginLog queryPreviousLoginLogByUserID(int userID);
}
