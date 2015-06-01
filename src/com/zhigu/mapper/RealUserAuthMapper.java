package com.zhigu.mapper;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.RealUserAuth;

/**
 * 实名认证 数据
 * 
 * @author Y.Z.X
 * @since 2015-05-28
 */
public interface RealUserAuthMapper {

	/**
	 * 用户实名认证
	 * 
	 * @param userID
	 */
	public RealUserAuth queryRealUserAuthByUserID(int userID);

	/**
	 * 查询用户实名认证
	 * 
	 * @param idcard
	 *            身份证号
	 */
	public RealUserAuth queryRealUserAuthByIdcard(String idcard);

	/**
	 * 用户实名认证修改
	 * 
	 * @param userID
	 */
	public void updateRealUserAuth(RealUserAuth realUserAuth);

	/**
	 * 修改用户实名认证的状态
	 * 
	 * @param status
	 *            状态
	 * @param approveAdminId
	 *            审核人的ID
	 * @param approveTime
	 *            审核时间
	 * @param rejectReason
	 *            驳回原因
	 * @param userID
	 *            用户ID
	 * @return
	 */
	public int updateRealUserAuthStatus(@Param("status") Integer status, @Param("approveAdminId") Integer approveAdminId, @Param("approveTime") Date approveTime,
			@Param("rejectReason") String rejectReason, @Param("userId") Integer userID);

	/**
	 * 用户实名认证保存
	 * 
	 * @param userID
	 */
	public void saveRealUserAuth(RealUserAuth realUserAuth);

}
