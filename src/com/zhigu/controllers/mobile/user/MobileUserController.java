package com.zhigu.controllers.mobile.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.utils.ZhiguConfig;

/**
 * 用户信息
 * 
 * @author zhouqibing 2014年7月22日上午8:54:49
 */
@Controller
@RequestMapping("/mobile/user")
public class MobileUserController {
	/*
	 * 取得和当前账号相关的推广链接
	 */
	@RequestMapping("/recommend")
	@ResponseBody
	public String recommend() {
		int userID = SessionHelper.getSessionUser().getUserID();
		String url = ZhiguConfig.getValue(ZhiguConfig.HOST) + "register?recommendUserID=" + userID;
		return url;
	}

}
