package com.zhigu.service.open.impl;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.mapper.OpenUserMapper;
import com.zhigu.model.OpenUser;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.open.IOpenUserService;
import com.zhigu.service.user.IUserService;

/**
 * 
 * @author zhouqibing 2014年7月21日下午5:49:09
 */
@Service
public class OpenUserServiceImpl implements IOpenUserService {

	@Autowired
	private OpenUserMapper openUserMapper;
	@Autowired
	private IUserService userService;

	@Override
	public MsgBean saveOpenUser(String userName, String password, String openId) {
		if (StringUtils.isBlank(openId)) {
			throw new ServiceException("绑定失败，请重新授权绑定！");
		}
		MsgBean loginMsg = userService.login(userName, password);
		if (loginMsg.getCode() == Code.SUCCESS) {
			// 执行绑定
			OpenUser openUser = new OpenUser();
			openUser.setUserId(SessionHelper.getSessionUser().getUserId());
			openUser.setOpenId(openId);
			openUser.setAddTime(new Date());
			openUserMapper.insert(openUser);
		}
		return loginMsg;
	}

	@Override
	public OpenUser queryOpenUserByOpenId(String openId) {
		return openUserMapper.selectByOpenId(openId);
	}

}
