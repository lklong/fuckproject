package com.zhigu.service.user;

import java.util.Date;
import java.util.List;

import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.RechargeRecord;
import com.zhigu.model.dto.MsgBean;

/**
 * 用户帐户信息
 * 
 * @author zhouqibing 2014年7月21日上午9:34:39
 */
public interface IAccountService {
	/**
	 * 查询用户的帐户信息(密码等机密信息隐藏)
	 * 
	 * @param userID
	 */
	public Account queryAccountByUserID(int userID);

	/**
	 * 根据订单号(流水号) 查询用户的收支明细信息
	 * 
	 * @param userID
	 */
	public AccountDetail queryAccountDetailBySerialNO(String serialNO);

	/**
	 * 根据日期查询用户的收支明细信息
	 * 
	 * @param userID
	 */
	public List<AccountDetail> queryAccountDetailList(PageBean<AccountDetail> page, int userID, Date startDate, Date endDate);

	/**
	 * 保存充值记录
	 * 
	 * @param record
	 */
	public MsgBean saveRechargeRecord(int payType, String money);

	/**
	 * 查询充值记录
	 * 
	 * @param recordID
	 * @return
	 */
	public RechargeRecord queryRechargeRecord(int recordID);

	/**
	 * 查询充值记录
	 * 
	 * @param recordID
	 * @return
	 */
	public RechargeRecord queryRechargeRecord(String PaymentNO);

	/**
	 * 查询充值记录
	 * 
	 * @param page
	 * @return
	 */
	public List<RechargeRecord> queryRechargeRecord(Integer userID, PageBean<RechargeRecord> page);

	/**
	 * 修改充值记录
	 * 
	 * @param record
	 */
	public void updateRechargeSuccess(RechargeRecord record);

	/**
	 * 验证支付密码（BCrypt加密验证）,当前session用户
	 * 
	 * @param passwd
	 * @return
	 */
	public MsgBean verifyPaypasswd(String payPasswd);

	/**
	 * 修改支付密码(支付密码使用 bcrypt 加密)
	 * 
	 * @param userID
	 * @param paymentPwd
	 */
	public MsgBean updatePaypasswd(int userID, String paymentPwd, String captcha);

	/**
	 * 修改账户绑定银行卡
	 * 
	 * @param userId
	 * @param bankNo
	 * @return
	 */
	public MsgBean updateBankNo(String bankNo, String bankCardMaster, String captcha, String bankName);

}
