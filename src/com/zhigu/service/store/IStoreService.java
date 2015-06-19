package com.zhigu.service.store;

import java.util.List;
import java.util.Map;

import com.zhigu.model.Goods;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;

/**
 * 供应商信息
 * 
 * @author liyouzan 2014年7月24日11:43:12
 */

public interface IStoreService {
	/**
	 * 查询店铺信息ID
	 * 
	 * @param storeID
	 */
	public Store queryStoreByID(int storeID);

	/**
	 * 查询店铺信息
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
	 * @param storeName
	 */
	public Store queryStoreByStoreName(String storeName);

	/**
	 * 注册供应商店铺信息
	 * 
	 * @param store
	 */
	public MsgBean registerStore(Store store);

	/**
	 * 修改店铺基本信息(通过userID)
	 * 
	 * @param store
	 */
	public MsgBean updateStoreBase(Store store);

	/**
	 * 修改店铺装饰信息
	 * 
	 * @param store
	 */
	public MsgBean updateStoreDecorate(Store store);

	/**
	 * 修改店铺正式会员flg
	 * 
	 * @param ID
	 * @param flg
	 */
	public void updateFullMemberFlg(int ID, int flg);

	/**
	 * 查询店铺商品 （by店铺ID）
	 * 
	 * @param page
	 * @param userID
	 * @return
	 */
	public PageBean<Goods> queryStoreGoodsByPage(PageBean<Goods> page, int storeID);

	/**
	 * 分页查询店铺(可付加商圈、店铺名)
	 * 
	 * @param page
	 * @return
	 */
	public PageBean<Store> queryStoreByPage(PageBean<Store> page, Integer businessArea, String storeName);

	/**
	 * 店铺商品
	 * 
	 * @param map
	 * @return
	 */
	public List<Goods> queryStoreGoods(Map<String, Object> map);

	/**
	 * 根据店铺ID 查询店铺信息
	 * 
	 * @param storeID
	 *            要查询的店铺ID
	 */
	public Store getByID(Integer storeID);

	/**
	 * 修改店铺审核状态
	 * 
	 * @param store
	 */
	public MsgBean updateApproveState(Integer status, Integer id);

	/**
	 * 分页查询店铺(可付加商圈、店铺名)
	 * 
	 * @param page
	 * @return
	 */
	List<Store> queryStoreByPage(PageBean<Store> page, Store store, String startDate, String endDate);

	/**
	 * 刷新店铺
	 * 
	 * @param storeId
	 * @return
	 */
	public MsgBean updateRefreshDate();

	/**
	 * 检查用户的店铺是否存在
	 * 
	 * @param userId
	 * @param storeId
	 * @return
	 */
	public Integer checkStoreExist(Integer userId, Integer storeId);

	/**
	 * 更新店铺装饰
	 * 
	 * @param store
	 */
	void updateStoreDecorate2(Store store);
}
