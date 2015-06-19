package com.zhigu.controllers.user;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.RechargeRecord;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserService;

/**
 * 帐户信息
 * 
 * @author zhouqibing 2014年7月22日下午1:33:53
 */
@Controller
@RequestMapping("/user/acc")
public class AccountController {

	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;

	@RequestMapping("/pay")
	public String pay() {
		return "user/acc/pay";
	}

	/**
	 * 帐户信息
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView account(ModelAndView mv) {
		mv.setViewName("/user/acc/account");
		int userID = SessionHelper.getSessionUser().getUserId();
		mv.addObject("auth", userService.queryUserAuthByUserID(userID));
		mv.addObject("userInfo", userService.queryUserInfoById(userID));
		mv.addObject("acc", accountService.queryAccountByUserID(userID));
		Account account = accountService.queryAccountByUserID(userID);
		mv.addObject("hasPayPWD", StringUtils.isNotBlank(account.getPayPasswd()));
		return mv;
	}

	@RequestMapping("/rechargelist")
	public ModelAndView rechargelist(PageBean<RechargeRecord> page, ModelAndView mv) {
		int userID = SessionHelper.getSessionUser().getUserId();
		accountService.queryRechargeRecord(userID, page);
		mv.addObject("page", page);
		mv.setViewName("/user/acc/rechargelist");
		return mv;
	}

	// 收支明细
	@RequestMapping("/detail")
	public ModelAndView detail(PageBean<AccountDetail> page, Integer month, String startDateStr, String endDateStr, ModelAndView mv) throws ParseException {
		int userID = SessionHelper.getSessionUser().getUserId();
		Date startDate = null;
		Date endDate = null;
		if (StringUtils.isNotBlank(startDateStr))
			startDate = DateUtils.parseDate(startDateStr, "yyyy-MM-dd");
		if (StringUtils.isNotBlank(endDateStr))
			endDate = DateUtils.parseDate(endDateStr, "yyyy-MM-dd");

		// 账户冻结和可用金额的计算
		Account acc = accountService.queryAccountByUserID(SessionHelper.getSessionUser().getUserId());
		mv.addObject("userName", SessionHelper.getSessionUser().getUsername());
		mv.addObject("acc", acc);

		mv.addObject("month", month);
		mv.addObject("startDate", startDate);
		mv.addObject("endDate", endDate);

		// 初始化的时候list里面保存最近一个月的交易记录startDate:当前时间减去一个月,endDate:当前时间
		if (month != null) {
			Date date = new Date();
			if (month == 1) {// 最近一月
				startDate = DateUtil.addMonth(date, -1);
			} else if (month == 3) {// 最近三月
				startDate = DateUtil.addMonth(date, -3);
			} else if (month == 6) {// 最近半年
				startDate = DateUtil.addMonth(date, -6);
			}
			endDate = date;
			mv.addObject("startDate", null);
			mv.addObject("endDate", null);
		}

		// 支出详情list
		List<AccountDetail> list = accountService.queryAccountDetailList(page, userID, startDate, endDate);
		mv.addObject("list", list);
		mv.addObject("page", page);

		mv.setViewName("user/acc/detail");
		return mv;
	}

}
