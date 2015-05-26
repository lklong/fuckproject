package com.zhigu.controllers.mobile.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.sms.SMSTemplate;
import com.zhigu.common.utils.sms.SMSUtil;
import com.zhigu.model.dto.MsgBean;
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
	private static final String USERNAME = "username";
	private static final String PASSWORD = "password";
	private static final String RECOMMEND_USER_ID = "recommendUserID";

	@Autowired
	private IUserService userService;

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
		MsgBean msg = new MsgBean();
		if (VerifyUtil.phoneVerify(phone)) {
			if (userService.queryUserAuthByPhone(phone) != null) {
				msg.setMsgBean(Code.FAIL, "手机号码已被注册使用！", MsgLevel.ERROR);
				return msg;
			}
		} else {
			msg.setMsgBean(Code.FAIL, "手机号错误！", MsgLevel.ERROR);
			return msg;
		}
		if (!SMSUtil.isSend(phone)) {
			msg.setMsgBean(Code.FAIL, "验证码发送过于频繁，请稍候再试！", MsgLevel.ERROR);
			return msg;
		}
		SMSUtil.sendCaptcha(phone, SMSTemplate.getTemplate(1));
		msg.setMsgBean(Code.SUCCESS, "手机验证码已发送！", MsgLevel.NORMAL);
		return msg;
	}

}
