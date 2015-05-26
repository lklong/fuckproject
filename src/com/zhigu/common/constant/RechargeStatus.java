package com.zhigu.common.constant;

/**
 * 充值状态
 * 
 * @ClassName: RechargeStatus
 * @author hesimin
 * @date 2015年4月23日 下午2:34:34
 *
 */
public interface RechargeStatus {
	/** 待支付 */
	public static final int WAITING_PAY = 0;
	/** 充值成功 */
	public static final int PAY_SUCCESS = 1;
	/** 充值失败 */
	public static final int PAY_FAIL = 2;
	/** 失效 */
	public static final int LOSE_EFFICACY = 9;
}
