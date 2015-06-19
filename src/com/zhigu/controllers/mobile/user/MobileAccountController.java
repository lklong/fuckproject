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
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.RechargeRecord;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
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

	/**
	 * 生成充值记录
	 * 
	 * @param payType
	 * @param money
	 * @return
	 */
	@RequestMapping("/create")
	@ResponseBody
	public MsgBean create(int payType, String money) {
		return accountService.saveRechargeRecord(payType, money);
	}

	/**
	 * 分页取得当前账号 充值信息
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping("/rechargelist")
	@ResponseBody
	public MsgBean rechargelist(PageBean<RechargeRecord> page) {
		accountService.queryRechargeRecord(SessionHelper.getSessionUser().getUserId(), page);
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(page);
	}

	/**
	 * 分页取得当前账号 收支信息
	 * 
	 * @param page
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@RequestMapping("/incomeAndExpensesDetail")
	@ResponseBody
	public MsgBean incomeAndExpensesDetail(PageBean<AccountDetail> page, Date startDate, Date endDate) {
		if (null != endDate) {
			Calendar c = Calendar.getInstance();
			c.setTime(endDate);
			c.set(Calendar.DATE, c.get(Calendar.DATE) + 1);
			endDate = c.getTime();
		}
		accountService.queryAccountDetailList(page, SessionHelper.getSessionUser().getUserId(), startDate, endDate);
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(page);
	}

	/**
	 * 取得当前账号 的 Account 信息
	 * 
	 * @return
	 */
	@RequestMapping("/account")
	@ResponseBody
	public MsgBean account() {
		Account account = accountService.queryAccountByUserID(SessionHelper.getSessionUser().getUserId());
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(account);

	}

	/**
	 * 账户信息收支明细详情
	 * 
	 * @param page
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/detail")
	@ResponseBody
	public MsgBean detail(PageBean<AccountDetail> page, Date startDate, Date endDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		page = (PageBean<AccountDetail>) incomeAndExpensesDetail(page, startDate, endDate).getData();
		Account account = (Account) account().getData();
		map.put("incomeAndExpensesDetail", page);
		map.put("account", account);
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(map);
	}

}
