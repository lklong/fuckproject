package com.zhigu.common.constant;

/**
 * 所有状态类型
 * 
 * 包括 公司认证状态 实地认证状态 店铺审核状态
 * 
 * @author Y.Z.X
 *
 */
public interface CRSAuditStatus {
	/**
	 * 未认证/未审核
	 */
	public static final int STATUS_NOAPPROVE = 0;

	/**
	 * 通过
	 */
	public static final int STATUS_PASS = 1;

	/**
	 * 未通过
	 */
	public static final int STATUS_NOPASS = 2;

	/**
	 * 待审核
	 */
	public static final int STATUS_PENDING_REVIEW = 3;

	/**
	 * 店铺已开启
	 */
	public static final int STATUS_OPPEN = 4;

}
