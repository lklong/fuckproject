package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.CompanyAuth;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealStoreAuth;

/**
 * 认证相关
 * 
 * @author HeSiMin
 * @date 2014年9月9日
 *
 */
public interface IAuthService {
	/**
	 * 分页查询企业认证
	 * 
	 * @param page
	 * @return
	 */
	public List<CompanyAuth> queryCompanyAuthByPage(PageBean page);

	/**
	 * 查询企业认证
	 * 
	 * @param userID
	 * @return
	 */
	public CompanyAuth queryCompanyAuthByUserID(int userID);

	/**
	 * 更新企业认证
	 * 
	 * @param companyAuth
	 */
	public void updateCompanyAuthByUserID(CompanyAuth companyAuth);

	/**
	 * 查询实体认证
	 * 
	 * @param userID
	 * @return
	 */
	public RealStoreAuth queryRealStoreAuthByUserID(int userID);

	/**
	 * 实体认证
	 * 
	 * @param companyAuth
	 */
	public void updateRealStoreAuthByUserID(RealStoreAuth realStoreAuth);

}
