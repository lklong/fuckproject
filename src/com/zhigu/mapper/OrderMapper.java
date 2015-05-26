package com.zhigu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Order;
import com.zhigu.model.OrderDetail;
import com.zhigu.model.PageBean;

/**
 * 购物车
 * 
 * @author zhouqibing 2014年7月17日上午10:36:52
 */
public interface OrderMapper {

	/**
	 * 保存订单
	 * 
	 * @param order
	 * @return
	 */
	public int saveOrder(Order order);

	/**
	 * 订单支付
	 * 
	 * @param userID
	 * @param ids
	 * @return
	 */
	public Map<String, Object> paymentOrder(@Param("pUserID") int userID, @Param("pOrderNo") String pOrderNo);

	/**
	 * 订单列表
	 * 
	 * @param page
	 * @param oc
	 * @return
	 */
	public List<Order> queryOrdersByPage(PageBean<Order> page);

	/**
	 * 订单号查订单
	 * 
	 * @param orderNo
	 * @return
	 */
	public Order queryOrderByOrderNo(String orderNo);

	public List<OrderDetail> queryOrderDetailByOrderId(int orderId);

	/**
	 * 更新订单状态
	 * 
	 * @param order
	 */
	public int updateOrderStatus(Order order);

	/**
	 * 序号生成，不同类型将得到不同的自增序号
	 * 
	 * @param type
	 * @param length
	 *            返回的序号长度，序号不够长度左边0填充，0表示不填充<br>
	 *            length = 5 --> 00001<br>
	 *            length = 0 --> 1
	 * @return
	 */
	public String sequence(@Param("type") int type, @Param("length") int length);

	/**
	 * 查询订单状态统计
	 * 
	 * @param oc
	 * @return
	 */
	public Map<String, Object> queryStatusCount(@Param("userID") Integer userID, @Param("userType") Integer userType);

	/**
	 * 修改订单信息
	 * 
	 * @param order
	 * @deprecated 仅更新数字段
	 */
	public int updateOrder(Order order);

	/**
	 * 修改订单删除标示 对订单进行逻辑删除
	 * 
	 * @param orderID
	 * @param deleteFlag
	 */
	public int updateOrderDelFlagByOrderID(@Param("orderID") Integer orderID, @Param("deleteFlag") boolean deleteFlag);

	public int updateOrderPaySuccess(Order order);

	/**
	 * 查询购物车商品数
	 * 
	 * @param userID
	 * @return
	 */
	public Integer queryShoppingCartGoodsCount(int userID);

	/**
	 * 是否购买指定商品，交易完成才算购买
	 * 
	 * @param goods
	 * @param userID
	 * @return
	 */
	public boolean isBuyGoods(@Param("goodsId") int goods, @Param("userId") int userID);

	/**
	 * 查询订单详情
	 * 
	 * @param userID
	 * @param odId
	 * @return
	 */
	public OrderDetail queryOrderDetail(@Param("userId") int userID, @Param("odId") int odId);

	/**
	 * 修改订单详情评论
	 * 
	 * @param od
	 */
	public int updateOrderDetailEval(int oid);

	/**
	 * 查询订单
	 * 
	 * @param id
	 * @return
	 */
	public Order queryOrderByID(int id);

	/**
	 * 根据userID查询订单数量
	 * 
	 * @param userID
	 * @return
	 */
	public int queryOrderCountByUserID(int userID);

	/**
	 * 修改订单金额
	 * 
	 * @param order
	 * @return
	 */
	public int updateOrderMoney(Order order);

	/**
	 * 保存订单详情
	 * 
	 * @param orderDetail
	 * @return
	 */
	public int saveOrderDetail(OrderDetail orderDetail);

	/**
	 * 更新订单详情中商品的评论状态
	 * 
	 * @param orderId
	 *            订单id
	 * @param goodsId
	 *            商品id
	 * @return
	 */
	int updateOrderDetailByGoodsIdAndOrderId(@Param("orderId") int orderId, @Param("goodsId") int goodsId);
}
