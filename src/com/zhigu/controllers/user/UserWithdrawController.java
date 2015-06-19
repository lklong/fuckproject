package com.zhigu.controllers.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Common;
import com.zhigu.common.constant.enumconst.WithdrawStatus;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.Account;
import com.zhigu.model.PageBean;
import com.zhigu.model.Withdraw;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IWithdrawService;

/**
 * 提现申请
 * 
 * @ClassName: WithdrawController
 * @author hesimin
 * @date 2015年4月27日 下午4:17:53
 *
 */
@Controller
@RequestMapping("/user/withdraw")
public class UserWithdrawController {
	@Autowired
	private IWithdrawService withdrawService;
	@Autowired
	private IAccountService accountService;

	/**
	 * 提现记录
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView withdrawList(ModelAndView mv, PageBean page, Integer status) {
		withdrawService.queryWithdraw(page, SessionHelper.getSessionUser().getUserId(), status);
		List<Withdraw> list = page.getDatas();
		// 信息隐藏处理
		if (list != null && !list.isEmpty()) {
			for (Withdraw w : list) {
				w.setToAccount("***************" + w.getToAccount().substring(w.getToAccount().length() - 4));
				if (StringUtil.isEmpty(w.getToAccountMaster())) {
					w.setToAccountMaster(Common.BLANK);
				} else {
					w.setToAccountMaster("*" + w.getToAccountMaster().substring(1));
				}
			}
		}
		mv.addObject("withdrawStatus", WithdrawStatus.values());
		mv.addObject("currStatus", status);
		mv.addObject("page", page);
		mv.setViewName("/user/withdraw/list");
		return mv;
	}

	/**
	 * 提现申请页面
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public ModelAndView withdrawGet(ModelAndView mv) {
		Account acc = accountService.queryAccountByUserID(SessionHelper.getSessionUser().getUserId());
		mv.addObject("account", acc);
		mv.setViewName("/user/withdraw/add");
		return mv;
	}

	/**
	 * 保存提现申请
	 * 
	 * @return
	 */
	@RequestMapping(value = "add", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean withdrawPost(String payPasswd, String money) {
		payPasswd = StringUtil.decryptBASE64(payPasswd);
		return withdrawService.saveWithdraw(payPasswd, money);
	}

}
