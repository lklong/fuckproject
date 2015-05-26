package com.zhigu.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.dto.MsgBean;

/**
 * 手机端session拦截器
 * 
 * @author HeSiMin
 * @date 2014年10月9日
 *
 */
public class MobileSessionInterceptor extends HandlerInterceptorAdapter {
	private static final String MOBILE = "/mobile/";
	private static final String USER = "/user/";
	private static Logger logger = Logger.getLogger(MobileSessionInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 请求的URI
		String requestURI = request.getRequestURI();
		SessionUser sessionUser = SessionHelper.getSessionUser();
		if (requestURI.indexOf(USER) > -1) {
			if (sessionUser == null) {
				MsgBean msg = new MsgBean();
				msg.setMsgBean(999, "请登录！", MsgLevel.ERROR);
				response.getWriter().write(JSON.toJSONString(msg));
				return false;
			}
		}
		// 手机端请求
		if (logger.isDebugEnabled()) {
			logger.debug("mobile==>:" + requestURI);
			logger.debug("mobile==>Parameter:" + JSON.toJSONString(request.getParameterMap()));
		}
		return super.preHandle(request, response, handler);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		// 请求的URI
		// String requestURI = request.getRequestURI();
		// if (requestURI.startsWith(MOBILE)) {
		// if (logger.isDebugEnabled()) {
		// // logger.debug("mobile-response:" + response.getStatus() +
		// // "(status)--" +
		// // JsonUtil.getJsonStr(response.getHeaderNames()));
		// }
		// }
		super.afterCompletion(request, response, handler, ex);
	}
}
