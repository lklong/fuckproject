package com.zhigu.controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.constant.enumconst.WithdrawStatus;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IWithdrawService;

/**
 * 提现申请处理
 * 
 * @ClassName: AdminWithdraw
 * @author hesimin
 * @date 2015年4月30日 上午11:00:57
 *
 */
@Controller
@RequestMapping("/admin/accounting/withdraw")
public class AdminWithdrawController {
	@Autowired
	private IWithdrawService withdrawService;

	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView init(ModelAndView mv, PageBean page, Integer userId, String userPhone, Integer status, String bankNo, String bankCardMaster) {
		withdrawService.adminQueryWithdraw(page, userId, userPhone, status, bankNo, bankCardMaster);
		mv.addObject("queryStatus", status);
		mv.addObject("queryBankNo", bankNo);
		mv.addObject("queryBankCardMaster", bankCardMaster);
		mv.addObject("queryUserId", userId);
		mv.addObject("queryUserPhone", userPhone);
		mv.addObject("withdrawStatusAll", WithdrawStatus.values());
		mv.addObject("page", page);
		mv.setViewName("/admin/accounting/withdraw");
		return mv;
	}

	/**
	 * 提现申请受理
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/accept")
	@ResponseBody
	public MsgBean accept(Long id) {
		return withdrawService.handlerWithdrawAccept(id);
	}

	/**
	 * 提现申请成功
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/success")
	@ResponseBody
	public MsgBean success(Long id) {
		return withdrawService.handlerWithdrawSuccess(id);
	}

	/**
	 * 提现申请失败
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/fail")
	@ResponseBody
	public MsgBean fail(Long id) {
		return withdrawService.handlerWithdrawFail(id, null);
	}
}
