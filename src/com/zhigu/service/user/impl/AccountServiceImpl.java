package com.zhigu.service.user.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.SequenceConstant;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.BCrypt;
import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.Sequence;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.StringUtil.RandomType;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.captcha.CaptchaUtil;
import com.zhigu.mapper.AccountDetailMapper;
import com.zhigu.mapper.AccountMapper;
import com.zhigu.mapper.BankBinMapper;
import com.zhigu.mapper.RechargeRecordMapper;
import com.zhigu.mapper.UserMapper;
import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.RechargeRecord;
import com.zhigu.model.UserAuth;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;

/**
 * 
 * @author zhouqibing 2014年7月21日上午9:38:04
 */
@Service
public class AccountServiceImpl implements IAccountService {
	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private AccountDetailMapper accountDetailMapper;
	@Autowired
	private RechargeRecordMapper rechargeRecordMapper;
	@Autowired
	private UserMapper userDao;
	@Autowired
	private BankBinMapper bankBinMapper;

	@Override
	public Account queryAccountByUserID(int userID) {
		Account acc = accountMapper.queryAccountByUserId(userID);
		if (acc != null) {
			acc.setSalt("*****");
			if (!StringUtil.isEmpty(acc.getPayPasswd())) {
				acc.setPayPasswd("*****");
			}
			String bankNo = acc.getBankNo();
			if (!StringUtil.isEmpty(bankNo)) {
				StringBuilder sb = new StringBuilder();
				int bankLength = bankNo.length();
				for (int i = 0; i < bankLength; i++) {
					sb.append("*");
				}
				acc.setBankNo(sb.append(bankNo.substring(bankLength - 4)).toString());
			}
		}
		return acc;
	}

	@Override
	public AccountDetail queryAccountDetailBySerialNO(String serialNO) {
		return accountDetailMapper.queryAccountDetailBySno(serialNO);
	}

	@Override
	public List<AccountDetail> queryAccountDetailList(PageBean<AccountDetail> page, int userID, Date startDate, Date endDate) {
		List<AccountDetail> list = accountDetailMapper.queryAccountDetailListByPage(page, userID, startDate, endDate);
		page.setDatas(list);
		return list;
	}

