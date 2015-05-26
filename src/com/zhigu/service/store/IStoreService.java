package com.zhigu.service.store;

import java.util.List;
import java.util.Map;

import com.zhigu.model.CompanyAuth;
import com.zhigu.model.Goods;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealStoreAuth;
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
	public void updateStoreDecorate(Store store);

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
	 * 支付店铺会员费(冻结资金2000)
	 * 
	 * @param userID
	 * @return 支付代码
	 */
	public int applyPayStoreCost(int userID);

	/**
	 * 判断店铺是否可用
	 * 
	 * @param storeID
	 * @return true:正式会员/试用期内 false:非正式会员、试用期外
	 */
	public boolean isUseable(int storeID);

	/**
	 * 修改店铺等级点数（plus：LevelPoint+=#{levelPoint}）
	 * 
	 * @param userID
	 * @param addLevelPoint
	 */
	public void updateLevelPoint(int ID, int addLevelPoint);

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
	 * 保存店铺企业认证信息
	 * 
	 * @param store
	 */
	public MsgBean saveCompanyAuth(CompanyAuth companyAuth, int storeID);

	/**
	 * 保存店铺实地认证信息
	 * 
	 * @param store
	 */
	public MsgBean saveRealStoreAuth(RealStoreAuth realStoreAuth, int storeID);

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

	/**
	 * 分页查询店铺(可付加商圈、店铺名)
	 * 
	 * @param page
	 * @return
	 */
	List<Store> queryStoreByPage(PageBean<Store> page, Store store, String startDate, String endDate);

	/**
	 * 获取所有店铺的ID
	 * 
	 * @return
	 */
	public List queryStoreIDList();

	/**
	 * 刷新店铺
	 * 
	 * @param storeId
	 * @return
	 */
	public MsgBean updateRefreshDate();
}
