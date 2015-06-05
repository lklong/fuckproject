package com.zhigu.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.enumconst.FavouriteType;
import com.zhigu.mapper.FavouriteMapper;
import com.zhigu.model.Favourite;
import com.zhigu.model.Goods;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.service.user.IFavouriteService;

/**
 * 用户收藏信息
 * 
 * @author HeSiMin
 * @date 2014年7月29日
 */
@Service
public class FavouriteServiceImpl implements IFavouriteService {
	@Autowired
	private FavouriteMapper favouriteDao;

	@Override
	public void addFavouriteCommodity(int userID, int commodityID) {
		Favourite oldFavourite = favouriteDao.queryFavourite(userID, commodityID, FavouriteType.GOODS.getValue());
		if (oldFavourite != null)
			return;
		Favourite favourite = new Favourite();
		favourite.setUserID(userID);
		favourite.setStoreOrGoodsId(commodityID);
		favourite.setType(FavouriteType.GOODS.getValue());
		favouriteDao.addFavourite(favourite);
	}

	@Override
	public void addFavouriteStore(int userID, int storeID) {
		Favourite f = this.queryFavourite(userID, storeID, FavouriteType.STORE.getValue());
		if (f != null)
			return;
		Favourite favourite = new Favourite();
		favourite.setUserID(userID);
		favourite.setStoreOrGoodsId(storeID);
		favourite.setType(FavouriteType.STORE.getValue());
		favouriteDao.addFavourite(favourite);
	}

	@Override
	public List<Goods> queryFavouriteGoods(int userID) {
		return favouriteDao.queryFavouriteGoodsByUserID(userID);
	}

	@Override
	public List<Store> queryFavouriteStore(int userID) {
		return favouriteDao.queryFavouriteStoreByUserID(userID);
	}

	@Override
	public void deleteFavouriteCommodity(int userID, int[] commodityArray) {
		if (commodityArray != null && commodityArray.length > 0) {
			favouriteDao.delFavourite(userID, commodityArray, FavouriteType.GOODS.getValue());
		} else {

		}
	}

	@Override
	public void deleteFavouriteStore(int userID, int[] storeArray) {
		if (storeArray != null && storeArray.length > 0) {
			favouriteDao.delFavourite(userID, storeArray, FavouriteType.STORE.getValue());
		} else {

		}
	}

	@Override
	public Favourite queryFavourite(int userID, int favouriteID, int type) {
		return favouriteDao.queryFavourite(userID, favouriteID, type);
	}

	@Override
	public PageBean<Goods> queryFavouriteGoodsByPage(PageBean<Goods> page, int userID) {
		List<Goods> list = favouriteDao.queryFavouriteGoodsByPage(page, userID);
		page.setDatas(list);
		return page;
	}

	@Override
	public PageBean<Store> queryFavouriteStoreByPage(PageBean<Store> page, int userID) {
		List<Store> list = favouriteDao.queryFavouriteStoreByPage(page, userID);
		page.setDatas(list);
		return page;
	}

	@Override
	public List<Store> queryBoughtStore(int userID) {
		return favouriteDao.queryFavouriteStoreByUserID(userID);
	}

	@Override
	public void addBoughtStore(int userID, int storeID) {
		Favourite f = this.queryFavourite(userID, storeID, FavouriteType.BOUGHT_STORE.getValue());
		if (f != null)
			return;
		Favourite favourite = new Favourite();
		favourite.setUserID(userID);
		favourite.setStoreOrGoodsId(storeID);
		favourite.setType(FavouriteType.BOUGHT_STORE.getValue());
		favouriteDao.addFavourite(favourite);
	}

	@Override
	public void deleteBoughtStoree(int userID, int[] storeArray) {
		if (storeArray != null && storeArray.length > 0) {
			favouriteDao.delFavourite(userID, storeArray, FavouriteType.BOUGHT_STORE.getValue());
		} else {

		}
	}

}
