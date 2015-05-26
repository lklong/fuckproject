package com.zhigu.common.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Common;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.NetUtil;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserService;

/**
 * Sesson拦截器（全局）
 * 
 */
public class SessionInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = Logger.getLogger(SessionInterceptor.class);
	private static final String USER = "/user/";
	private static final String SUPPLIER = "/supplier/";
	private static final String ADMIN = "/admin";
	private static final String MOBILE = "/mobile/";
	@Autowired
	private IUserService userService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		request.setCharacterEncoding(Common.UTF_8);
		response.setCharacterEncoding(Common.UTF_8);
		response.setContentType("text/html;charset=UTF-8");
		// 不允许浏览器端或缓存服务器缓存当前页面信息。
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		response.addHeader("Cache-Control", "no-cache");// 浏览器和缓存服务器都不应该缓存页面信息
		response.addHeader("Cache-Control", "no-store");// 请求和响应的信息都不应该被存储在对方的磁盘系统中；
		// response.addHeader("Cache-Control", "must-revalidate");//
		// 于客户机的每次请求，代理服务器必须向服务器验证缓存是否过时；

		// 日志记录
		if (logger.isInfoEnabled()) {
			StringBuilder sb = new StringBuilder();
			SessionUser user = SessionHelper.getSessionUser();
			sb.append("userID=").append(user != null ? user.getUserID() : null);
			sb.append("; adminID=").append(SessionHelper.getSessionAdmin() != null ? SessionHelper.getSessionAdmin().getId() : null);
			sb.append("; ip=").append(NetUtil.getIpAddr(request));
			sb.append("; uri=").append(request.getRequestURI());
			sb.append("; params=").append(JSON.toJSONString(request.getParameterMap()));
			sb.append("; method=").append(request.getMethod());
			logger.info("访问日志（SessionInterceptor）：" + sb.toString());
		}
		// 请求的URI
		String requestURI = request.getRequestURI();
		if (requestURI.indexOf(ADMIN) > -1 || requestURI.indexOf(MOBILE) > -1) {
			return super.preHandle(request, response, handler);
		}
		// cookie登陆
		SessionUser sessionUser = SessionHelper.getSessionUser();
		if (sessionUser == null) {
			Cookie[] cookies = request.getCookies();
			if (userService.cookieLogin(cookies)) {
				// 登陆成功，重新获取sessionUser
				sessionUser = SessionHelper.getSessionUser();
			}
		}

		// user、supplier链接必须登陆
		if (sessionUser == null && (requestURI.indexOf(USER) > -1 || requestURI.indexOf(SUPPLIER) > -1)) {
			if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
				// ajax请求，在header中设置errorCode
				response.setHeader("errorCode", "1");
				response.setContentType("application/json;charset=utf-8");
				response.getWriter().write(JSON.toJSONString(new MsgBean(Code.FAIL, "未登陆！ <a href='/login' style='color:red'>请登陆 > ></a>", MsgLevel.ERROR)));
				return false;
			} else {
				// 弹出提示
				// response.getWriter().write("<script type='text/javascript' charset='UTF-8'>$(document).ready(function(){gologin();})</script>");

				response.sendRedirect("/login?backUrl=" + request.getRequestURL().toString());
				return false;
			}
		}
		// 访问卖家链接，检查是否为卖家，不是转到店铺注册
		if (sessionUser != null && sessionUser.getUserType() == UserType.USER && requestURI.indexOf(SUPPLIER) > -1) {
			if (!requestURI.startsWith("/supplier/store/registerInit") && !requestURI.startsWith("/supplier/store/register")) {
				response.sendRedirect("/supplier/store/registerInit");
				return false;
			}
		}
		return super.preHandle(request, response, handler);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

}
