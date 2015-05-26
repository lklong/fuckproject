package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.Favourite;
import com.zhigu.model.Goods;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;

/**
 * 用户收藏信息
 * 
 * @author HeSiMin
 * @date 2014年7月29日
 */
public interface IFavouriteService {
	/**
	 * 添加收藏商品
	 * 
	 * @param userID
	 * @param commodityID
	 */
	public void addFavouriteCommodity(int userID, int commodityID);

	/**
	 * 添加收藏店铺
	 * 
	 * @param userID
	 * @param storeID
	 */
	public void addFavouriteStore(int userID, int storeID);

	/**
	 * 添加购买过的店铺
	 * 
	 * @param userID
	 * @param storeID
	 */
	public void addBoughtStore(int userID, int storeID);

	/**
	 * 删除收藏商品
	 * 
	 * @param array
	 */
	public void deleteFavouriteCommodity(int userID, int[] CommodityArray);

	/**
	 * 删除收藏店铺
	 * 
	 * @param array
	 */
	public void deleteFavouriteStore(int userID, int[] storeArray);

	/**
	 * 删除购买过的店铺
	 * 
	 * @param array
	 */
	public void deleteBoughtStoree(int userID, int[] storeArray);

	/**
	 * 查询收藏商品
	 * 
	 * @return
	 */
	public List<Goods> queryFavouriteGoods(int userID);

	/**
	 * 查询收藏店铺
	 * 
	 * @return
	 */
	public List<Store> queryFavouriteStore(int userID);

	/**
	 * 购买过的店铺
	 * 
	 * @param userID
	 * @return
	 */
	public List<Store> queryBoughtStore(int userID);

	/**
	 * 查询收藏
	 * 
	 * @param userID
	 * @param favouriteID
	 * @param type
	 *            1:店铺 2:商品
	 * @return
	 */
	public Favourite queryFavourite(int userID, int favouriteID, int type);

	/**
	 * 分页查询收藏商品
	 * 
	 * @param page
	 * @param userID
	 * @return
	 */
	public PageBean<Goods> queryFavouriteGoodsByPage(PageBean<Goods> page, int userID);

	/**
	 * 分页查询用户收藏店铺
	 * 
	 * @param page
	 * @param userID
	 * @return
	 */
	public PageBean<Store> queryFavouriteStoreByPage(PageBean<Store> page, int userID);
}
