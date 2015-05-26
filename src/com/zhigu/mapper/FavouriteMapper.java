package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Favourite;
import com.zhigu.model.Goods;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;

/**
 * 用户收藏信息数据库接口
 * 
 * @author HeSiMin
 * @date 2014年7月29日
 *
 */
public interface FavouriteMapper {
	/**
	 * 添加收藏
	 * 
	 * @param favourite
	 */
	public void addFavourite(Favourite favourite);

	/**
	 * 批量删除收藏
	 * 
	 * @param array
	 */
	public void delFavourite(@Param("userID") Integer userID, @Param("favouriteIDs") int[] idItem, @Param("type") int type);

	/**
	 * 查询收藏（用户ID,收藏ID,类型）
	 * 
	 * @param favourite
	 * @return
	 */
	public Favourite queryFavourite(Favourite favourite);

	/**
	 * 查询收藏商品
	 * 
	 * @param favourite
	 * @return
	 */
	public List<Goods> queryFavouriteGoodsByUserID(Favourite favourite);

	/**
	 * 查询用户收藏店铺
	 * 
	 * @param favourite
	 */
	public List<Store> queryFavouriteStoreByUserID(Favourite favourite);

	/**
	 * 分页查询收藏商品
	 * 
	 * @param page
	 * @param userID
	 * @return
	 */
	public List<Goods> queryFavouriteGoodsByPage(@Param("page") PageBean<Goods> page, @Param("userID") int userID);

	/**
	 * 分页查询用户收藏店铺
	 * 
	 * @param page
	 * @param userID
	 * @return
	 */
	public List<Store> queryFavouriteStoreByPage(@Param("page") PageBean<Store> page, @Param("userID") int userID);
}
