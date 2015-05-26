package com.zhigu.service.user.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.mapper.GoodsMapper;
import com.zhigu.mapper.ShoppingCartItemMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.ShoppingCart;
import com.zhigu.model.ShoppingCartItem;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.ICartService;

@Service
public class CartServiceImpl implements ICartService {
	@Autowired
	private ShoppingCartItemMapper cartItemMapper;
	@Autowired
	private GoodsMapper goodsMapper;
	@Autowired
	private StoreMapper storeMapper;

	/** 购物车最多可放商品数 */
	private static final int SHOPPING_CART_MAX_NUM = 20;

	@Override
	public List<ShoppingCart> queryShoppingCart(Integer userId, Boolean checked) {
		List<ShoppingCart> cartList = new ArrayList<ShoppingCart>();
		List<ShoppingCartItem> cartItems = cartItemMapper.selectByUserId(userId, checked);

		ShoppingCart cart = null;
		for (ShoppingCartItem item : cartItems) {
			// 查询店铺，商品，sku等信息
			GoodsSku sku = goodsMapper.queryGoodsSkuByID(item.getSkuId());
			if (sku == null) {
				// 购物车中不存在的商品sku
				cartItemMapper.deleteByPrimaryKey(item.getId());
				continue;
			}
			Goods goods = goodsMapper.queryGoodsById(sku.getGoodsId());
			if (goods == null) {
				// 购物车中不存在的商品sku
				cartItemMapper.deleteByPrimaryKey(item.getId());
				continue;
			}
			if (cart == null || cart.getStoreId() != goods.getStoreId()) {
				cart = new ShoppingCart();
				// 店铺信息
				Store store = storeMapper.queryStoreByID(goods.getStoreId());
				cart.setStoreId(store.getID());
				cart.setAliWangWang(store.getAliWangWang());
				cart.setItem(new ArrayList<ShoppingCartItem>());
				cart.setQQ(store.getQQ());
				cart.setStoreName(store.getStoreName());

				cartList.add(cart);
			}
			item.setGoods(goods);
			item.setGoodsSku(sku);

			cart.getItem().add(item);
		}
		return cartList;
	}

	@Override
	public MsgBean addShoppingCartItem(Integer skuId, Integer quantity) {
		GoodsSku sku = goodsMapper.queryGoodsSkuByID(skuId);
		if (sku == null) {
			return new MsgBean(Code.FAIL, "未找到该商品", MsgLevel.ERROR);
		}
		if (sku.getAmount() < quantity) {
			return new MsgBean(Code.FAIL, "商品库存不足", MsgLevel.ERROR);
		}
		int userId = SessionHelper.getSessionUser().getUserID();

		ShoppingCartItem item = cartItemMapper.selectByUserIdAndSkuId(userId, skuId);
		if (item != null) {
			item.setQuantity(item.getQuantity() + quantity);
			cartItemMapper.updateByPrimaryKey(item);
		} else {
			int hasNum = cartItemMapper.countNumByUserId(userId);
			if (hasNum >= SHOPPING_CART_MAX_NUM) {
				return new MsgBean(Code.FAIL, "购物车最多可放" + SHOPPING_CART_MAX_NUM + "个商品", MsgLevel.ERROR);
			}
			item = new ShoppingCartItem();
			item.setSkuId(skuId);
			item.setQuantity(quantity);
			item.setUserId(userId);
			item.setPutTime(new Date());
			item.setChecked(true);
			cartItemMapper.insert(item);
		}
		return new MsgBean(Code.SUCCESS, "商品成功加入购物车", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean updateCartChecked(int id, Boolean checked) {
		ShoppingCartItem item = cartItemMapper.selectByPrimaryKey(id);
		if (item == null || item.getUserId() != SessionHelper.getSessionUser().getUserID()) {
			return new MsgBean(Code.FAIL, "购物车中无该商品", MsgLevel.ERROR);
		}
		item.setChecked(checked);
		cartItemMapper.updateByPrimaryKey(item);
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean updateCartGoodsQuantity(int id, int quantity) {
		if (quantity < 1) {
			return new MsgBean(Code.FAIL, "商品数量不能小于1 ", MsgLevel.ERROR);
		}
		ShoppingCartItem item = cartItemMapper.selectByPrimaryKey(id);
		if (item == null || item.getUserId() != SessionHelper.getSessionUser().getUserID()) {
			return new MsgBean(Code.FAIL, "购物车中无该商品", MsgLevel.ERROR);
		}
		GoodsSku sku = goodsMapper.queryGoodsSkuByID(item.getSkuId());
		if (sku.getAmount() < quantity) {
			return new MsgBean(Code.FAIL, "库存不足，剩余库存：" + sku.getAmount(), MsgLevel.ERROR);
		}
		item.setQuantity(quantity);
		cartItemMapper.updateByPrimaryKey(item);
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean deleteShoppingCart(Integer... ids) {
		if (ids != null && ids.length > 0) {
			// 可考虑使用SQL直接删
			for (Integer id : ids) {
				ShoppingCartItem item = cartItemMapper.selectByPrimaryKey(id);
				if (item == null || item.getUserId() != SessionHelper.getSessionUser().getUserID()) {
					// return new MsgBean(Code.FAIL, "购物车中无该商品",
					// MsgLevel.ERROR);
					continue;
				}
				cartItemMapper.deleteByPrimaryKey(id);
			}
		}
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public int systemDeleteBeforeByDate(String date) {
		return cartItemMapper.systemDeleteBeforeByDate(date);
	}

	@Override
	public int countNumByUserId(int userID) {
		return cartItemMapper.countNumByUserId(userID);
	}

}
