package com.zhigu.controllers.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.admin.IAdminService;

/**
 * 
 * 
 * AuthController
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
@Controller
@RequestMapping("/admin")
public class AuthController {
	@Autowired
	private IAdminService adminService;

	/**
	 * 
	 * loginPage(跳转到后台用户登陆页) (适用于后台登陆)
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @exception
	 * @since 1.0.0
	 */
	@RequestMapping("")
	public String loginPage() {
		if (SessionHelper.getSessionAdmin() != null) {
			return "redirect:/admin/index";
		}
		return "redirect:/admin/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView loginInit(ModelAndView mv) {
		mv.setViewName("/admin/login");
		return mv;
	}

	/**
	 * 
	 * login(后台用户登陆) (适用于后台登陆)
	 * 
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @exception
	 * @since 1.0.0
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean login(String username, String password) {
		/*
		 * if(checkcode == null || checkcode.equals("")){
		 * request.setAttribute("errorMsg", "请填写验证码"); return new
		 * ModelAndView("admin/login"); }
		 */
		/*
		 * if(!CaptchaServiceSingleton.getInstance().validateResponseForID(
		 * request.getSession().getId(), checkcode)){
		 * request.setAttribute("errorMsg", "验证码填写错误"); return new
		 * ModelAndView("../../login"); }
		 */
		// mv.setViewName("redirect:/admin/index");
		password = StringUtil.decryptBASE64(password);
		return adminService.login(username, password);
	}

	/**
	 * 
	 * logout(用户退出) (适用于用户退出)
	 * 
	 * @param request
	 * @param response
	 * @return String
	 * @exception
	 * @since 1.0.0
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		return new ModelAndView("redirect:/admin");
	}

	/**
	 * 修改密码(用于后台管理员)
	 * 
	 * @param oldPwd
	 * @param newPwd
	 * @return
	 */
	@RequestMapping("/updatePwd")
	@ResponseBody
	public MsgBean updatePwd(HttpServletRequest request, String oldPwd, String newPwd) {
		return adminService.updateAdminPwdByID(request, oldPwd, newPwd);
	}

}
