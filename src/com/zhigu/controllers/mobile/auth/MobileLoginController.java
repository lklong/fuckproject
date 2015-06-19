package com.zhigu.controllers.mobile.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserService;

/**
 * 登录
 * 
 * @author zhouqibing 2014年7月21日上午11:15:42
 */
@Controller
@RequestMapping("/mobile/login")
public class MobileLoginController {

	@Autowired
	private IUserService userService;

	/**
	 * 登录
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @return
	 */
	@RequestMapping("/loginIn")
	@ResponseBody
	public MsgBean loginIn(@RequestParam String username, @RequestParam String password) {
		return userService.login(username, password);
	}

	/**
	 * 退出登录
	 * 
	 * @param response
	 * @return
	 */
	@RequestMapping("/loginOut")
	@ResponseBody
	public MsgBean logout() {
		SessionHelper.getSession().invalidate();
		return new MsgBean(Code.SUCCESS, "退出成功！", MsgLevel.NORMAL);
	}
}
