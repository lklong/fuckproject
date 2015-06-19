package com.zhigu.controllers.auth;

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
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IPhoneSendService;
import com.zhigu.service.user.IUserService;

/**
 * 用户注册
 * 
 * @ClassName: RegisterController
 * @author hesimin
 * @date 2015年5月22日 下午4:26:32
 *
 */
@Controller
@RequestMapping("/register")
public class RegisterController {

	@Autowired
	private IUserService userService;
	@Autowired
	private IPhoneSendService phoneSendService;

	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView register(ModelAndView mv) {
		if (SessionHelper.getSessionUser() != null) {
			mv.setViewName("redirect:/user/home");
		} else {
			mv.setViewName("auth/register/register");
		}
		return mv;
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean register(String username, String encodePwd, String captcha) {
		String password = StringUtil.decryptBASE64(encodePwd);
		MsgBean captchaMsg = phoneSendService.verify(username, PhoneSendType.PHONE_REGISTER, captcha);
		if (captchaMsg.getCode() != Code.SUCCESS) {
			return captchaMsg;
		}
		return userService.saveUserAuth(username, password);
	}

	/**
	 * 验证手机号
	 * 
	 * @param phone
	 * @return MsgBean
	 */
	@RequestMapping("/verifyPhone")
	@ResponseBody
	public MsgBean verifyPhone(String phone) {
		UserAuth auth = userService.queryUserAuthByPhone(phone);
		if (auth != null) {
			return new MsgBean(Code.FAIL, "手机已被注册使用！", MsgLevel.WARNING);
		}
		return new MsgBean(Code.SUCCESS, "ok!", MsgLevel.NORMAL);
	}

	/**
	 * 手机注册短信
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping("/phone/send")
	@ResponseBody
	public MsgBean phoneSend(String phone) {
		UserAuth auth = userService.queryUserAuthByPhone(phone);
		if (auth != null) {
			return new MsgBean(Code.FAIL, "手机已被注册使用！", MsgLevel.WARNING);
		}
		return phoneSendService.send(phone, PhoneSendType.PHONE_REGISTER);
	}

}
