package com.zhigu.controllers.mobile.user;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.RechargeRecord;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IUserPointService;
import com.zhigu.service.user.IUserService;

/**
 * 帐户信息
 * 
 * @author zhangyukun 2014年11月25日
 */
@Controller
@RequestMapping("/mobile/user/acc")
public class MobileAccountController {

	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IUserPointService userPointService;

	/* 分页取得当前账号 充值信息 */
	@RequestMapping("/rechargelist")
	@ResponseBody
	public PageBean<RechargeRecord> rechargelist(PageBean<RechargeRecord> page) {
		int userID = SessionHelper.getSessionUser().getUserID();
		accountService.queryRechargeRecord(userID, page);
		return page;
	}

	/*
	 * 分页取得当前账号 收支信息
	 */
	@RequestMapping("/incomeAndExpensesDetail")
	@ResponseBody
	public PageBean<AccountDetail> incomeAndExpensesDetail(PageBean<AccountDetail> page, Date startDate, Date endDate) {
		int userID = SessionHelper.getSessionUser().getUserID();
		if (null != endDate) {
			Calendar c = Calendar.getInstance();
			c.setTime(endDate);
			c.set(Calendar.DATE, c.get(Calendar.DATE) + 1);
			endDate = c.getTime();
		}

		accountService.queryAccountDetailList(page, userID, startDate, endDate);
		return page;
	}

	/*
	 * 取得当前账号 的 Account 信息
	 */
	@RequestMapping("/account")
	@ResponseBody
	public Account account() {
		int userID = SessionHelper.getSessionUser().getUserID();
		Account account = accountService.queryAccountByUserID(userID);
		return account;
	}

	@RequestMapping("/detail")
	@ResponseBody
	public Map<String, Object> detail(PageBean<AccountDetail> page, Date startDate, Date endDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		page = incomeAndExpensesDetail(page, startDate, endDate);
		Account account = account();

		map.put("incomeAndExpensesDetail", page);
		map.put("account", account);
		return map;
	}

}
