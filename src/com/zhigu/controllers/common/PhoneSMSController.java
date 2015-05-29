package com.zhigu.controllers.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.constant.PhoneSendType;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;
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
	@Autowired
	private IPhoneSendService phoneSendService;

	/**
	 * 发送app链接到手机
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/phoneSMS/sendAppAndrodLink")
	@ResponseBody
	public MsgBean sendAppAndrodLink(String phone) {
		return phoneSendService.send(phone, PhoneSendType.APP_LINK);
	}
}
