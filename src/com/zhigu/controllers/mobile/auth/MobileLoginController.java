package com.zhigu.controllers.mobile.auth;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.NetUtil;
import com.zhigu.model.LoginLog;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.ILoginLogService;
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
	@Autowired
	private ILoginLogService loginLogService;

	@RequestMapping("/islogin")
	@ResponseBody
	public String isLogin() {
		SessionUser ses = SessionHelper.getSessionUser();
		if (ses != null) {
			return "true";
		}
		return "false";
	}

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
	@RequestMapping("logout")
	@ResponseBody
	public MsgBean logout() {
		SessionHelper.getSession().invalidate();
		// SessionHelper.setSessionUser(null);
		// Cookie cu = new Cookie("username", "");
		// Cookie cp = new Cookie("password", "");
		// cu.setMaxAge(0);
		// cp.setMaxAge(0);
		// cu.setPath("/");
		// cp.setPath("/");
		// response.addCookie(cu);
		// response.addCookie(cp);
		MsgBean msg = new MsgBean(Code.SUCCESS, "退出成功！", MsgLevel.NORMAL);
		return msg;
	}

	/**
	 * 登录日志
	 */
	private void log() {
		SessionUser sess = SessionHelper.getSessionUser();
		if (sess == null)
			return;

		// 添加登陆日志
		HttpServletRequest request = SessionHelper.getRequest();

		LoginLog loginLog = new LoginLog();
		loginLog.setUserID(sess.getUserID());
		loginLog.setLoginDate(new Date());
		loginLog.setIP(NetUtil.getIpAddr(request));
		loginLog.setBrowser(request.getHeader("User-Agent"));
		loginLog.setLoginStatus(Flg.ON);
		loginLogService.addLoginLog(loginLog);
	}

}
