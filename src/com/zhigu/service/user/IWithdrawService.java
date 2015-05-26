package com.zhigu.service.user;

import com.zhigu.model.PageBean;
import com.zhigu.model.Withdraw;
import com.zhigu.model.dto.MsgBean;

public interface IWithdrawService {
	/**
	 * 用户申请提现
	 * 
	 * @param money
	 * @return
	 */
	public MsgBean saveWithdraw(String payPasswd, String money);

	/**
	 * 查询提现申请
	 * 
	 * @return
	 */
	public PageBean<Withdraw> queryWithdraw(PageBean<Withdraw> page, Integer userId, Integer status);

	public PageBean<Withdraw> adminQueryWithdraw(PageBean<Withdraw> page, Integer userId, String userPhone, Integer status, String bankNo, String bankCardMaster);

	/**
	 * 管理员处理提现申请(提现申请受理)
	 * 
	 * @return
	 */
	public MsgBean handlerWithdrawAccept(Long id);

	/**
	 * 管理员处理提现申请(提现成功)
	 * 
	 * @return
	 */
	public MsgBean handlerWithdrawSuccess(Long id);

	/**
	 * 管理员处理提现申请(提现失败)
	 * 
	 * @param id
	 * @param failReason
	 * @return
	 */
	public MsgBean handlerWithdrawFail(Long id, String failReason);
}
