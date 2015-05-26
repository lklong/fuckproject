package com.zhigu.common.utils.sms;

/**
 * 发送内容模板，问号用于替换验证码，如在内容中需要使用到问号，请使用全角问号：？
 * 
 * @author zhouqibing 2014年7月21日下午5:10:38
 */
public class SMSTemplate {

	public static String getTemplate(int t) {
		String tp = null;
		switch (t) {
		case 1:
			tp = "本次安全码用于手机注册：?,仅可使用一次,请勿泄漏。";
			break;
		case 2:
			tp = "本次安全码用于重置密码：?,仅可使用一次,请勿泄漏。";
			break;
		case 3:
			tp = "本次安全码用于手机绑定：?,仅可使用一次,请勿泄漏。";
			break;
		case 4:
			tp = "本次安全码用于支付密码设置：?,仅可使用一次,请勿泄漏。";
			break;
		case 5:
			tp = "本次安全码用于找回登录密码：?,仅可使用一次,请勿泄漏。";
			break;
		case 6:
			tp = "本次安全码用于绑定银行卡：?,仅可使用一次,请勿泄漏。";
			break;
		default:
			tp = "本次安全码：?,仅可使用一次,请勿泄漏。";
			break;
		}
		return tp;
	}
}
