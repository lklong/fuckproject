package com.zhigu.common.constant;

public interface PhoneSendType {
	/** 默认叫校验码短信 */
	public static final int DEFAULT = 0;
	/** 手机注册校验码短信 */
	public static final int PHONE_REGISTER = 1;
	/** 重置密码验证码短信 */
	public static final int PASSWORD_RESET = 2;
	/** 手机绑定验证码短信 */
	public static final int PHONE_BIND = 3;
	/** 手机绑定旧手机验证验证码短信 */
	public static final int PHONE_BIND_OLD_VERIFY = 5;
	/** 支付密码设置短信 */
	public static final int PAY_PASSWORD = 4;
	/** 绑定银行卡短信 */
	public static final int BANK_BIND = 6;
	/** APP链接短信 */
	public static final int APP_LINK = 21;

}
