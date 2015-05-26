package com.zhigu.controllers.mobile.user;

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
import com.zhigu.common.utils.sms.SMSTemplate;
import com.zhigu.common.utils.sms.SMSUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserService;

/**
 * 
 * @author HeSiMin
 * @date 2014年10月13日
 *
 */
@Controller
@RequestMapping("/mobile")
public class MobileController {
	@Autowired
	private IUserService userService;

	/**
	 * 获取手机验证码
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/phoneCaptcha")
	@ResponseBody
	public MsgBean phoneCaptcha(String phone, int template) {
		MsgBean msg = new MsgBean();

		if (StringUtil.isEmpty(phone)) {
			SessionUser sess = SessionHelper.getSessionUser();
			UserAuth auth = null;
			if (sess != null)
				auth = userService.queryUserAuthByUserID(sess.getUserID());
			if (auth != null)
				phone = auth.getPhone();
		}
		if (StringUtil.isEmpty(phone)) {
			msg.setMsgBean(Code.FAIL, "手机号码获取失败！", MsgLevel.ERROR);
			return msg;
		}
		if (!VerifyUtil.phoneVerify(phone)) {
			msg.setMsgBean(Code.FAIL, "手机号码输入错误！", MsgLevel.ERROR);
			return msg;
		}

		if (!SMSUtil.isSend(phone)) {
			msg.setMsgBean(Code.FAIL, "验证码发送过于频繁，请稍候再试！", MsgLevel.ERROR);
			return msg;
		}

		SMSUtil.sendCaptcha(phone, SMSTemplate.getTemplate(template));

		msg.setMsgBean(Code.SUCCESS, "验证码已发送！请注意查收！", MsgLevel.NORMAL);
		return msg;
	}
}
