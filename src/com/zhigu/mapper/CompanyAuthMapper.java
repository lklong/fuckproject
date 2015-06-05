package com.zhigu.mapper;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.CompanyAuth;

public interface CompanyAuthMapper {
	/**
	 * 添加企业认证
	 * 
	 * @param companyAuth
	 */
	public void addCompanyAuth(CompanyAuth companyAuth);

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
	 * 更新企业认证
	 * 
	 * @param companyAuth
	 */
	public int updateCompanyAuth(@Param("companyAuth") CompanyAuth companyAuth, @Param("storeID") Integer storeID);

}
