package com.zhigu.common.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.zhigu.common.utils.ZhiguConfig;

/***
 * 
 * 
 * Configuration
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
public class GlobalLoadListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent servletContextEvent) {
		ServletContext servletContext = servletContextEvent.getServletContext();
		String ctx = servletContext.getContextPath();
		// 设置根目录别名
		servletContext.setAttribute("ctx", ctx);
		servletContext.setAttribute("sctx", ctx);
		servletContext.setAttribute("basePath", ZhiguConfig.getValue(ZhiguConfig.HOST));
	}

	public void contextDestroyed(ServletContextEvent servletContextEvent) {

	}

	// 获取Spring托管的Bean
	// @SuppressWarnings("unused")
	// private Object getBean(ServletContext servletContext, String beanName) {
	// return
	// WebApplicationContextUtils.getWebApplicationContext(servletContext).getBean(beanName);
	// }

}
