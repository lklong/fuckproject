package com.zhigu.service.common;

import com.zhigu.model.EmailVerify;
import com.zhigu.model.dto.MsgBean;

/**
 * 邮件业务
 * 
 * @ClassName: IEmailService
 * @author hesimin
 * @date 2015年5月15日 下午12:03:04
 *
 */
public interface IEmailService {
	/**
	 * 发送绑定邮件
	 * 
	 * @return
	 */
	public MsgBean sendBindEmail(String email);

	/**
	 * 发送密码重置邮件
	 * 
	 * @param loginName
	 *            账户名
	 * @return
	 */
	public MsgBean sendPasswordResetEmail(String loginName);

	/**
	 * 查询验证邮件，并且进行有效性验证
	 * 
	 * @param uid
	 * @return
	 */
	public EmailVerify queryVerifyEmail(String uid, int emailVerifyType);

	public MsgBean verifyBindEmail(String uid);

	public MsgBean verifyPasswordResetEmail(String uid, String newPassword);
}
