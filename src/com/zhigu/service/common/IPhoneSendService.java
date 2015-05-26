package com.zhigu.service.common;

import com.zhigu.model.dto.MsgBean;

/**
 * 手机发送业务
 * 
 * @ClassName: IPhoneSendService
 * @author hesimin
 * @date 2015年5月26日 下午4:26:58
 *
 */
public interface IPhoneSendService {
	/**
	 * 
	 * @param phone
	 * @param type
	 * @return
	 */
	public MsgBean send(String phone, int type);

	/**
	 * 手机验证码验证
	 * 
	 * @param phone
	 * @param type
	 * @param captcha
	 * @return
	 */
	public MsgBean verify(String phone, int type, String captcha);
}
