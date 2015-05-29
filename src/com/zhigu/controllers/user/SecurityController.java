package com.zhigu.controllers.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.PhoneSendType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.Account;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IEmailService;
import com.zhigu.service.common.IPhoneSendService;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

/**
 * 用户安全设置
 * 
 * @author zhouqibing 2014年7月24日下午1:56:21
 */
@Controller
@RequestMapping("/user/security")
public class SecurityController {
	@Autowired
	private IUserService userService;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IEmailService emailService;
	@Autowired
	private IPhoneSendService phoneSendService;

	private static final String PHONE_VERIFY_KEY = "user_security&%67312sdfkey";

	/**
	 * 安全设置中心
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/center")
	public ModelAndView conter(ModelAndView mv) {
		int userID = SessionHelper.getSessionUser().getUserID();
		UserAuth auth = userService.queryUserAuthByUserID(userID);
		UserInfo info = userService.queryUserInfoById(userID);
		// mv.addObject("hasLoginPwd", StringUtil.isEmpty(auth.getPassword()) ?
		// "0" : "1");
		// mv.addObject("hasEmail", StringUtil.isEmpty(auth.getEmail()) ? "0" :
		// "1");
		// mv.addObject("hasPhone", StringUtil.isEmpty(auth.getPhone()) ? "0" :
		// "1");
		Account acc = accountService.queryAccountByUserID(userID);
		// 隐藏显示
		auth.setEmail(StringUtil.hideEmail(auth.getEmail()));
		auth.setPhone(StringUtil.hidePhone(auth.getPhone()));
		mv.addObject("account", acc);
		mv.addObject("auth", auth);
		mv.addObject("info", info);
		mv.setViewName("user/security/center");
		return mv;
	}

	/**
	 * 设置登录密码
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "/updateLoginpwd", method = RequestMethod.GET)
	public ModelAndView updateLoginpwd(ModelAndView mv) {
		mv.addObject("hasPwd", StringUtil.isEmpty(userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID()).getPassword()) ? "0" : "1");
		mv.setViewName("user/security/loginpwd");
		return mv;
	}

	/**
	 * 修改登录密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/updateLoginpwd", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean updateLoginpwd(String opwd, String npwd) {
		return userService.updateLoginPwd(opwd, npwd);
	}

	/**
	 * 手机绑定
	 * 
	 * @return
	 */
	@RequestMapping("phone")
	public ModelAndView phone(ModelAndView mv, String oldPhoneVerifyKey) {
		String phone = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID()).getPhone();
		if (StringUtils.isBlank(phone) || StringUtils.isNotBlank(oldPhoneVerifyKey)) {
			// 第二步，手机设置页面
			mv.addObject("oldPhoneVerifyKey", oldPhoneVerifyKey);
			mv.setViewName("user/security/phone_new_set");
		} else {
			// 去旧手机验证页
			mv.setViewName("redirect:/user/security/verifyOldPhone");
		}
		return mv;
	}

	@RequestMapping(value = "verifyOldPhone", method = RequestMethod.GET)
	public ModelAndView verifyOldPhone(ModelAndView mv) {
		// 去旧手机验证页
		String oldPhone = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID()).getPhone();
		mv.addObject("oldPhone", oldPhone);
		mv.setViewName("user/security/phone_old_verify");
		return mv;
	}

	/**
	 * 验证旧手机号
	 * 
	 * @return
	 */
	@RequestMapping(value = "/verifyOldPhone/send")
	@ResponseBody
	public MsgBean verifyOldPhoneSend() {
		int userId = SessionHelper.getSessionUser().getUserID();
		UserAuth auth = userService.queryUserAuthByUserID(userId);
		return phoneSendService.send(auth.getPhone(), PhoneSendType.PHONE_BIND_OLD_VERIFY);
	}

	@RequestMapping(value = "verifyOldPhone", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean verifyOldPhone(String captcha) {
		String oldPhone = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID()).getPhone();
		// 验证码
		MsgBean captchaMsg = phoneSendService.verify(oldPhone, PhoneSendType.PHONE_BIND_OLD_VERIFY, captcha);
		if (captchaMsg.getCode() != Code.SUCCESS) {
			return captchaMsg;
		}

		Map<String, String> data = new HashMap<String, String>();
		data.put("oldPhoneVerifyKey", Md5.convert(oldPhone + PHONE_VERIFY_KEY));
		return new MsgBean(Code.SUCCESS, "验证成功", MsgLevel.NORMAL).setData(data);
	}

	/**
	 * 修改手机
	 * 
	 * @return
	 */
	@RequestMapping("modifyPhone")
	@ResponseBody
	public MsgBean modifyPhone(String phone, String captcha, String oldPhoneVerifyKey) {
		MsgBean captchaMsg = phoneSendService.verify(phone, PhoneSendType.PHONE_BIND, captcha);
		if (captchaMsg.getCode() != Code.SUCCESS) {
			return captchaMsg;
		}
		String oldPhone = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID()).getPhone();
		if (StringUtils.isNotBlank(oldPhone)) {
			// 有旧手机，对旧手机验证key检查
			if (!Md5.convert(oldPhone + PHONE_VERIFY_KEY).equals(oldPhoneVerifyKey)) {
				return new MsgBean(Code.FAIL, "请重新进行旧手机验证", MsgLevel.ERROR);
			}
		}
		return userService.updatePhone(SessionHelper.getSessionUser().getUserID(), phone);
	}

	@RequestMapping("/newphone/send")
	@ResponseBody
	public MsgBean newphoneSend(String phone) {
		return phoneSendService.send(phone, PhoneSendType.PHONE_BIND);
	}

	/**
	 * 邮箱绑定
	 * 
	 * @return
	 */
	@RequestMapping("email")
	public ModelAndView email(ModelAndView mv) {
		mv.addObject("email", StringUtil.hideEmail(userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID()).getEmail()));
		mv.setViewName("user/security/email");
		return mv;
	}

	/**
	 * 将加密后的用户名，密码发送给用户邮箱
	 * 
	 * @param email
	 * @param password
	 */
	@RequestMapping("sendemail")
	@ResponseBody
	public MsgBean sendEmail(String email) {
		return emailService.sendBindEmail(email);
	}

	/**
	 * 支付密码修改
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/paymentpwd")
	public ModelAndView paymentPwd(ModelAndView mv) {
		UserAuth auth = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID());
		auth.setPhone(StringUtil.hidePhone(auth.getPhone()));
		mv.addObject("auth", auth);
		mv.setViewName("user/security/paymentpwd");
		return mv;
	}

	@RequestMapping("/savepayPasswd")
	@ResponseBody
	public MsgBean savePaymentPwd(String captcha, String paypasswd) {
		paypasswd = StringUtil.decryptBASE64(paypasswd);
		int userID = SessionHelper.getSessionUser().getUserID();
		return accountService.updatePaypasswd(userID, paypasswd, captcha);
	}

	@RequestMapping("/paypwd/update/phoneSend")
	@ResponseBody
	public MsgBean paypwdUpdatePhoneSend() {
		int userId = SessionHelper.getSessionUser().getUserID();
		UserAuth auth = userService.queryUserAuthByUserID(userId);
		return phoneSendService.send(auth.getPhone(), PhoneSendType.PAY_PASSWORD);
	}

	/**
	 * 实名认证
	 * 
	 * @return
	 */
	@RequestMapping("/realauth")
	public ModelAndView realAuth(ModelAndView mv) {
		mv.setViewName("user/security/realauth");
		return mv;
	}

	/**
	 * 绑定银行卡
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "/bank", method = RequestMethod.GET)
	public ModelAndView blank(ModelAndView mv) {
		int userId = SessionHelper.getSessionUser().getUserID();
		UserAuth auth = userService.queryUserAuthByUserID(userId);
		auth.setPhone(StringUtil.hidePhone(auth.getPhone()));
		mv.addObject("auth", auth);

		Account account = accountService.queryAccountByUserID(userId);
		mv.addObject("account", account);
		mv.setViewName("/user/security/bank");
		return mv;
	}

	@RequestMapping(value = "/bank", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean blank(String captcha, String bankNo, String bankCardMaster, String bankName) {
		return accountService.updateBankNo(bankNo, bankCardMaster, captcha, bankName);
	}

	@RequestMapping(value = "/bank/phone/send")
	@ResponseBody
	public MsgBean blank() {
		int userId = SessionHelper.getSessionUser().getUserID();
		UserAuth auth = userService.queryUserAuthByUserID(userId);
		return phoneSendService.send(auth.getPhone(), PhoneSendType.BANK_BIND);
	}
}