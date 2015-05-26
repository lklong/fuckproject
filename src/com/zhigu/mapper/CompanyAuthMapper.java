package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.CompanyAuth;
import com.zhigu.model.PageBean;

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

	/**
	 * 分页查询企业认证
	 * 
	 * @param page
	 * @return
	 */
	public List<CompanyAuth> queryCompanyAuthByPage(PageBean page);

}
