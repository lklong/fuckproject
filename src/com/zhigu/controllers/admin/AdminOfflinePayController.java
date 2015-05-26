package com.zhigu.controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.model.Offlinetransferaccounts;
import com.zhigu.model.PageBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

@Controller
@RequestMapping("/admin/offlinePay")
public class AdminOfflinePayController {

	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;

	@RequestMapping("offlinePayLook")
	public ModelAndView offlinePayLook(ModelAndView mv, PageBean<Offlinetransferaccounts> pageBean) {
		mv.setViewName("admin/offlinePay/offlinePayLook");
		// List<Offlinetransferaccounts> offlinetransferaccountsList =
		// accountService.queryofflinePayByManagerList(pageBean);

		// mv.addObject("offlinetransferaccountsList",
		// offlinetransferaccountsList);
		mv.addObject("page", pageBean);
		return mv;
	}
}
