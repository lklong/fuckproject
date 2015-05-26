package com.zhigu.controllers.supplier;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

/**
 * 广告管理
 * 
 * @author zhigu014
 *
 */
@Controller
@RequestMapping("/supplier/ad")
public class AdController {
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;

	private static final Logger logger = Logger.getLogger(AdController.class);
	private static final String TEMP_FOLDER = "temp/ad/";

	/**
	 * 跳转到智谷首页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		return "supplier/ad/index";
	}

	/**
	 * 跳到广告上传页面
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "uploadAdInfo")
	public ModelAndView uploadAdInfo(int adid) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("adid", adid);
		mv.setViewName("supplier/ad/uploadAdInfo");
		return mv;
	}

	/**
	 * 跳到广告上传页面
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "seeAdInfo")
	public ModelAndView seeAdInfo(int id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("id", id);
		mv.addObject("status", "see");
		mv.setViewName("supplier/ad/uploadAdInfo");
		return mv;
	}

	/**
	 * 支付成功跳转页面
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "paysuccess")
	public ModelAndView paysuccess(Integer id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("id", id);
		mv.setViewName("supplier/ad/paysuccess");
		return mv;
	}

	/**
	 * 查看广告订单记录
	 * 
	 * @return
	 */
	@RequestMapping("adlog")
	public ModelAndView adlog() {
		int userID = SessionHelper.getSessionUser().getUserID();
		ModelAndView mv = new ModelAndView();
		mv.addObject("userID", userID);
		mv.setViewName("supplier/ad/adlog");
		return mv;
	}

	/**
	 * 跳转到订单支付页面
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("adpay")
	public ModelAndView adpay(Integer id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("id", id);
		mv.setViewName("supplier/ad/adpay");
		return mv;
	}

}