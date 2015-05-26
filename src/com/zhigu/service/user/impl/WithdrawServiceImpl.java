package com.zhigu.service.user.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SequenceConstant;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.enumconst.DealType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.constant.enumconst.WithdrawStatus;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.Sequence;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.mapper.AccountDetailMapper;
import com.zhigu.mapper.AccountMapper;
import com.zhigu.mapper.SystemAccountMapper;
import com.zhigu.mapper.WithdrawMapper;
import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.SystemAccount;
import com.zhigu.model.Withdraw;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IWithdrawService;

@Service
public class WithdrawServiceImpl implements IWithdrawService {
	@Autowired
	private WithdrawMapper withdrawMapper;
	@Autowired
	private SystemAccountMapper systemAccountMapper;
	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private AccountDetailMapper accountDetailMapper;

	@Override
	public MsgBean saveWithdraw(String payPasswd, String money) {
		MsgBean verifyPaypasswd = accountService.verifyPaypasswd(payPasswd);
		if (verifyPaypasswd.getCode() != Code.SUCCESS) {
			return verifyPaypasswd;
		}

		// 资金check
		if (!VerifyUtil.isMoney(money)) {
			return new MsgBean(Code.FAIL, "金额格式格式错误", MsgLevel.ERROR);
		}
		int userId = SessionHelper.getSessionUser().getUserID();
		Account userAcc = accountMapper.queryAccountByUserId(userId);
		BigDecimal withdrawMoney = new BigDecimal(money);
		if (withdrawMoney.floatValue() > userAcc.getNormalMoney().floatValue()) {
			return new MsgBean(Code.FAIL, "账户金额不足", MsgLevel.ERROR);
		}
		String blankNo = userAcc.getBankNo();
		if (StringUtil.isEmpty(blankNo)) {
			return new MsgBean(Code.FAIL, "未绑定银行卡，<a href='/user/security/bank' style='color:red'>去绑定 >> </a>", MsgLevel.ERROR);
		}
		// 账户明细
		String sno = Sequence.generateSeq(SequenceConstant.FLOW);
		AccountDetail accDetail = new AccountDetail();
		accDetail.setSno(sno);
		accDetail.setUserId(userAcc.getUserId());
		accDetail.setIncomeFlag(false);
		accDetail.setDealType(DealType.USER_WITHDRAW.getValue());
		accDetail.setOriginalMoney(userAcc.getNormalMoney());
		accDetail.setDealMoney(withdrawMoney);
		accDetail.setDealMatter(DealType.USER_WITHDRAW.getName() + "【银行卡尾号：" + blankNo.substring(blankNo.length() - 4) + "】");
		accDetail.setDealTime(new Date());
		int accDetailRow = accountDetailMapper.insert(accDetail);
		if (accDetailRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 账户金额变动
		userAcc.setNormalMoney(userAcc.getNormalMoney().subtract(withdrawMoney));
		int userAccRow = accountMapper.updateByPrimaryKey(userAcc);
		if (userAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 资金到系统账户托管
		SystemAccount systemAcc = new SystemAccount();
		systemAcc.setCreateTime(new Date());
		systemAcc.setSno(sno);
		systemAcc.setMoney(withdrawMoney);
		systemAcc.setIncomeFlag(true);
		systemAcc.setUserId(userId);
		systemAcc.setMatter(DealType.USER_WITHDRAW.getName());
		int systemAccRow = systemAccountMapper.insert(systemAcc);
		if (systemAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 保存提现申请
		Withdraw withdraw = new Withdraw();
		withdraw.setCreateTime(new Date());
		withdraw.setUserId(userId);
		withdraw.setMoney(withdrawMoney);
		withdraw.setBankName(userAcc.getBankName());
		withdraw.setToAccountMaster(userAcc.getBankCardMaster());
		withdraw.setToAccount(userAcc.getBankNo());
		withdraw.setStatus(WithdrawStatus.APPLY_FOR.getValue());
		int withdrawRow = withdrawMapper.insert(withdraw);
		if (withdrawRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "提现申请成功", MsgLevel.NORMAL);
	}

	@Override
	public PageBean queryWithdraw(PageBean page, Integer userId, Integer status) {
		List<Withdraw> list = withdrawMapper.queryWithdrawByPage(page, userId, status);
		page.setDatas(list);
		return page;
	}

	@Override
	public MsgBean handlerWithdrawSuccess(Long id) {
		Withdraw withdraw = withdrawMapper.selectByPrimaryKey(id);
		if (withdraw == null) {
			return new MsgBean(Code.FAIL, "失败，未找到该提现申请", MsgLevel.ERROR);
		}
		if (withdraw.getStatus() != WithdrawStatus.ACCEPT.getValue()) {
			return new MsgBean(Code.FAIL, "失败，该提现申请状态错误", MsgLevel.ERROR);
		}
		if (withdraw.getHandlerAdminId() != SessionHelper.getSessionAdmin().getId()) {
			return new MsgBean(Code.FAIL, "失败，你不是该提现申请的受理人", MsgLevel.ERROR);
		}

		withdraw.setStatus(WithdrawStatus.SUCCESS.getValue());
		withdraw.setEndTime(new Date());
		int withdrawRow = withdrawMapper.updateByPrimaryKey(withdraw);
		if (withdrawRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		// 资金到系统账户扣除
		SystemAccount systemAcc = new SystemAccount();
		systemAcc.setCreateTime(new Date());
		systemAcc.setSno(Sequence.generateSeq(SequenceConstant.FLOW));
		systemAcc.setMoney(withdraw.getMoney());
		systemAcc.setIncomeFlag(false);
		systemAcc.setUserId(withdraw.getUserId());
		systemAcc.setMatter(DealType.USER_WITHDRAW.getName());
		int systemAccRow = systemAccountMapper.insert(systemAcc);
		if (systemAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "处理成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean handlerWithdrawAccept(Long id) {
		Withdraw withdraw = withdrawMapper.selectByPrimaryKey(id);
		if (withdraw == null) {
			return new MsgBean(Code.FAIL, "失败，未找到该提现申请", MsgLevel.ERROR);
		}
		if (withdraw.getStatus() != WithdrawStatus.APPLY_FOR.getValue()) {
			return new MsgBean(Code.FAIL, "失败，该提现申请状态错误", MsgLevel.ERROR);
		}

		withdraw.setHandlerAdminId(SessionHelper.getSessionAdmin().getId());
		withdraw.setAcceptTime(new Date());
		withdraw.setStatus(WithdrawStatus.ACCEPT.getValue());
		int withdrawRow = withdrawMapper.updateByPrimaryKey(withdraw);
		if (withdrawRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "处理成功", MsgLevel.NORMAL);
	}

	@Override
	public PageBean<Withdraw> adminQueryWithdraw(PageBean<Withdraw> page, Integer userId, String userPhone, Integer status, String bankNo, String bankCardMaster) {
		List<Withdraw> list = withdrawMapper.adminQueryWithdrawByPage(page, userId, userPhone, status, bankNo, bankCardMaster);
		page.setDatas(list);
		return page;
	}

	@Override
	public MsgBean handlerWithdrawFail(Long id, String failReason) {
		Withdraw withdraw = withdrawMapper.selectByPrimaryKey(id);
		if (withdraw == null) {
			return new MsgBean(Code.FAIL, "失败，未找到该提现申请", MsgLevel.ERROR);
		}
		if (withdraw.getStatus() != WithdrawStatus.ACCEPT.getValue() && withdraw.getStatus() != WithdrawStatus.APPLY_FOR.getValue()) {
			return new MsgBean(Code.FAIL, "失败，该提现申请状态错误", MsgLevel.ERROR);
		}
		if (withdraw.getStatus() == WithdrawStatus.ACCEPT.getValue() && withdraw.getHandlerAdminId() != SessionHelper.getSessionAdmin().getId()) {
			return new MsgBean(Code.FAIL, "失败，你不是该提现申请的受理人", MsgLevel.ERROR);
		}
		withdraw.setHandlerAdminId(SessionHelper.getSessionAdmin().getId());
		withdraw.setStatus(WithdrawStatus.FAIL.getValue());
		withdraw.setEndTime(new Date());
		int withdrawRow = withdrawMapper.updateByPrimaryKey(withdraw);
		if (withdrawRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 账户金额退还
		Account userAcc = accountMapper.queryAccountByUserId(withdraw.getUserId());
		// 账户明细
		String sno = Sequence.generateSeq(SequenceConstant.FLOW);
		AccountDetail accDetail = new AccountDetail();
		accDetail.setSno(sno);
		accDetail.setUserId(userAcc.getUserId());
		accDetail.setIncomeFlag(true);
		accDetail.setDealType(DealType.USER_WITHDRAW.getValue());
		accDetail.setOriginalMoney(userAcc.getNormalMoney());
		accDetail.setDealMoney(withdraw.getMoney());
		accDetail.setDealMatter(DealType.USER_WITHDRAW.getName() + "【失败退还】");
		accDetail.setDealTime(new Date());
		int accDetailRow = accountDetailMapper.insert(accDetail);
		if (accDetailRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 账户金额变动
		userAcc.setNormalMoney(userAcc.getNormalMoney().add(withdraw.getMoney()));
		int userAccRow = accountMapper.updateByPrimaryKey(userAcc);
		if (userAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		// 资金到系统账户扣除
		SystemAccount systemAcc = new SystemAccount();
		systemAcc.setCreateTime(new Date());
		systemAcc.setSno(sno);
		systemAcc.setMoney(withdraw.getMoney());
		systemAcc.setIncomeFlag(false);
		systemAcc.setUserId(withdraw.getUserId());
		systemAcc.setMatter(DealType.USER_WITHDRAW.getName() + "【失败退还】");
		int systemAccRow = systemAccountMapper.insert(systemAcc);
		if (systemAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "处理成功，提现金额已退回账户", MsgLevel.NORMAL);
	}

}
