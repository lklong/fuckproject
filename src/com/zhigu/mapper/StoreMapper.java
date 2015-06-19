package com.zhigu.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Goods;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;

public interface StoreMapper {
	/**
	 * 根据店铺ID查询店铺信息
	 * 
	 * @param storeID
	 */
	public Store queryStoreByID(int storeID);

	/**
	 * 根据用户ID查询店铺信息
	 * 
	 * @param userID
	 */
	public Store queryStoreByUserID(int userID);

	/**
	 * 根据域名查询店铺信息
	 * 
	 * @param domain
	 */
	public Store queryStoreByDomain(String domain);

	/**
	 * 根据商店名称查询店铺信息
	 * 
	 * @param shopName
	 */
	public Store queryStoreByStoreName(String StoreName);

	/**
	 * 添加店铺信息
	 * 
	 * @param store
	 */
	public void addStore(Store store);

	/**
	 * 修改店铺信息
	 * 
	 * @param store
	 */
	public void updateStore(Store store);

	/**
	 * 修改店铺的刷新时间
	 * 
	 * @param refreshDate
	 *            刷新时间
	 * @param stroeId
	 *            店铺ID
	 * @return
	 */
	public int updateStoreRefreshDateByStoreId(@Param("refreshDate") Date refreshDate, @Param("storeId") Integer storeId);

	/**
	 * 修改店铺正式会员flg
	 * 
	 * @param ID
	 * @param flg
	 */
	public void updateFullMemberFlg(@Param("ID") Integer ID, @Param("flg") Integer flg);

	/**
	 * 修改店铺企业认证状态
	 * 
	 * @param store
	 * 
	 */
	public void updateCompanyAuthState(@Param("status") Integer status, @Param("id") Integer id);

	/**
	 * 修改店铺实地认证状态
	 * 
	 * @param store
	 */
	public void updateRealStoreAuthState(@Param("status") Integer status, @Param("id") Integer id);

	/**
	 * 查询店铺商品 （by店铺ID）
	 * 
	 * @param page
	 * @param storeID
	 * @return
	 */
	public List<Goods> queryStoreGoodsByPage(@Param("page") PageBean<Goods> page, @Param("storeID") int storeID);

	/**
	 * 分页查询店铺(可附加商圈、店铺名)
	 * 
	 * @param page
	 * @return
	 */
	public List<Store> queryStoreByPage(@Param("page") PageBean<Store> page, @Param("businessArea") Integer businessArea, @Param("storeName") String storeName);

	/**
	 * 查询店铺by IDs
	 * 
	 * @param IDs
	 * @return
	 */
	// public List<Store> queryStoreByIDs(int[] IDs);

	/**
	 * 修改店铺等级点数（plus：LevelPoint+=#{levelPoint}）
	 * 
	 * @param userID
	 * @param levelPoint
	 */
	public void updateLevelPoint(@Param("ID") int ID, @Param("levelPoint") int levelPoint);

	/**
	 * 店铺商品（取最新发布的N条）
	 * 
	 * @param map
	 * @return
	 */
	public List<Goods> queryStoreGoods(Map<String, Object> map);

	/**
	 * @param status
	 */
	int updateApproveState(@Param("status") Integer status, @Param("id") Integer id);

	/**
	 * 获取店铺列表 （后台使用）
	 * 
	 * @param page
	 * @param store
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	List<Store> queryStoreListByPage(PageBean<Store> page);

	/**
	 * 获取所有店铺的ID （后台店铺公告里需要）
	 * 
	 * @return
	 */
	public List<String> queryStoreIDList();

	/**
	 * 检查用户的店铺是否存在
	 * 
	 * @param userId
	 * @param storeId
	 * @return
	 */
	public Integer checkStoreExist(@Param("userId") Integer userId, @Param("storeId") Integer storeId);

}
