package com.zhigu.controllers.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.captcha.CaptchaUtil;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
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

	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView goRegister(ModelAndView mv, @RequestParam(required = false) String recommendUserID) {
		if (SessionHelper.getSessionUser() != null) {
			mv.setViewName("redirect:/user/home");
		} else {
			mv.setViewName("auth/register/register");
			mv.addObject("recommendUserID", recommendUserID);
		}
		return mv;
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean goRegister(String username, String encodePwd, String captcha) {
		String password = StringUtil.decryptBASE64(encodePwd);
		if (!CaptchaUtil.verify(username, captcha)) {
			return new MsgBean(Code.FAIL, "手机验证码错误！", MsgLevel.ERROR);
		}
		MsgBean msg = userService.saveUserAuth(username, password);
		if (msg.getCode() == Code.SUCCESS) {
			CaptchaUtil.remove(username);
		}
		return msg;
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

}
