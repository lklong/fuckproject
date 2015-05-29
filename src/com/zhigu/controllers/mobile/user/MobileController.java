package com.zhigu.controllers.mobile.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;
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
	@Autowired
	private IPhoneSendService phoneSendService;

	/**
	 * 获取手机验证码
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/phoneCaptcha")
	@ResponseBody
	public MsgBean phoneCaptcha(String phone, int template) {
		if (StringUtil.isEmpty(phone)) {
			SessionUser sess = SessionHelper.getSessionUser();
			UserAuth auth = null;
			if (sess != null)
				auth = userService.queryUserAuthByUserID(sess.getUserID());
			if (auth != null)
				phone = auth.getPhone();
		}
		return phoneSendService.send(phone, template);
	}
}
