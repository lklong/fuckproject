package com.zhigu.controllers.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.common.utils.sms.SMSTemplate;
import com.zhigu.common.utils.sms.SMSUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserService;

/**
 * 验证码发器
 * 
 * @author zhouqibing 2014年7月24日下午4:46:27
 */
@Controller
public class PhoneSMSController {
	@Autowired
	private IUserService userService;

	/**
	 * 发送手机验证码
	 * 
	 * @param phone
	 *            手机号
	 * @param v
	 * @param t
	 * @return
	 */
	@RequestMapping("/captcha/phone")
	@ResponseBody
	public MsgBean sendPhone(String phone, int t) {

		if (StringUtil.isEmpty(phone)) {
			SessionUser sess = SessionHelper.getSessionUser();
			UserAuth auth = null;
			if (sess != null)
				auth = userService.queryUserAuthByUserID(sess.getUserID());
			if (auth != null)
				phone = auth.getPhone();
		}
		if (StringUtil.isEmpty(phone)) {
			return new MsgBean(Code.FAIL, "手机号码获取失败！", MsgLevel.ERROR);
		}
		if (!VerifyUtil.phoneVerify(phone)) {
			return new MsgBean(Code.FAIL, "手机号码输入错误！", MsgLevel.ERROR);
		}

		if (!SMSUtil.isSend(phone)) {
			return new MsgBean(Code.FAIL, "验证码发送过于频繁，请稍候再试！", MsgLevel.ERROR);
		}

		SMSUtil.sendCaptcha(phone, SMSTemplate.getTemplate(t));
		return new MsgBean(Code.SUCCESS, "验证码已发送！请注意查收。", MsgLevel.NORMAL);
	}

	/**
	 * 发送app链接到手机
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/phoneSMS/sendAppAndrodLink")
	@ResponseBody
	public MsgBean sendAppAndrodLink(String phone) {
		if (!VerifyUtil.phoneVerify(phone)) {
			return new MsgBean(Code.FAIL, "手机号码输入错误！", MsgLevel.ERROR);
		}
		if (!SMSUtil.isSend(phone)) {
			return new MsgBean(Code.FAIL, "发送短信过于频繁，请稍候再试！", MsgLevel.ERROR);
		}
		SMSUtil.sendCaptcha(phone, "请求发送的智谷android手机APP下载地址："
		// + "http://www.zhiguw.com/app/down");
				+ ZhiguConfig.getValue(ZhiguConfig.APP_ANDROID_LINK));
		return new MsgBean(Code.SUCCESS, "链接地址已发送到手机，请注意查看！", MsgLevel.NORMAL);
	}
}
