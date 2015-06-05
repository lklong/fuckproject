package com.zhigu.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.Flg;
import com.zhigu.mapper.LoginLogMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.LoginLog;
import com.zhigu.model.PageBean;
import com.zhigu.service.user.ILoginLogService;

@Service
public class LoginLogServiceImpl implements ILoginLogService {
	@Autowired
	private LoginLogMapper loginLogDao;
	@Autowired
	private UserMapper userDao;

	@Override
	public void addLoginLog(LoginLog loginLog) {
		if (loginLog.getLoginStatus() == Flg.ON) {
			userDao.updateUserauthInfoLoginData(loginLog.getUserID());
		}
		loginLogDao.addLoginLog(loginLog);
	}

	@Override
	public PageBean<LoginLog> queryLoginLog(PageBean<LoginLog> page) {
		List<LoginLog> list = loginLogDao.queryLoginLogByPage(page);
		page.setDatas(list);
		return page;
	}

	@Override
	public LoginLog queryPreviousLoginLogByUserID(int userId) {
		return loginLogDao.queryPreviousLoginLogByUserID(userId);
	}

}
