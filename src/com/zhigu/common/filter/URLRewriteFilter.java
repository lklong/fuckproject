package com.zhigu.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.utils.SpringContextUtil;
import com.zhigu.model.Store;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IUserService;

/**
 * Servlet Filter implementation class URLRewriteFilter
 * 
 * @deprecated 二级域名由前端nginx完成
 */
public class URLRewriteFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		/**
		 * 获得服务器名称，如：aaa.zhiguw.com/
		 */
		String serverName = request.getServerName();
		if (serverName.indexOf("zhiguw.com") >= 0) {
			if (serverName.equals("zhiguw.com")) {
				HttpServletResponse httpServletResponse = (HttpServletResponse) response;
				httpServletResponse.sendRedirect("http://www.zhiguw.com");
				return;
			}
			int endIndex = serverName.indexOf(".");
			String uri = httpServletRequest.getRequestURI();
			/**
			 * 获得二级域名
			 */
			String secondDomainName = serverName.substring(0, endIndex);
			if (!secondDomainName.equalsIgnoreCase("www") && uri.indexOf(".") == -1 && "/".equals(uri)) {
				IStoreService storeService = SpringContextUtil.getApplicationContext().getBean(IStoreService.class);
				Store store = storeService.queryStoreByDomain(secondDomainName);
				if (store != null) {
					// 登陆检查
					if (SessionHelper.getSessionUser() == null) {
						Cookie[] cookies = httpServletRequest.getCookies();
						IUserService userService = SpringContextUtil.getApplicationContext().getBean(IUserService.class);
						userService.cookieLogin(cookies);
					}
					request.setAttribute("storeID", store.getID());
					request.getRequestDispatcher("/store/index.do?storeId=" + store.getID()).forward(request, response);
					return;
				}
			}
		}
		// HttpServletRequest request = (HttpServletRequest) arg0;
		// HttpServletResponse response = (HttpServletResponse) arg1;
		// //主机名
		// String sname = request.getServerName();
		//
		// String uri = request.getRequestURI();
		// // 取得二级域名
		// String dname = sname.substring(0, sname.indexOf("."));
		// // 伪域名执行转发
		// if (!dname.equalsIgnoreCase("www") && uri.indexOf(".") == -1 &&
		// "/".equals(uri)) {
		// IStoreService storeService =
		// SpringContextUtil.getApplicationContext().getBean(IStoreService.class);
		// Store store = storeService.queryStoreByDomain(dname);
		// if (store != null) {
		// request.setAttribute("storeID", store.getID());
		// request.getRequestDispatcher("/store/index?storeId=" +
		// store.getID()).forward(arg0, arg1);
		// return;
		// }
		// }

		arg2.doFilter(request, response);

		// HttpServletRequest request = (HttpServletRequest) arg0;
		// HttpServletResponse response = (HttpServletResponse) arg1;
		// //主机名
		// String sname = request.getServerName();
		// String uri = request.getRequestURI();
		// //取得二级域名
		// String dname = sname.substring(0,sname.indexOf("."));
		// //商品详情
		// if(dname.equalsIgnoreCase("www") && (uri.contains("commodity/detail")
		// || uri.contains("store/commodityDetail") ||
		// uri.contains("/store/store"))){
		// IStoreService storeService =
		// SpringContextUtil.getApplicationContext().getBean(IStoreService.class);
		// ICommodityService commService =
		// SpringContextUtil.getApplicationContext().getBean(ICommodityService.class);
		// if(uri.contains("commodity/detail") ||
		// uri.contains("store/commodityDetail")){
		// Integer cid = Integer.parseInt(request.getParameter("commodityID"));
		// Commodity comm = commService.queryCommodityByID(cid);
		// Store store = storeService.queryStoreByID(comm.getStoreID());
		// response.sendRedirect("http://" + store.getDomain() + ".ingup.cn" +
		// uri + "?commodityID="+cid);
		// return;
		// }else{
		//
		// }
		//
		// }
		// //伪域名执行转发
		// if(!dname.equalsIgnoreCase("www") && uri.indexOf(".") == -1 &&
		// "/".equals(uri)){
		// IStoreService storeService =
		// SpringContextUtil.getApplicationContext().getBean(IStoreService.class);
		// Store store = storeService.queryStoreByDomain(dname);
		// if(store != null){
		// request.setAttribute("storeID",store.getID());
		// request.getRequestDispatcher("/store/store?storeID=" +
		// store.getID()).forward(arg0, arg1);;
		// return;
		// }else{
		// request.getRequestDispatcher("/404").forward(arg0, arg1);;
		// return;
		// }
		// }
		//
		// arg2.doFilter(arg0, arg1);
		return;
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
