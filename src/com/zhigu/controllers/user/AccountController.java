package com.zhigu.controllers.user;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.DateUtil;
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
 * @author zhouqibing 2014年7月22日下午1:33:53
 */
@Controller
@RequestMapping("/user/acc")
public class AccountController {

	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IUserPointService userPointService;

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
		int userID = SessionHelper.getSessionUser().getUserID();
		mv.addObject("auth", userService.queryUserAuthByUserID(userID));
		mv.addObject("userInfo", userService.queryUserInfoById(userID));
		mv.addObject("acc", accountService.queryAccountByUserID(userID));
		Account account = accountService.queryAccountByUserID(userID);
		mv.addObject("hasPayPWD", StringUtils.isNotBlank(account.getPayPasswd()));
		return mv;
	}

	@RequestMapping("/rechargelist")
	public ModelAndView rechargelist(PageBean<RechargeRecord> page, ModelAndView mv) {
		int userID = SessionHelper.getSessionUser().getUserID();
		accountService.queryRechargeRecord(userID, page);
		mv.addObject("page", page);
		mv.setViewName("/user/acc/rechargelist");
		return mv;
	}

	// 收支明细
	@RequestMapping("/detail")
	public ModelAndView detail(PageBean<AccountDetail> page, Integer month, Date startDate, Date endDate, ModelAndView mv) {
		int userID = SessionHelper.getSessionUser().getUserID();
		// 账户冻结和可用金额的计算
		Account acc = accountService.queryAccountByUserID(SessionHelper.getSessionUser().getUserID());
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

	/**
	 * 展示提成记录
	 * 
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping("/showCommissionRecord")
	public ModelAndView showCommissionRecord(ModelAndView mv, PageBean page) {
		throw new ServiceException("推广提成已停！");
		// mv.setViewName("user/acc/commissiondetail");
		// page.addParas("userID", SessionHelper.getSessionUser().getUserID());
		// mv.addObject("commissionRecords",
		// promotionService.queryCommissionRecordByPage(page));
		// mv.addObject("page", page);
		// return mv;
	}

}
