package com.zhigu.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.LoginLogMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.LoginLog;
import com.zhigu.service.user.ILoginLogService;

@Service
public class LoginLogServiceImpl implements ILoginLogService {
	@Autowired
	private LoginLogMapper loginLogDao;
	@Autowired
	private UserMapper userDao;

	@Override
	public void addLoginLog(LoginLog loginLog) {
		if (loginLog.getSuccess()) {
			userDao.updateUserauthInfoLoginData(loginLog.getUserId());
		}
		loginLogDao.insert(loginLog);
	}

	@Override
	public LoginLog queryPreviousLoginLogByUserID(int userId) {
		return loginLogDao.queryPreviousLoginLogByUserId(userId);
	}

}
