package com.zhigu.common.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionAdmin;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.SessionKey;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.AdminResource;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.adminuser.IAdminUserService;

/**
 * 后台权限检查拦截器
 * 
 * @author HeSiMin
 * @date 2014年12月18日
 *
 */
public class AdminAuthorizationInterceptor extends HandlerInterceptorAdapter {
	/**
	 * 平台管理系统登陆标识
	 */
	private static final String MANAGER_SYSTEM_LOGIN_MARK = "s0001";

	@Autowired
	private IAdminUserService adminUserService;

	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// 请求的URI
		String requestURI = request.getRequestURI();

		if (requestURI.indexOf("admin/login") > -1) {
			return super.preHandle(request, response, handler);
		}
		SessionAdmin admin = SessionHelper.getSessionAdmin();
		// 后台登陆检查
		if (admin == null) {
			if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
				// ajax
				response.setHeader("errorCode", "2");
				response.setContentType("application/json;charset=utf-8");
				response.getWriter().write(JSON.toJSONString(new MsgBean(Code.FAIL, "未登录或登录超时，请重新登录！", MsgLevel.ERROR)));
			} else {
				response.getWriter().write("<script type='text/javascript' charset='UTF-8'>window.top.location.href='/admin/login';</script>");
			}
			return false;
		}
		if (!admin.getLoginSystemMark().contains(MANAGER_SYSTEM_LOGIN_MARK)) {
			if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
				// ajax
				response.setContentType("application/json;charset=utf-8");
				response.getWriter().write(JSON.toJSONString(new MsgBean(Code.FAIL, "该账号无权限登录平台管理系统！", MsgLevel.ERROR)));
			} else {
				response.getWriter().write("<script type='text/javascript' charset='UTF-8'>alert('该账号无权限登录平台管理系统！');</script>");
			}
			return false;
		}

		// 用户请求的资源授权检查
		// 去掉扩展名
		int dotIndex = requestURI.indexOf(".");
		if (dotIndex > 0) {
			requestURI = requestURI.substring(0, dotIndex);
		}
		AdminResource nowResource = adminUserService.queryAdminResourceByResourceUrl(requestURI);

		if (nowResource == null) {// 不存在该资源
			// throw new ServiceException("不存在的请求！");
			return super.preHandle(request, response, handler);

		} else {
			if (nowResource.getIsCheck() == Flg.ON) {
				nowResource = adminUserService.checkPermission(admin.getId(), nowResource.getResourceUrl());
				if (nowResource == null) {
					// 弹出提示
					if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
						// ajax
						response.setHeader("errorCode", "3");
						response.getWriter().write("无权限进行此操作！");
						response.getWriter().write(JSON.toJSONString(new MsgBean(Code.FAIL, "无权限进行此操作！", MsgLevel.ERROR)));
					} else {
						response.getWriter().write("<script type='text/javascript' charset='UTF-8'>alert('无权限进行此操作！');</script>");
					}
					return false;
				}
			}
		}

		HttpSession session = request.getSession();
		if (nowResource.getIsMenu() == Flg.ON) {
			// admin菜单
			List<AdminResource> allmenu = (List<AdminResource>) session.getAttribute(SessionKey.SESSION_ADMIN_RESOURCE);
			if (allmenu == null) {
				allmenu = adminUserService.queryAdminMenuByUserID(admin.getId());
				session.setAttribute(SessionKey.SESSION_ADMIN_RESOURCE, allmenu);
			}
			// 主菜单列表
			List<AdminResource> mainMenus = new ArrayList<AdminResource>();
			// 子菜单列表
			List<AdminResource> subMenus = new ArrayList<AdminResource>();
			AdminResource cMainmenu = null;// 当前的主菜单
			AdminResource cSubmenu = null;// 当前的子菜单
			boolean isfind = false;
			boolean addFlg = true;
			// 依赖allmenu必须以ResourceTreeBM排序
			for (int i = 0; i < allmenu.size(); i++) {
				AdminResource resource = allmenu.get(i);
				if (isMainMenu(resource)) {
					if (isfind) {
						addFlg = false;
					} else {
						subMenus.clear();
						cMainmenu = resource;
					}
					// 设定主菜单链接为第一个子菜单链接
					if (i + 1 < allmenu.size() && !isMainMenu(allmenu.get(i + 1))) {
						resource.setResourceUrl(allmenu.get(i + 1).getResourceUrl());
						mainMenus.add(resource);
					}
				}
				// 用户当前选择子菜单
				if (requestURI.equals(resource.getResourceUrl()) && !isMainMenu(resource)) {
					cSubmenu = resource;
					isfind = true;
				}
				if (addFlg && !isMainMenu(resource)) {
					subMenus.add(resource);
				}
			}
			session.setAttribute("mainMenus", mainMenus);// 主菜单列表
			session.setAttribute("subMenus", subMenus);// 子菜单列表
			session.setAttribute("cMainmenu", cMainmenu);// 当前主菜单
			session.setAttribute("cSubmenu", cSubmenu);// 当前子菜单
		}

		return super.preHandle(request, response, handler);
	}

	private boolean isMainMenu(AdminResource adminResource) {
		return adminResource.getResourceTreeBM().endsWith("0000") && adminResource.getIsMenu() == Flg.ON;
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

}
