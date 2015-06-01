package com.zhigu.service.user;

import com.zhigu.model.RealUserAuth;
import com.zhigu.model.dto.MsgBean;

public interface IRealUserAuthService {

	/**
	 * 用户实名认证
	 * 
	 * @param userID
	 */
	public RealUserAuth queryRealUserAuth(int userID);

	/**
	 * 用户实名认证保存
	 * 
	 * @param userID
	 */
	public MsgBean saveRealUserAuth(RealUserAuth realUserAuth);

	/**
	 * 查询用户实名认证
	 * 
	 * @param idcard
	 *            身份证号
	 */
	public RealUserAuth queryRealUserAuthByIdcard(String idcard);

	/**
	 * 更新实名认证的状态
	 * 
	 * @param userID
	 *            用户ID
	 * @param status
	 *            状态
	 * @param rejectReason
	 *            驳回原因
	 * @return
	 */
	public MsgBean updateRealUserAuthStatus(Integer userID, Integer status, String rejectReason);

}
