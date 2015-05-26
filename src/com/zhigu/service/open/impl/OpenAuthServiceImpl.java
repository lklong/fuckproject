package com.zhigu.service.open.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.mapper.OpenAuthMapper;
import com.zhigu.model.OpenAuth;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.open.IOpenAuthService;
import com.zhigu.service.user.IUserService;

/**
 * 
 * @author zhouqibing 2014年7月21日下午5:49:09
 */
@Service
public class OpenAuthServiceImpl implements IOpenAuthService {

	@Autowired
	private OpenAuthMapper openAuthDao;
	@Autowired
	private IUserService userService;

	@Override
	public MsgBean saveOpenAuth(String userName, String password, String openID) {
		if (StringUtils.isBlank(openID)) {
			throw new ServiceException("绑定失败，请重新授权绑定！");
		}
		// 验证用户名与密码
		UserAuth auth = userService.verifyLogin(userName, password);
		if (auth == null) {// 用户名或密码错误
			return new MsgBean(Code.FAIL, "用户名或密码填写错误！", MsgLevel.ERROR);
		} // 执行绑定
		OpenAuth oauth = new OpenAuth();
		oauth.setUserID(auth.getUserID());
		oauth.setOpenID(openID);
		openAuthDao.saveOpenAuth(oauth);
		return userService.login(userName, password);
	}

	@Override
	public OpenAuth queryOpenAuthByOpenID(String openID) {
		return openAuthDao.queryOpenAuthByOpenID(openID);
	}

}
