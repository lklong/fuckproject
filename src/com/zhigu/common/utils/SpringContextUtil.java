package com.zhigu.common.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * SpringContext
 * @author zhouqibing
 * 2014年8月9日上午11:32:25
 */
public class SpringContextUtil implements ApplicationContextAware{

	private static ApplicationContext applicationContext;
	@Override
	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		SpringContextUtil.applicationContext = arg0;
	}
	/**
	 * 
	 * @return
	 */
	public static ApplicationContext getApplicationContext(){
		return applicationContext;
	}
}
