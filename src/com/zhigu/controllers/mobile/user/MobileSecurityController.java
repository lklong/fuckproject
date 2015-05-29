package com.zhigu.controllers.mobile.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

/**
 * 用户安全相关
 * 
 * @author HeSiMin
 * @date 2014年10月13日
 *
 */
@Controller
@RequestMapping("/mobile/user/security")
public class MobileSecurityController {
	@Autowired
	private IUserService userService;
	@Autowired
	private IAccountService accountService;

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
		// userService.queryUserInfoById(SessionHelper.getSessionUser().getUserID());
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
		int userID = SessionHelper.getSessionUser().getUserID();
		return accountService.updatePaypasswd(userID, paymentPwd, captcha);
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
		UserAuth userAuth = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID());
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
