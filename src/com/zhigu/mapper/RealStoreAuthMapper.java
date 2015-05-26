package com.zhigu.mapper;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.RealStoreAuth;

public interface RealStoreAuthMapper {
	/**
	 * 添加实体认证
	 * 
	 * @param realStoreAuth
	 */
	public void addRealStoreAuth(RealStoreAuth realStoreAuth);

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
	 * 更新实体认证
	 * 
	 * @param realStoreAuth
	 */
	public int updateRealStoreAuth(@Param("realStoreAuth") RealStoreAuth realStoreAuth, @Param("storeID") Integer storeID);

}
