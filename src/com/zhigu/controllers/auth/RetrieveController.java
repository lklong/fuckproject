package com.zhigu.controllers.auth;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.EmailVerifyType;
import com.zhigu.common.constant.PhoneSendType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.servlet.ImageRandomCode;
import com.zhigu.model.EmailVerify;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IEmailService;
import com.zhigu.service.common.IPhoneSendService;
import com.zhigu.service.user.IUserService;

/**
 * 密码找回
 * 
 * @author zhouqibing 2014年8月12日下午2:25:05
 */
@Controller
@RequestMapping("/security/retrieve")
public class RetrieveController {

	private String SESSION_RETRIEVE_PHONE = "SESSION_RETRIEVE_PHONE";

	@Autowired
	private IUserService userService;
	@Autowired
	private IEmailService emailService;
	@Autowired
	private IPhoneSendService phoneSendService;

	/**
	 * 选择找回方式
	 * 
	 * @return
	 */
	@RequestMapping(value = "/step1", method = RequestMethod.GET)
	public String step1() {
		return "auth/retrieve/step1";
	}

	/**
	 * 选择找回方式
	 * 
	 * @return
	 */
	@RequestMapping(value = "/step1", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean step1(String username, String captcha, int type, ModelAndView mv, HttpServletRequest request) {
		if (!ImageRandomCode.verifyCaptcha(request, captcha)) {
			return new MsgBean(Code.FAIL, "验证码输入错误！", MsgLevel.ERROR);
		}

		if (type == 1) {
			UserAuth auth = userService.queryUserAuthByPhone(username);
			if (auth == null) {
				return new MsgBean(Code.FAIL, "该手机号未绑定同城帐号！", MsgLevel.ERROR);
			}
			SessionHelper.setAttribute(SESSION_RETRIEVE_PHONE, username);
			return phoneSendService.send(username, PhoneSendType.PASSWORD_RESET);
		} else if (type == 2) {
			return emailService.sendPasswordResetEmail(username);
		}
		return new MsgBean(Code.FAIL, "type error！", MsgLevel.ERROR);
	}

	/**
	 * 验证手机找回
	 * 
	 * @param username
	 * @param captcha
	 * @param type
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "/step2phone", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView step2_phone(ModelAndView mv) {
		String phone = (String) SessionHelper.getAttribute(SESSION_RETRIEVE_PHONE);
		mv.addObject("phone", phone);
		mv.setViewName("/auth/retrieve/step2-phone");
		return mv;
	}

	@RequestMapping(value = "/step2phone", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean step2_phone(String newPwd, String captcha) {
		String phone = (String) SessionHelper.getAttribute(SESSION_RETRIEVE_PHONE);
		MsgBean msg = phoneSendService.verify(phone, PhoneSendType.PASSWORD_RESET, captcha);
		if (msg.getCode() != Code.SUCCESS) {
			return msg;
		}
		return userService.resetLoginPwd(phone, newPwd);
	}

	/**
	 * 邮件重置密码
	 * 
	 * @param uid
	 * @param newPassword
	 * @return
	 */
	@RequestMapping(value = "/step2EmailTips", method = RequestMethod.GET)
	public ModelAndView step2EmailTips(String msg, ModelAndView mv) {
		mv.addObject("msg", msg);
		mv.setViewName("/auth/retrieve/step2-email-tips");
		return mv;
	}

	@RequestMapping(value = "/step2Email", method = RequestMethod.GET)
	public ModelAndView step2Email(String uid, ModelAndView mv) {
		EmailVerify ev = emailService.queryVerifyEmail(uid, EmailVerifyType.PASSWORD_RESET);
		if (ev == null) {
			mv.addObject("msg", "无效的链接，请重新发送验证邮件");
			mv.setViewName("/error/error-tips");
			return mv;
		}
		mv.addObject("uid", uid);
		mv.setViewName("/auth/retrieve/step2-email");
		return mv;
	}

	@RequestMapping(value = "/step2Email", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean step2Email(String uid, String newPwd) {
		return emailService.verifyPasswordResetEmail(uid, newPwd);
	}
}
