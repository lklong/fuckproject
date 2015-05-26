package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.ShoppingCart;
import com.zhigu.model.dto.MsgBean;

public interface ICartService {
	/**
	 * 购物车列表
	 * 
	 * @param userID
	 * @return
	 */
	public List<ShoppingCart> queryShoppingCart(Integer userId, Boolean checked);

	/**
	 * 保存购物车
	 * 
	 * @param items
	 * @return 购物车id:数量
	 */
	public MsgBean addShoppingCartItem(Integer skuId, Integer quantity);

	/**
	 * 修改购物车选中状态
	 * 
	 * @param id
	 * @param isChecked
	 */
	public MsgBean updateCartChecked(int id, Boolean checked);

	/**
	 * 修改购物车中商品数
	 * 
	 * @param id
	 * @param quantity
	 */
	public MsgBean updateCartGoodsQuantity(int id, int quantity);

	/**
	 * 删除多个购物车商品
	 * 
	 * @param userID
	 * @param ids
	 */
	public MsgBean deleteShoppingCart(Integer... ids);

	/**
	 * 系统自动删除购物车
	 * 
	 * @param date
	 *            YYYY-mm-dd
	 * @return
	 */
	public int systemDeleteBeforeByDate(String date);

	/**
	 * 根据userID统计购物车商品数量
	 * 
	 * @param userID
	 * @return
	 */
	public int countNumByUserId(int userID);

}
