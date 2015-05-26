package com.zhigu.controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.enumconst.AuthStatus;
import com.zhigu.model.RealUserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAuthService;
import com.zhigu.service.user.IUserService;

/**
 * 用户认证审核相关
 * 
 * @author HeSiMin
 * @date 2014年9月5日
 *
 */
@Controller
@RequestMapping("/admin/auth")
public class UserAuthController {
	@Autowired
	private IUserService userService;
	@Autowired
	private IAuthService authService;

	@RequestMapping("/realUser/inner_info")
	public ModelAndView realUserAuthInfo(ModelAndView mv, int userID) {
		RealUserAuth realUserAuth = userService.queryRealUserAuth(userID);
		mv.addObject("realUserAuth", realUserAuth);
		mv.setViewName("/admin/member/inner_realUserAuthInfo");
		return mv;

	}

	@RequestMapping("/realUser/pass")
	@ResponseBody
	public MsgBean realUserAuthPass(int userID) {
		RealUserAuth old = userService.queryRealUserAuth(userID);
		old.setApproveState(AuthStatus.PASS.getValue());
		old.setApproveUser(SessionHelper.getSessionAdmin().getId());
		return userService.updateRealUserAuth(old);
	}

	@RequestMapping("/realUser/fail")
	@ResponseBody
	public MsgBean realUserAuthFail(int userID, String rejectReason) {
		RealUserAuth old = userService.queryRealUserAuth(userID);
		old.setApproveState(AuthStatus.REJECT.getValue());
		old.setRejectReason(rejectReason);
		return userService.updateRealUserAuth(old);
	}

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView mv) {
		mv.setViewName("admin/auth/index");
		return mv;
	}

}
