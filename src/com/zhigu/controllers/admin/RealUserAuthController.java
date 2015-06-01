package com.zhigu.controllers.admin;

import java.text.ParseException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.model.Admin;
import com.zhigu.model.RealUserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.admin.IAdminService;
import com.zhigu.service.user.IRealUserAuthService;

/**
 * 用户实名认证审核
 * 
 * @author Y.Z.X
 * @since 2015-05-28
 *
 */
@Controller
@RequestMapping("/admin/realUserAuth")
public class RealUserAuthController {
	@Autowired
	private IAdminService adminService;

	@Autowired
	private IRealUserAuthService realUserAuthService;

	/**
	 * 跳转到添加实名审核页面
	 * 
	 * @param userID
	 * @return
	 */
	@RequestMapping("/inner_info")
	public ModelAndView realUserAuthInfo(int userID) {
		ModelAndView mav = new ModelAndView();
		RealUserAuth realUserAuth = realUserAuthService.queryRealUserAuth(userID);
		mav.addObject("realUserAuth", realUserAuth);
		mav.addObject("userID", userID);
		mav.setViewName("/admin/member/inner_realUserAuthInfo");
		return mav;

	}

	/**
	 * 保存实名认证信息
	 * 
	 * @param realUserAuth
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("/addRealAuth")
	@ResponseBody
	public MsgBean addRealAuth(RealUserAuth realUserAuth, String cardValidityStr) throws ParseException {
		if (StringUtils.isNotBlank(cardValidityStr)) {
			realUserAuth.setCardValidity(DateUtils.parseDate(cardValidityStr, "yyyy-MM-dd"));
		}
		return realUserAuthService.saveRealUserAuth(realUserAuth);
	}

	/**
	 * 跳转到 实名认证审核页面
	 * 
	 * @param id
	 *            实名认证ID
	 * @return
	 */
	@RequestMapping("/realUserAuthStatus")
	public ModelAndView realUserAuthStatus(Integer userID) {
		ModelAndView mav = new ModelAndView();

		RealUserAuth realUserAuth = realUserAuthService.queryRealUserAuth(userID);
		Admin addAdmin = null;
		if (realUserAuth != null) {
			addAdmin = adminService.queryAdmin(realUserAuth.getAddAdminId());
		}

		mav.addObject("realUserAuth", realUserAuth);
		mav.addObject("userID", userID);
		mav.addObject("addAdmin", addAdmin);
		mav.setViewName("/admin/member/realUserAuthStatus");
		return mav;
	}

	/**
	 * 修改实名认证的状态
	 * 
	 * @param userID
	 *            用户ID
	 * @param status
	 *            状态
	 * @param rejectReason
	 *            驳回原因
	 * @return
	 */
	@RequestMapping("/updateRealUserAuthStatus")
	@ResponseBody
	public MsgBean updateRealUserAuthStatus(Integer userID, Integer status, String rejectReason) {
		return realUserAuthService.updateRealUserAuthStatus(userID, status, rejectReason);
	}

}
