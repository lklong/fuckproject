package com.zhigu.controllers.auth;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.oauth.Oauth;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.CookieKey;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.OpenUser;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.open.IOpenUserService;
import com.zhigu.service.user.ILoginLogService;
import com.zhigu.service.user.IUserService;

/**
 * 登录
 * 
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	private static Logger logger = Logger.getLogger(LoginController.class);
	@Autowired
	private IUserService userService;
	@Autowired
	private IOpenUserService openUserService;
	@Autowired
	private ILoginLogService loginLogService;

	private static final String OPEN_ID = "openID";

	@RequestMapping("")
	public ModelAndView login(ModelAndView mv, String backUrl) {
		SessionUser ses = SessionHelper.getSessionUser();
		mv.addObject("backUrl", backUrl);
		if (ses != null) {
			mv.setViewName("redirect:/user/home");
		} else {
			mv.setViewName("auth/login");
		}
		return mv;
	}

	@RequestMapping("/islogin")
	@ResponseBody
	public MsgBean isLogin() {
		SessionUser ses = SessionHelper.getSessionUser();
		return new MsgBean(Code.SUCCESS, "succes", MsgLevel.NORMAL).setData(ses == null ? false : true);
	}

	@RequestMapping(value = "/loginIn")
	@ResponseBody
	public MsgBean loginIn(@RequestParam String username, @RequestParam String password, String autoLogin, String backUrl, ModelAndView mv, HttpServletResponse response) {
		if (SessionHelper.getSessionUser() != null) {
			return new MsgBean(Code.SUCCESS, "登陆成功", MsgLevel.NORMAL);
		}
		password = StringUtil.decryptBASE64(password);

		return userService.login(username, password, autoLogin, response);
	}

	/**
	 * 
	 * @param response
	 * @return
	 */
	@RequestMapping("logout")
	public ModelAndView logout(ModelAndView mv, HttpServletResponse response) {
		Cookie cu = new Cookie(CookieKey.USER_NAME, "");
		Cookie cp = new Cookie(CookieKey.USER_PASSWORD, "");
		cu.setMaxAge(0);
		cp.setMaxAge(0);
		cu.setPath("/");
		cp.setPath("/");
		response.addCookie(cu);
		response.addCookie(cp);
		SessionHelper.getSession().invalidate();
		mv.setViewName("redirect:/");
		return mv;
	}

	/**
	 * QQ登录
	 * 
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/qq")
	public void qqLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=utf-8");
		try {
			response.sendRedirect(new Oauth().getAuthorizeURL(request));
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
	}

	/**
	 * QQ登录后通知
	 * 
	 * @param request
	 * @param response
	 * @param mv
	 * @return
	 */
	@RequestMapping("/qq/notify")
	public ModelAndView qqLoginNotification(HttpServletRequest request, ModelAndView mv, RedirectAttributes attr) {
		try {
			AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);
			String accessToken = null, openID = null;
			if (accessTokenObj.getAccessToken().equals("")) {
				// 我们的网站被CSRF攻击了或者用户取消了授权
				// 做一些数据统计工作
				System.out.println("没有获取到响应参数");
			} else {
				accessToken = accessTokenObj.getAccessToken();
				// 利用获取到的accessToken 去获取当前用的openid -------- start
				OpenID openIDObj = new OpenID(accessToken);
				openID = openIDObj.getUserOpenID();

				OpenUser auth = openUserService.queryOpenUserByOpenId(openID);
				if (auth == null) {
					// 第一次登录，让用户绑定
					com.qq.connect.api.qzone.UserInfo qzoneUserInfo = new com.qq.connect.api.qzone.UserInfo(accessToken, openID);
					com.qq.connect.javabeans.qzone.UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
					SessionHelper.setAttribute(OPEN_ID, openID);

					String avatar = userInfoBean.getAvatar().getAvatarURL100();
					String nike = userInfoBean.getNickname();
					mv.addObject("avatar", avatar);
					mv.addObject("nike", nike);
					mv.setViewName("redirect:/login/bound");
					return mv;
				} else {// 直接登录
					MsgBean result = userService.openIDLogin(openID);
					if (result.getCode() != Code.SUCCESS) {
						mv.addObject("msg", result.getMsg());
						mv.setViewName("/tips/error-tips");
					} else {
						mv.setViewName("redirect:/user/home");
					}
					return mv;
				}
			}
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
		mv.setViewName("redirect:/login");
		return mv;
	}

	/**
	 * 执行绑定操作
	 * 
	 */
	@RequestMapping(value = "/bound", method = RequestMethod.GET)
	public String bound() {
		return "/auth/register/bound";
	}

	@RequestMapping(value = "/bound", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean bound(String username, String password) {
		password = StringUtil.decryptBASE64(password);
		String openID = (String) SessionHelper.getAttribute(OPEN_ID);
		MsgBean msg = openUserService.saveOpenUser(username, password, openID);
		if (msg.getCode() == Code.SUCCESS) {
			SessionHelper.removeAttribute(OPEN_ID);
		}
		return msg;
	}

}
