package com.zhigu.common.exception;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.NetUtil;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.dto.MsgBean;

/**
 * 异常分析器
 * 
 */
public class CustomExceptionResolver extends SimpleMappingExceptionResolver {
	private static final Logger logger = Logger.getLogger(CustomExceptionResolver.class);

	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		String viewName = determineViewName(ex, request);
		if (viewName != null) {
			if (ex.getClass().getName().indexOf("ClientAbortException") < 0) {
				// 日志记录
				StringBuilder sb = new StringBuilder();
				SessionUser user = SessionHelper.getSessionUser();
				sb.append("==>userID=").append(user != null ? user.getUserID() : null);
				sb.append("; adminID=").append(SessionHelper.getSessionAdmin() != null ? SessionHelper.getSessionAdmin().getId() : null);
				sb.append("; ip=").append(NetUtil.getIpAddr(request));
				sb.append("; uri=").append(request.getRequestURI());
				sb.append("; params=").append(JSON.toJSONString(request.getParameterMap()));
				sb.append("; method=").append(request.getMethod());
				logger.warn("异常处理：" + sb.toString(), ex);

				if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request.getHeader("X-Requested-With") != null && request.getHeader("X-Requested-With").indexOf("XMLHttpRequest") > -1))) {
					// 如果不是异步请求
					Integer statusCode = determineStatusCode(request, viewName);
					if (statusCode != null) {
						applyStatusCodeIfPossible(request, response, statusCode);
					}
					return getModelAndView(viewName, ex, request);
				} else {// JSON格式返回
					try {
						response.setContentType("application/json;charset=utf-8");
						PrintWriter writer = response.getWriter();
						writer.write(JSON.toJSONString(new MsgBean(Code.FAIL, StringUtil.isEmpty(ex.getMessage()) || (!(ex instanceof ServiceException)) ? "服务器错误！" : ex.getMessage(), MsgLevel.ERROR)));
						writer.flush();
					} catch (IOException e) {
						logger.info("向客户端写入消息IO错误！", e);
					}
				}
			}
			return new ModelAndView();
		} else {
			return null;
		}
	}
}
