package com.zhigu.service.store;

import com.zhigu.model.RealStoreAuth;
import com.zhigu.model.dto.MsgBean;

/**
 * 实体认证业务逻辑接口
 * 
 * @author Y.Z.X
 * @since 2015-06-04
 */
public interface IRealStoreAuthService {

	/**
	 * 查询实体认证by storeID
	 * 
	 * @param storeID
	 * @return
	 */
	public RealStoreAuth queryRealStoreAuthByStoreID(int storeID);

	/**
	 * 查询实体认证by userID
	 * 
	 * @param storeID
	 * @return
	 */
	public RealStoreAuth queryRealStoreAuthByUserID(int userID);

	/**
	 * 保存店铺实地认证信息
	 * 
	 * @param store
	 */
	public MsgBean saveRealStoreAuth(RealStoreAuth realStoreAuth, int storeID);

	/**
	 * 更新实地认证信息状态
	 * 
	 * @param rejectReason
	 *            审核不通过原因
	 * @param status
	 *            审核状态 0:不通过 1:通过
	 * @param storeID
	 *            店铺ID
	 * @return
	 */
	public MsgBean updateRealStoreAuthStatus(String rejectReason, Integer status, Integer storeID);
}
