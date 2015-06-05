package com.zhigu.service.store;

import com.zhigu.model.CompanyAuth;
import com.zhigu.model.dto.MsgBean;

/**
 * 企业认证业务逻辑接口
 * 
 * @author Y.Z.X
 * @since 2015-06-04
 */
public interface ICompanyAuthService {

	/**
	 * 查询企业认证by storeID
	 * 
	 * @param storeID
	 * @return
	 */
	public CompanyAuth queryCompanyAuthByStoreID(int storeID);

	/**
	 * 查询企业认证by userID
	 * 
	 * @param storeID
	 * @return
	 */
	public CompanyAuth queryCompanyAuthByUserID(int userID);

	/**
	 * 保存店铺企业认证信息
	 * 
	 * @param store
	 */
	public MsgBean saveCompanyAuth(CompanyAuth companyAuth, int storeID);

	/**
	 * 更新企业认证信息状态
	 * 
	 * @param rejectReason
	 *            审核不通过原因
	 * @param status
	 *            审核状态 0:不通过 1:通过
	 * @param storeID
	 *            店铺ID
	 * @return
	 */
	public MsgBean updateCompanyAuthStatus(String rejectReason, Integer status, Integer storeID);

}
