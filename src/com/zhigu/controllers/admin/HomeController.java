package com.zhigu.controllers.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.service.admin.IStatService;
/**
 * 
 * 
 * 首页
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
public class HomeController {
	@Autowired
	private IStatService statService;
	/**
	 * 
	 * login(后台用户登陆)
	 * (适用于后台登陆)
	 * @param request
	 * @param response
	 * @return 
	 * ModelAndView
	 * @exception 
	 * @since  1.0.0
	 */
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest request,HttpServletResponse response,ModelAndView mv){
		Map<String, Object> statMember = statService.statMember();
		Map<String, Object> statOrder = statService.statOrder();
		Map<String, Object> statRecharge = statService.statRecharge();
		Map<String, Object> statCommodity = statService.statCommodity();
		
		mv.addObject("statMember", statMember);
		mv.addObject("statOrder", statOrder);
		mv.addObject("statRecharge", statRecharge);
		mv.addObject("statCommodity", statCommodity);
		mv.setViewName("admin/index");
		return mv;
	}
}