	@Override
	public MsgBean saveRechargeRecord(RechargeRecord record) {
		int row = rechargeRecordMapper.insert(record);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "success", MsgLevel.NORMAL);
	}

	@Override
	public RechargeRecord queryRechargeRecord(int recordId) {
		return rechargeRecordMapper.selectByPrimaryKey(recordId);
	}

	@Override
	public void updateRechargeSuccess(RechargeRecord record) {
		RechargeRecord rr = rechargeRecordMapper.queryRechargeRecordByNo(record.getPaymentNo());
		if (rr.getStatus() == 1) {
			return;
		}
		// 修改总金额
		Account acc = accountMapper.queryAccountByUserId(record.getUserId());
		BigDecimal original = new BigDecimal(acc.getFreezeMoney().toBigInteger());// 原始金额
		acc.setNormalMoney(acc.getNormalMoney().add(record.getRechargeMoney()));
		int accRow = accountMapper.updateByPrimaryKey(acc);
		if (accRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 修改充值记录
		record.setStatus(Flg.ON);
		int rechargeRow = rechargeRecordMapper.updateByPrimaryKey(record);
		if (rechargeRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		AccountDetail ad = new AccountDetail();
		ad.setUserId(record.getUserId());
		ad.setDealMoney(record.getRechargeMoney());
		ad.setOriginalMoney(original);// 原始金额
		ad.setIncomeFlag(true);
		ad.setSno(Sequence.generateSeq(SequenceConstant.FLOW));
		ad.setDealMatter("在线充值【支付宝】");
		ad.setDealTime(new Date());
		accountDetailMapper.insert(ad);
	}

	@Override
	public List<RechargeRecord> queryRechargeRecord(Integer userID, PageBean<RechargeRecord> page) {
		List<RechargeRecord> list = rechargeRecordMapper.queryRechargeRecordByPage(userID, page);
		page.setDatas(list);
		return list;
	}

	@Override
	public RechargeRecord queryRechargeRecord(String PaymentNO) {
		return rechargeRecordMapper.queryRechargeRecordByNo(PaymentNO);
	}

	@Override
	public MsgBean verifyPaypasswd(String payPasswd) {
		Account account = accountMapper.queryAccountByUserId(SessionHelper.getSessionUser().getUserID());
		if (StringUtil.isEmpty(account.getPayPasswd())) {
			return new MsgBean(Code.FAIL, "未设置支付密码，<a href='/user/security/paymentpwd' style='color: red;' target='_blank'>点此去设置 >> </a>", MsgLevel.ERROR);
		}
		if (BCrypt.checkpw(payPasswd + account.getSalt(), account.getPayPasswd())) {
			return new MsgBean(Code.SUCCESS, "支付验证成功", MsgLevel.NORMAL);
		} else {
			return new MsgBean(Code.FAIL, "支付密码错误", MsgLevel.ERROR);
		}
	}

	@Override
	public MsgBean updatePaypasswd(int userID, String paymentPwd, String captcha) {
		UserAuth auth = userDao.queryUserAuthByUserID(userID);
		if (!VerifyUtil.passwordVerify(paymentPwd)) {
			return new MsgBean(Code.FAIL, "密码必须为6-16个字符，包含数字、字母", MsgLevel.ERROR);
		}

		if (Md5.convert(paymentPwd, auth.getSalt()).equals(auth.getPassword())) {
			return new MsgBean(Code.FAIL, "支付密码不能与登录密码一样", MsgLevel.ERROR);
		}
		if (!CaptchaUtil.verifyAndRemove(auth.getPhone(), captcha)) {
			return new MsgBean(Code.FAIL, "验证码输入错误", MsgLevel.ERROR);
		}
		String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);
		// int row = accountDao.updatePaymentPwd(userID,
		// BCrypt.hashpw(paymentPwd + salt, BCrypt.gensalt()), salt);
		int row = accountMapper.updatePayPasswd(userID, BCrypt.hashpw(paymentPwd + salt, BCrypt.gensalt()), salt);
		if (row == 1) {
			return new MsgBean(Code.SUCCESS, "支付密码修改成功", MsgLevel.NORMAL);
		} else {
			throw new ServiceException("支付密码修改数据库错误");
		}
	}

	@Override
	public MsgBean updateBankNo(String bankNo, String bankCardMaster, String captcha, String bankName) {
		int userId = SessionHelper.getSessionUser().getUserID();
		UserAuth userAuth = userDao.queryUserAuthByUserID(userId);
		if (!CaptchaUtil.verify(userAuth.getPhone(), captcha)) {
			return new MsgBean(Code.FAIL, "验证码错误", MsgLevel.ERROR);
		}

		if (StringUtil.isEmpty(bankNo) || bankNo.length() > 20) {
			return new MsgBean(Code.FAIL, "银行卡账号错误", MsgLevel.ERROR);
		}
		if (StringUtil.isEmpty(bankCardMaster) || bankCardMaster.length() > 20) {
			return new MsgBean(Code.FAIL, "持卡人姓名错误", MsgLevel.ERROR);
		}
		if (StringUtil.isEmpty(bankName)) {
			return new MsgBean(Code.FAIL, "未选择所属银行", MsgLevel.ERROR);
		}

		Account acc = accountMapper.selectByPrimaryKey(userId);
		// 卡号银行查询
		// BankBin bank = bankBinMapper.selectByBin(bankNo.substring(0, 6));
		// if (bank != null) {
		// acc.setBankName(bank.getBankName());
		// }
		acc.setBankName(bankName);
		acc.setBankNo(bankNo);
		acc.setBankCardMaster(bankCardMaster);
		int row = accountMapper.updateByPrimaryKey(acc);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		CaptchaUtil.remove(userAuth.getPhone());
		return new MsgBean(Code.SUCCESS, "绑定银行卡账号成功", MsgLevel.NORMAL);
	}
}
