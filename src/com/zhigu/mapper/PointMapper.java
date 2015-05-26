package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.PageBean;
import com.zhigu.model.PointExchangeGoods;
import com.zhigu.model.UserPoint;

/**
 * 积分点
 * 
 * @author HeSiMin
 * @date 2014年12月9日
 *
 */
public interface PointMapper {
	/**
	 * 查询用户积分（for update）
	 * 
	 * @param userID
	 * @return
	 */
	public UserPoint queryUserPointForUpdate(int userID);

	/**
	 * 保存积分商品
	 * 
	 * @param pointExchangeGoods
	 * @return
	 */
	public int savePointExchangeGoods(PointExchangeGoods pointExchangeGoods);

	/**
	 * 修改积分商品状态
	 * 
	 * @param pointExchangeGoods
	 * @return
	 */
	public int updatePointExchangeGoodsStatus(PointExchangeGoods pointExchangeGoods);

	/**
	 * 修改积分商品数量
	 * 
	 * @param pointExchangeGoods
	 * @return
	 */
	public int updatePointExchangeGoodsRepertory(PointExchangeGoods pointExchangeGoods);

	/**
	 * 查询积分商品
	 * 
	 * @param id
	 * @return
	 */
	public PointExchangeGoods queryPointExchangeGoodsByIdForUpdate(int id);

	public PointExchangeGoods queryPointExchangeGoodsById(int id);

	/**
	 * 查询积分商品
	 * 
	 * @param page
	 * @return
	 */
	public List<PointExchangeGoods> queryPointExchangeGoods(PageBean<PointExchangeGoods> page);

	public List<PointExchangeGoods> queryCanBuyPointExchangeGoods(PageBean<PointExchangeGoods> page);

	public int updatePointExchangeGoods(PointExchangeGoods pointExchangeGoods);

	/**
	 * 查询积分商品
	 * 
	 * @param pointGoodsID
	 * @return
	 */
	public PointExchangeGoods queryPointGoodsByID(int pointGoodsID);
}
