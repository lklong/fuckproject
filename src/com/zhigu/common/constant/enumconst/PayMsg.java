package com.zhigu.common.constant.enumconst;

/**
 * 付款消息
 * 
 * @author HeSiMin
 * @date 2014年9月2日
 *
 */
public enum PayMsg {
	SUCCESS("支付成功", 0), MONEY_INSUFFICIENT("账户资金不足", 1);
	private String msg;
	private int code;

	private PayMsg(String msg, int code) {
		this.msg = msg;
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public static String getMsgByCode(int code) {
		PayMsg[] array = PayMsg.values();
		for (PayMsg payMsg : array) {
			if (payMsg.getCode() == code) {
				return payMsg.getMsg();
			}
		}
		return null;
	}
}
