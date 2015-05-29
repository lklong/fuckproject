package com.zhigu.controllers.mobile.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.constant.PhoneSendType;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;
import com.zhigu.service.user.IUserService;

/**
 * 手机注册
 * 
 * @author HeSiMin
 * @date 2014年10月9日
 *
 */
@Controller
@RequestMapping("/mobile/register")
public class MobileRegisterController {

	@Autowired
	private IUserService userService;
	@Autowired
	private IPhoneSendService phoneSendService;

	@RequestMapping("/verify")
	@ResponseBody
	public MsgBean goRegisterInput(@RequestParam String phone, @RequestParam String password, @RequestParam String captcha, @RequestParam(required = false) String recommendUserID) {
		// 生成帐号
		// int userId = userService.saveUserAuth(phone, password);
		return null;
	}

	/**
	 * 获取手机验证码
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/phoneCaptcha")
	@ResponseBody
	public MsgBean phoneCaptcha(String phone) {
		return phoneSendService.send(phone, PhoneSendType.PHONE_REGISTER);
	}

}
