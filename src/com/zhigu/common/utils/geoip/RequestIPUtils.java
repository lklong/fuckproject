/**
 * @ClassName: RequestIPUtils.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年6月9日
 * 
 */
package com.zhigu.common.utils.geoip;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Administrator
 *
 */
public class RequestIPUtils {

	public static String getIpAddr(HttpServletRequest request) {

		String ip = request.getHeader("x-forwarded-for");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}

}
