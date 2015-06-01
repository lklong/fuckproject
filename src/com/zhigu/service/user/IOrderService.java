package com.zhigu.service.user;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.zhigu.dto.LogisticsDto;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;

/**
 * 购物车
 * 
 * @author zhouqibing 2014年7月17日上午10:25:52
 */
public interface IOrderService {

	/**
	 * 保存订单
	 * 
	 * @param userId
	 * @param address
	 * @param orders
	 * @return MsgBean.data 返回订单id（String[]）
	 */
	public MsgBean saveOrders(int userId, Integer addressId, List<Order> orders);

	/**
	 * 计算运费
	 * 
	 * @param addressId
	 * @param logisticsId
	 * @param weight
	 * @return
	 */
	public LogisticsDto getExpressMoney(int addressId, int logisticsId, BigDecimal weight);

	/**
	 * 订单列表
	 * 
	 * @param page
	 * @param oc
	 * @return
	 */
	public List<Order> queryOrders(PageBean<Order> page, OrderCondition oc);

	/**
	 * 订单ID查询订单信息，调用者判断是否是有权访问
	 * 
	 * @param ids
	 * @return
	 */
	public List<Order> queryOrders(List<Integer> ids);

	/**
	 * 订单号查订单
	 * 
	 * @param orderNo
	 * @return
	 */
	public Order queryOrderByOrderNo(String orderNo);

	/**
	 * 订单ID查询订单信息
	 * 
	 * @param orderIDs
	 * @return
	 */
	public Order queryOrder(Integer orderID);

	/**
	 * 发货
	 * 
	 * @param orderID
	 * @param isAgent
	 *            true:代发商确认发货 false:供货商确认发货
	 * @param expressNo
	 *            快递号
	 * @return
	 */
	public MsgBean handlerGoodsSendConfirm(int orderID, String expressNo, boolean isAgent);

	/**
	 * 处理用户取消订单
	 * 
	 * @param orderID
	 * @return
	 */
	public MsgBean handlerCancelOrder(String orderNo, int userId);

	/**
	 * 处理订单支付
	 * 
	 * @param payUserID
	 *            付款人
	 * @param orderNo
	 * @return
	 */
	public MsgBean handlerPaymentOrder(Integer payUserID, String[] orderNo, String payPasswd);

	/**
	 * 处理收货
	 * 
	 * @param userID
	 * @param orderID
	 * @return
	 */
	public MsgBean handlerConfirmReceipt(Integer userID, Integer orderID);

	/**
	 * 查询订单状态统计
	 * 
	 * @param oc
	 * @return
	 */
	public Map<String, Object> queryStatusCount(Integer userID, Integer userType);

	/**
	 * 修改订单信息(此方法将修改如下数据）
	 * 
	 * @param order
	 *            Money,Status,AgentMoney,Logistics,LogisticsMoney,LogisticsNO,
	 *            LogisticsProgress
	 */
	public void updateOrder(Order order);

	/**
	 * 修改订单删除标示 对订单进行逻辑删除
	 * 
	 * @param orderID
	 * @param deleteFlag
	 */
	public int updateOrderDelFlagByOrderID(Integer orderID, boolean deleteFlag);

	/**
	 * 修改订单价格
	 * 
	 * @param oid
	 * @param money
	 * @param isAdmin
	 *            true:不做订单所有者检查
	 * @return
	 */
	public MsgBean modifyMoney(Integer oid, String money, boolean isAdmin);

	/**
	 * 是否购买指定商品，交易完成才算购买
	 * 
	 * @param goods
	 * @param userID
	 * @return
	 */
	public boolean isBuyGoods(int goods, int userID);

	public List<com.zhigu.model.AgentUser> queryAllAgentUser();

	public List<com.zhigu.model.Logistics> queryAllLogistics();

	/**
	 * 根据userID查询订单数量
	 * 
	 * @param userID
	 * @return
	 */
	public int queryOrderCountByUserID(int userID);

}
