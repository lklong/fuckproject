package com.zhigu.controllers.mobile.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.PhoneSendType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

/**
 * 安全中心
 * 
 * @author Y.Z.X
 * @since 2015-06-08
 */
@Controller
@RequestMapping("/mobile/security")
public class MobileSecurityController {

	@Autowired
	private IUserService userService;
	@Autowired
	private IPhoneSendService phoneSendService;
	@Autowired
	private IAccountService accountService;

	/**
	 * 获取验证码
	 * 
	 * @param userName
	 * @return
	 */
	@RequestMapping("/getResetPasswordCaptcha")
	@ResponseBody
	public MsgBean getCaptcha(String userName) {
		UserAuth auth = userService.queryUserAuthByPhone(userName);
		if (auth == null) {
			return new MsgBean(Code.FAIL, "该手机号未绑定同城帐号！", MsgLevel.ERROR);
		}
		return phoneSendService.send(userName, PhoneSendType.PASSWORD_RESET);
	}

	/**
	 * 重置密码
	 * 
	 * @param newPwd
	 * @return
	 */
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean resetPassword(String newPwd, String captcha, String phone) {
		MsgBean msg = phoneSendService.verify(phone, PhoneSendType.PASSWORD_RESET, captcha);
		if (msg.getCode() == Flg.ON)
			msg = userService.resetLoginPwd(phone, newPwd);
		return msg;
	}

	/**
	 * 是否有支付密码
	 * 
	 * @return
	 */
	@RequestMapping("/hasPaymentpwd")
	@ResponseBody
	public MsgBean hasPaymentpwd() {
		// MsgBean msg = new MsgBean();
		// UserInfo user =
		// userService.queryUserInfoById(SessionHelper.getSessionUser().getUserId());
		// if (user != null && !StringUtil.isEmpty(user.getPaymentPassword())) {
		// msg.setData(Flg.ON);
		// msg.setMsgBean(Code.SUCCESS, "已设置支付密码！", MsgLevel.NORMAL);
		// } else {
		// msg.setData(Flg.OFF);
		// msg.setMsgBean(Code.SUCCESS, "未设置支付密码！", MsgLevel.NORMAL);
		// }
		return null;
	}

	/**
	 * 修改支付密码
	 * 
	 * @param captcha
	 * @param paymentPwd
	 * @return
	 */
	@RequestMapping("/modifypaymentpwd")
	@ResponseBody
	public MsgBean modifyPaymentPwd(String captcha, String paymentPwd) {
		return accountService.updatePaypasswd(SessionHelper.getSessionUser().getUserId(), paymentPwd, captcha);
	}

	/**
	 * 检查是否绑定手机
	 * 
	 * @return
	 */
	@RequestMapping("/phone/isBinding")
	@ResponseBody
	public MsgBean isPhoneBinding() {
		MsgBean msg = new MsgBean();
		UserAuth userAuth = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserId());
		if (!StringUtil.isEmpty(userAuth.getPhone())) {
			msg.setData(Flg.ON);
			msg.setMsgBean(Code.SUCCESS, "手机已绑定！", MsgLevel.NORMAL);
		} else {
			msg.setData(Flg.OFF);
			msg.setMsgBean(Code.SUCCESS, "手机未绑定！", MsgLevel.NORMAL);
		}
		return msg;
	}
}
