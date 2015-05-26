package com.zhigu.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.DownloadHistory;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsAux;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.GoodsImage;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.PageBean;
import com.zhigu.model.Shortcutgoods;

/**
 * 商品Dao
 * 
 * @author zhouqibing 2014年9月28日下午3:24:43
 */
public interface GoodsMapper {
	/**
	 * 保存商品
	 * 
	 * @param goods
	 * @return
	 */
	public int saveGoods(Goods goods);

	/**
	 * 修改商品
	 * 
	 * @param goods
	 * @return
	 */
	public boolean updateGoods(Goods goods);

	/**
	 * 修改商品
	 * 
	 * @param goods
	 * @return
	 */
	public int updateGoodsRefreshDate(@Param("refreshDate") Date refreshDate, @Param("goodsID") Integer goodsID);

	/**
	 * 修改商品删除标示 逻辑删除
	 * 
	 * @param goodsID
	 * @param deleteFlag
	 * @return
	 */
	public int updateGoodsDeleteFlagByGoodsID(@Param("goodsID") Integer goodsID, @Param("deleteFlag") boolean deleteFlag);

	/**
	 * 保存商品附属信息
	 * 
	 * @param aux
	 * @return
	 */
	public boolean saveGoodsAux(GoodsAux aux);

	/**
	 * 保存商品属性
	 * 
	 * @param property
	 * @return
	 */
	public boolean saveGoodsProperty(List<GoodsProperty> properties);

	/**
	 * 保存商品Sku
	 * 
	 * @param skus
	 * @return
	 */
	public boolean saveGoodsSku(List<GoodsSku> skus);

	/**
	 * 更新商品sku
	 * 
	 * @param sku
	 * @return
	 */
	public int updateGoodsSku(GoodsSku sku);

	/**
	 * 保存商品图片
	 * 
	 * @param images
	 * @return
	 */
	public boolean saveGoodsImage(List<GoodsImage> images);

	/**
	 * 查询商品SKU
	 * 
	 * @param goodsId
	 * @return
	 */
	public List<GoodsSku> queryGoodsSkus(int goodsId);

	/**
	 * 查询商品
	 * 
	 * @param goodsId
	 * @return
	 */
	public Goods queryGoodsById(int goodsId);

	/**
	 * 查询商品
	 * 
	 * @param page
	 * @return
	 */
	public List<Goods> queryGoodsByPage(@Param("gc") GoodsCondition gc, @Param("page") PageBean<Goods> page);

	/**
	 * 查询sku
	 * 
	 * @param id
	 * @return
	 */
	public GoodsSku queryGoodsSkuByID(int id);

	/**
	 * 删除商品图片
	 * 
	 * @param goodsId
	 * @return
	 */
	public boolean deleteGoodsImage(int goodsId);

	/**
	 * 删除商品属性
	 * 
	 * @param goodsId
	 * @return
	 */
	public boolean deleteGoodsProperty(int goodsId);

	/**
	 * 删除商品Sku
	 * 
	 * @param goodsId
	 * @return
	 */
	public boolean deleteGoodsSku(int goodsId);

	/**
	 * 修改商品附属信息
	 * 
	 * @param aux
	 * @return
	 */
	public boolean updateGoodsAux(GoodsAux aux);

	/**
	 * 查询店铺的商品数量
	 * 
	 * @param gc
	 * @return
	 */
	public int queryStoreGoodsNum(GoodsCondition gc);

	/**
	 * 查询商品附属信息
	 * 
	 * @param goodsId
	 * @return
	 */
	public GoodsAux queryGoodsAux(int goodsId);

	/**
	 * 下载历史
	 * 
	 * @param page
	 * @param goodsId
	 * @return
	 */
	public List<DownloadHistory> queryDownloadHistoryByPage(@Param("page") PageBean<DownloadHistory> page, @Param("goodsId") int goodsId);

	public int saveShortcutGoods(Shortcutgoods shortcutgoods);

	public List<Shortcutgoods> queryshortcutgoods(int userId);

	public List<Shortcutgoods> queryshortcutgoodsByStatus(@Param("userId") int userId, @Param("status") boolean status);

	public boolean deleteShortcut(int id);

	public List<Shortcutgoods> queryshortcutgoodsByManagerListByPage(PageBean<Shortcutgoods> page);

	public boolean changeShortcutGoodsStatus(Shortcutgoods shortcutgoods);

	public Shortcutgoods queryShortcutGoodsByID(int shortcutGoodsID);

	/**
	 * 正则查询商品名称集合
	 * 
	 * @param keyword
	 * @return 匹配的商品名称集合
	 */
	List<String> queryGoodsNames(String keyword);

	/**
	 * 根据商品id 查询商品的销售的属性
	 * 
	 * @param goodsId
	 * @return
	 */
	List<GoodsProperty> queryGoodsSkuFromProperty(int goodsId);

	/**
	 * 根据商品的某个销售属性和商品id 查询该销售属性的组合sku
	 * 
	 * @param goodsId
	 * @return
	 */
	List<GoodsSku> queryGoodsSkuByPropStr(@Param("goodsId") int goodsId, @Param("sku") String sku);

	/**
	 * 首页检索
	 * 
	 * @param storeName
	 *            店铺名称
	 * @param propName
	 *            货号
	 * @param goodsName
	 *            商品名称
	 * @return
	 */
	List<Goods> queryForHomeByPage(@Param("page") PageBean<Goods> page, @Param("storeName") String storeName, @Param("propName") String propName, @Param("goodsName") String goodsName);

	/**
	 * 查询货号
	 * 
	 * @param goodsId
	 *            商品id
	 * @return
	 */
	String queryItemNoInGoodsProperty(int goodsId);

	/**
	 * 查询订单中的商品
	 * 
	 * @param orderId
	 *            订单id
	 * @return
	 */
	List<Goods> querGoodsInOrders(int orderId);

}
