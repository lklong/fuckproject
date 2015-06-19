package com.zhigu.service.user.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SequenceConstant;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.enumconst.DealType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.constant.enumconst.OrderStatus;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.Sequence;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.dto.LogisticsDto;
import com.zhigu.mapper.AccountDetailMapper;
import com.zhigu.mapper.AccountMapper;
import com.zhigu.mapper.AddressMapper;
import com.zhigu.mapper.AgentUserMapper;
import com.zhigu.mapper.GoodsMapper;
import com.zhigu.mapper.LogisticsMapper;
import com.zhigu.mapper.LogisticsSpecialMapper;
import com.zhigu.mapper.OrderMapper;
import com.zhigu.mapper.ShoppingCartItemMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.mapper.SystemAccountMapper;
import com.zhigu.model.Account;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.Address;
import com.zhigu.model.AgentUser;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.Logistics;
import com.zhigu.model.LogisticsSpecial;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.OrderDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.ShoppingCartItem;
import com.zhigu.model.Store;
import com.zhigu.model.SystemAccount;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IFavouriteService;
import com.zhigu.service.user.IOrderService;

/**
 * 订单
 * 
 * @author zhouqibing 2014年7月17日上午10:37:47
 */
@Service
public class OrderServiceImpl implements IOrderService {
	private static final Logger logger = LogManager.getLogger(OrderServiceImpl.class);
	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private AccountDetailMapper accountDetailMapper;
	@Autowired
	private SystemAccountMapper systemAccountMapper;

	@Autowired
	private OrderMapper orderDao;
	@Autowired
	private AddressMapper addressMapper;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IFavouriteService favouriteService;
	@Autowired
	private StoreMapper storeDao;
	@Autowired
	private GoodsMapper goodsDao;
	@Autowired
	private AgentUserMapper agentUserMapper;
	@Autowired
	private ShoppingCartItemMapper cartMapper;
	@Autowired
	private LogisticsMapper logisticsMapper;
	@Autowired
	private LogisticsSpecialMapper logisticsSpecialMapper;

	@Override
	public MsgBean saveOrders(int userId, Integer addressId, List<Order> pOrders) {
		// 收货地址
		Address address = null;
		if (addressId != null) {
			address = addressMapper.selectAddressByUserIdAndId(userId, addressId);
		} else {
			// 使用默认地址
			address = addressMapper.selectDefaultAddress(userId);
		}
		if (address == null) {
			return new MsgBean(Code.FAIL, "收货地址错误", MsgLevel.ERROR);
		}
		StringBuilder addrsb = new StringBuilder();
		addrsb.append(address.getProvince()).append(address.getCity()).append(address.getDistrict()).append(address.getStreet());
		// 取出购物车中数据，并按店铺排序，便于订单生成
		List<ShoppingCartItem> cartItems = cartMapper.selectByUserId(userId, true);
		if (cartItems.isEmpty()) {
			return new MsgBean(Code.FAIL, "购物车中无选中商品", MsgLevel.ERROR);
		}
		for (ShoppingCartItem item : cartItems) {
			GoodsSku sku = goodsDao.queryGoodsSkuByID(item.getSkuId());
			Goods goods = goodsDao.queryGoodsById(sku.getGoodsId());
			item.setGoods(goods);
			item.setGoodsSku(sku);
		}
		Collections.sort(cartItems, new Comparator<ShoppingCartItem>() {
			@Override
			public int compare(ShoppingCartItem o1, ShoppingCartItem o2) {
				return o1.getGoods().getStoreId() - o2.getGoods().getStoreId();
			}
		});
		Iterator<ShoppingCartItem> cartItemsIt = cartItems.iterator();
		Order saveOrder = null;
		// 现在使用先处理完订单，再更新到数据库，减少对数据库的操作，但此方式在高并发时更新库存失败率可能比较高
		List<Order> saveOrderList = new ArrayList<Order>();
		AgentUser agentUser = null;
		// Logistics logistics = null;
		// 生产订单的购物车id，从购物车中移除
		List<Integer> deleteCartId = new ArrayList<Integer>();
		// 迭代处理购物车，生成订单
		while (cartItemsIt.hasNext()) {
			ShoppingCartItem cartItem = cartItemsIt.next();

			GoodsSku sku = cartItem.getGoodsSku();
			Goods goods = cartItem.getGoods();
			if (saveOrder == null || goods.getStoreId() != saveOrder.getStoreID()) {
				// 创建一个订单
				saveOrder = new Order();
				saveOrder.setOrderNO(Sequence.generateSeq(SequenceConstant.ORDER));
				saveOrder.setMoney(new BigDecimal(0));// 商品费
				saveOrder.setStatus(OrderStatus.ORDER_WAIT_PAY.getValue());
				saveOrder.setType(1);// ??
				saveOrder.setOrderTime(new Date());
				saveOrder.setPayableMenoy(new BigDecimal(0));
				saveOrder.setActuallyPayMenyoy(new BigDecimal(0));

				//
				saveOrder.setStoreID(goods.getStoreId());
				saveOrder.setUserID(userId);
				// 收货人
				saveOrder.setConsignee(address.getName());
				saveOrder.setPhone(address.getPhone());
				saveOrder.setPostCode(address.getPostcode());
				saveOrder.setAddress(addrsb.toString());
				// 用户订单设定数据
				Order paramOrder = null;
				for (Order p : pOrders) {
					if (p.getStoreID() == goods.getStoreId()) {
						paramOrder = p;
						break;
					}
				}
				saveOrder.setLeavelMessage(paramOrder.getLeavelMessage());
				// 代发
				agentUser = agentUserMapper.selectByAgentUserId(paramOrder.getAgentSellerID());
				saveOrder.setAgentSellerID(agentUser.getUserId());
				saveOrder.setAgentMoney(new BigDecimal(0));
				// 物流
				// logistics =
				// logisticsMapper.selectByPrimaryKey(paramOrder.getLogistics());
				saveOrder.setOrderWeight(new BigDecimal(0));
				saveOrder.setLogistics(paramOrder.getLogistics());
				saveOrder.setLogisticsMoney(new BigDecimal(0));

				// 订单商品
				saveOrder.setDetails(new ArrayList<OrderDetail>());
				// orderDao.saveOrder(saveOrder);
				saveOrderList.add(saveOrder);// 将该订单加入保存列表
			}

			if (goods.getStatus() != GoodsStatus.NORMAL.getValue()) {
				throw new ServiceException("购物车中有商品已下架，请删除后再下单");
			}
			// 库存检查、变更
			int buyAmount = cartItem.getQuantity();
			if (sku.getAmount() < buyAmount) {
				throw new ServiceException(goods.getName() + ":" + sku.getPropertyStrName() + " 库存不足");
			}
			sku.setAmount(sku.getAmount() - cartItem.getQuantity());
			int row = goodsDao.updateGoodsSku(sku);
			if (row != 1) {
				throw new ServiceException("库存更新错误，请重试");
			}

			// 订单费用计算
			// 商品费
			saveOrder.setMoney(saveOrder.getMoney().add(sku.getPrice().multiply(new BigDecimal(buyAmount))));
			// 订单重量
			saveOrder.setOrderWeight(saveOrder.getOrderWeight().add(new BigDecimal(String.valueOf(goods.getWeight())).multiply(new BigDecimal(buyAmount))));
			// 代发费
			saveOrder.setAgentMoney(saveOrder.getAgentMoney().add(new BigDecimal(buyAmount).multiply(agentUser.getAgentMoney())));

			// 订单详细
			OrderDetail orderDetail = new OrderDetail();
			// orderDetail.setOrderID(saveOrder.getID());
			orderDetail.setGoodsID(sku.getGoodsId());
			orderDetail.setGoodsName(goods.getName());
			orderDetail.setSkuID(sku.getId());
			orderDetail.setUnitPrice(sku.getPrice());
			orderDetail.setQuantity(cartItem.getQuantity());
			orderDetail.setPropertystrname(sku.getPropertyStrName());
			orderDetail.setEvaluate(false);

			// orderDao.saveOrderDetail(orderDetail);
			saveOrder.getDetails().add(orderDetail);

			deleteCartId.add(cartItem.getId());
		}
		saveOrder = null;// 置空

		String[] orderNos = new String[saveOrderList.size()];
		// 订单处理完，保存更新到数据库
		int i = 0;
		for (Order order : saveOrderList) {
			// 运费计算
			if (order.getOrderWeight().floatValue() > 0) {
				order.setLogisticsMoney(this.getExpressMoney(addressId, order.getLogistics(), order.getOrderWeight()).getLogisticsMoney());
			}
			// 订单应付金额：商品费+物流费+代发费
			BigDecimal orderPayable = new BigDecimal(0).add(order.getMoney()).add(order.getLogisticsMoney()).add(order.getAgentMoney());
			order.setPayableMenoy(orderPayable);
			orderDao.saveOrder(order);
			orderNos[i] = order.getOrderNO();
			i++;
			for (OrderDetail detail : order.getDetails()) {
				detail.setOrderID(order.getID());
				orderDao.saveOrderDetail(detail);
			}
			// 添加到用户收藏，购买过的店铺
			favouriteService.addBoughtStore(userId, order.getStoreID());
		}
		// 返回订单号

		// 购物车删除
		for (Integer id : deleteCartId) {
			cartMapper.deleteByPrimaryKey(id);
		}
		// 用户购买过收藏

		return new MsgBean(Code.SUCCESS, "订单保存成功", MsgLevel.NORMAL).setData(orderNos);
	}

	public LogisticsDto getExpressMoney(int addressId, int logisticsId, BigDecimal weight) {
		Address address = addressMapper.selectAddressByUserIdAndId(SessionHelper.getSessionUser().getUserId(), addressId);
		if (address == null) {
			throw new ServiceException("收货地址错误");
		}
		// 收货地址特殊运费设定检查
		List<LogisticsSpecial> logisticsSpecialList = logisticsSpecialMapper.selectByLogisticsId(logisticsId, address.getProvince(), null);
		LogisticsSpecial logisticsSpecial = null;
		for (LogisticsSpecial ls : logisticsSpecialList) {
			if (address.getCity().equals(ls.getCity())) {
				// 省份、城市均设定
				logisticsSpecial = ls;
				break;
			}
			if (ls.getCity() == null || ls.getCity().endsWith("")) {
				// 只有省份，无城市
				logisticsSpecial = ls;
			}
		}
		BigDecimal fweight = null;
		BigDecimal fmoney = null;
		BigDecimal cweight = null;
		BigDecimal cmoney = null;
		if (logisticsSpecial != null) {
			// 该收货地址有快递费特殊设定，使用此模板计算运输费
			fweight = logisticsSpecial.getFweight();
			fmoney = logisticsSpecial.getFmoney();
			cweight = logisticsSpecial.getCweight();
			cmoney = logisticsSpecial.getCmoney();
		} else {
			// 普通运费模板
			Logistics logistics = logisticsMapper.selectByPrimaryKey(logisticsId);
			fweight = logistics.getFweight();
			fmoney = logistics.getFmoney();
			cweight = logistics.getCweight();
			cmoney = logistics.getCmoney();
		}
		LogisticsDto dto = new LogisticsDto();
		dto.setFweight(fweight);
		dto.setFmoney(fmoney);
		dto.setCweight(cweight);
		dto.setCmoney(cmoney);
		if (fweight.compareTo(weight) < 0) {
			// 续重价：原重减掉初重/续重，向上取整
			double cWeightNum = Math.ceil(weight.subtract(fweight).divide(cweight).doubleValue());
			BigDecimal cWeightNumMoney = cmoney.multiply(new BigDecimal(String.valueOf(cWeightNum)));
			// 首重价+续重价
			dto.setLogisticsMoney(fmoney.add(cWeightNumMoney));
		} else {
			dto.setLogisticsMoney(fmoney);
		}
		return dto;
	}

	@Override
	public List<Order> queryOrders(PageBean<Order> page, OrderCondition oc) {
		page.addParas("oc", oc);
		List<Order> orderList = orderDao.queryOrdersByPage(page);
		if (orderList == null || orderList.isEmpty()) {
			return null;
		}
		for (Order o : orderList) {
			List<OrderDetail> odList = orderDao.queryOrderDetailByOrderId(o.getID());
			o.setDetails(odList);
		}
		page.setDatas(orderList);
		return orderList;
	}

	@Override
	public List<Order> queryOrders(List<Integer> ids) {
		if (ids == null || ids.isEmpty())
			return null;
		// 根据ID查询
		PageBean<Order> page = new PageBean<Order>();
		page.setPageSize(Integer.MAX_VALUE);

		OrderCondition oc = new OrderCondition();
		oc.setIds(ids);
		return this.queryOrders(page, oc);
	}

	@Override
	public Order queryOrder(Integer orderID) {
		if (orderID == null)
			return null;
		List<Integer> ids = new ArrayList<Integer>();
		ids.add(orderID);

		List<Order> orders = this.queryOrders(ids);
		if (orders != null && !orders.isEmpty())
			return orders.get(0);
		return null;
	}

	@Override
	public MsgBean handlerPaymentOrder(Integer payUserId, String[] orderNo, String payPasswd) {

		MsgBean verifyPaypasswd = accountService.verifyPaypasswd(payPasswd);
		if (verifyPaypasswd.getCode() != Code.SUCCESS) {
			return verifyPaypasswd;
		}

		StringBuilder pOrderNos = new StringBuilder();
		int size = orderNo.length;
		// 订单获取，所有订单共应付金额
		BigDecimal orderTotalPayMoney = new BigDecimal("0");
		List<Order> orderList = new ArrayList<Order>();
		for (int i = 0; i < size; i++) {
			String oNo = orderNo[i];
			Order o = orderDao.queryOrderByOrderNo(oNo);
			if (o.getStatus() != OrderStatus.ORDER_WAIT_PAY.getValue()) {
				throw new ServiceException("支付失败，订单【" + o.getOrderNO() + "】状态错误");
			}
			orderList.add(o);
			orderTotalPayMoney = orderTotalPayMoney.add(o.getPayableMenoy());
			if (i > 0) {
				pOrderNos.append(",");
			}
			pOrderNos.append(oNo);
		}
		// 账户金额扣除
		Account acc = accountMapper.queryAccountByUserId(payUserId);
		if (acc.getNormalMoney().compareTo(orderTotalPayMoney) < 0) {
			return new MsgBean(Code.FAIL, "账户金额不足", MsgLevel.NORMAL);
		}
		acc.setNormalMoney(acc.getNormalMoney().subtract(orderTotalPayMoney));
		int row = accountMapper.updateByPrimaryKey(acc);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		String flow = Sequence.generateSeq(SequenceConstant.FLOW);
		// 账户明细
		AccountDetail accDetail = new AccountDetail();
		accDetail.setSno(flow);
		accDetail.setUserId(payUserId);
		accDetail.setIncomeFlag(false);
		accDetail.setDealType(DealType.ORDER_DEAL_PAY.getValue());
		accDetail.setOriginalMoney(acc.getNormalMoney());
		accDetail.setDealMoney(orderTotalPayMoney);
		accDetail.setDealMatter(DealType.ORDER_DEAL_PAY.getName() + "【" + pOrderNos.toString() + "】");
		accDetail.setDealTime(new Date());
		int accDetailRow = accountDetailMapper.insert(accDetail);
		if (accDetailRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		// 资金到系统账户托管
		SystemAccount systemAcc = new SystemAccount();
		systemAcc.setCreateTime(new Date());
		systemAcc.setSno(flow);
		systemAcc.setMoney(orderTotalPayMoney);
		systemAcc.setIncomeFlag(true);
		systemAcc.setUserId(payUserId);
		systemAcc.setMatter(DealType.ORDER_DEAL_PAY.getName() + "【" + pOrderNos.toString() + "】");
		int systemAccRow = systemAccountMapper.insert(systemAcc);
		if (systemAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		// 支付完成后更新订单状态
		for (Order o : orderList) {
			o.setActuallyPayMenyoy(o.getPayableMenoy());
			o.setStatus(OrderStatus.ORDER_WAIT_SEND.getValue());
			int orderRow = orderDao.updateOrderPaySuccess(o);
			if (orderRow != 1) {
				throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
			}
		}
		return new MsgBean(Code.SUCCESS, "你已成功支付【" + pOrderNos.toString() + "】，共计金额：" + orderTotalPayMoney.floatValue() + " 元", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean handlerCancelOrder(String orderNo, int userId) {
		Order order = orderDao.queryOrderByOrderNo(orderNo);
		if (order == null || order.getUserID() != userId) {
			return new MsgBean(Code.FAIL, "订单不存在", MsgLevel.ERROR);
		}
		// 发货之前可以取消订单
		String success = "订单取消成功";
		if (order.getStatus() == OrderStatus.ORDER_WAIT_PAY.getValue()) {
			// 未付款

		} else if (order.getStatus() == OrderStatus.ORDER_WAIT_SEND.getValue()) {
			Date now = new Date();
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(order.getOrderTime());
			System.out.println(calendar.get(Calendar.DAY_OF_MONTH));// 今天的日期
			calendar.add(Calendar.HOUR, 6);
			if (now.getTime() > calendar.getTime().getTime()) {
				return new MsgBean(Code.FAIL, "取消失败：订单支付后只能在6个小时内取消", MsgLevel.ERROR);
			}

			// 已付款状态，金额退回
			Account userAcc = accountMapper.queryAccountByUserId(order.getUserID());
			// 账户明细
			AccountDetail accDetail = new AccountDetail();
			accDetail.setSno(Sequence.generateSeq(SequenceConstant.FLOW));
			accDetail.setUserId(userAcc.getUserId());
			accDetail.setIncomeFlag(true);
			accDetail.setDealType(DealType.ORDER_DEAL_REFUND.getValue());
			accDetail.setOriginalMoney(userAcc.getNormalMoney());
			accDetail.setDealMoney(order.getActuallyPayMenyoy());
			accDetail.setDealMatter(DealType.ORDER_DEAL_REFUND.getName() + "【" + order.getOrderNO() + "】");
			accDetail.setDealTime(new Date());
			accountDetailMapper.insert(accDetail);

			userAcc.setNormalMoney(userAcc.getNormalMoney().add(order.getActuallyPayMenyoy()));
			int row = accountMapper.updateByPrimaryKey(userAcc);
			if (row != 1) {
				throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
			}
			success = "订单取消成功，退还金额：" + accDetail.getDealMoney().floatValue();

			// 资金从系统账户扣除
			SystemAccount systemAcc = new SystemAccount();
			systemAcc.setCreateTime(new Date());
			systemAcc.setSno(Sequence.generateSeq(SequenceConstant.FLOW));
			systemAcc.setMoney(order.getActuallyPayMenyoy());
			systemAcc.setIncomeFlag(false);
			systemAcc.setUserId(order.getUserID());
			systemAcc.setMatter(DealType.ORDER_DEAL_REFUND.getName() + "【" + order.getOrderNO() + "】");
			int systemAccRow = systemAccountMapper.insert(systemAcc);
			if (systemAccRow != 1) {
				throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
			}
		} else {
			// 其他订单状态
			return new MsgBean(Code.FAIL, "取消失败，订单状态错误", MsgLevel.ERROR);
		}
		order.setStatus(OrderStatus.ORDER_CLOSE.getValue());
		int row = orderDao.updateOrderStatus(order);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		// 商品库存退回,改sku因商品修改而删除不能退回暂时不考虑
		try {
			List<OrderDetail> orderDetails = orderDao.queryOrderDetailByOrderId(order.getID());
			for (OrderDetail od : orderDetails) {
				GoodsSku gs = goodsDao.queryGoodsSkuByID(od.getSkuID());
				gs.setAmount(gs.getAmount() + od.getQuantity());
				goodsDao.updateGoodsSku(gs);
			}
		} catch (Exception e) {
			logger.warn("订单取消，商品退回错误", e);
		}
		return new MsgBean(Code.SUCCESS, success, MsgLevel.NORMAL);
	}

	// 收货
	@Override
	public MsgBean handlerConfirmReceipt(Integer userID, Integer orderID) {
		// Map<String, Object> map = orderDao.confirmReceipt(userID, orderID);
		// int flag = (int) map.get("flag");
		// if (flag == 1) {
		// return new MsgBean(Code.FAIL, (String) map.get("msg"),
		// MsgLevel.ERROR);
		// }
		// return new MsgBean(Code.SUCCESS, "订单确认收货完成", MsgLevel.NORMAL);

		Order order = orderDao.queryOrderByID(orderID);
		if (order == null) {
			return new MsgBean(Code.FAIL, "订单不存在", MsgLevel.ERROR);
		}
		if (order.getStatus() != OrderStatus.ORDER_WAIT_CONFIRM_RECEIVE_GOODS.getValue()) {
			return new MsgBean(Code.FAIL, "订单状态错误，请确认", MsgLevel.ERROR);
		}
		if (order.getUserID() != userID) {
			throw new ServiceException("非法操作");
		}

		// 订单状态变更
		order.setStatus(OrderStatus.ORDER_SUCCESS.getValue());
		int row = orderDao.updateOrderStatus(order);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		String flowNo = Sequence.generateSeq(SequenceConstant.FLOW);
		// 代发商账户（代发费结算）
		Account agentAcc = accountMapper.queryAccountByUserId(order.getAgentSellerID());
		// 代发商收入：代发费 + 物流费
		BigDecimal agentAccDealMoney = order.getAgentMoney().add(order.getLogisticsMoney());
		if (agentAcc != null && agentAccDealMoney.floatValue() > 0) {
			// 账户明细
			AccountDetail agentAccDetail = new AccountDetail();
			agentAccDetail.setSno(flowNo);
			agentAccDetail.setUserId(agentAcc.getUserId());
			agentAccDetail.setIncomeFlag(true);
			agentAccDetail.setDealType(DealType.ORDER_DEAL_INCOME_AGENT.getValue());
			agentAccDetail.setOriginalMoney(agentAcc.getNormalMoney());
			agentAccDetail.setDealMoney(agentAccDealMoney);
			agentAccDetail.setDealMatter(DealType.ORDER_DEAL_INCOME_AGENT.getName() + "【" + order.getOrderNO() + "】");
			agentAccDetail.setDealTime(new Date());
			accountDetailMapper.insert(agentAccDetail);
			// 代发商账户金额
			agentAcc.setNormalMoney(agentAcc.getNormalMoney().add(agentAccDealMoney));
			int agentAccRow = accountMapper.updateByPrimaryKey(agentAcc);
			if (agentAccRow != 1) {
				throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
			}
		}

		// 供货商账户(商品费结算)
		Store store = storeDao.queryStoreByID(order.getStoreID());
		Account supplierAcc = accountMapper.queryAccountByUserId(store.getUserID());
		// 账户明细
		AccountDetail supplierAccDetail = new AccountDetail();
		supplierAccDetail.setSno(flowNo);
		supplierAccDetail.setUserId(supplierAcc.getUserId());
		supplierAccDetail.setIncomeFlag(true);
		supplierAccDetail.setDealType(DealType.ORDER_DEAL_INCOME.getValue());
		supplierAccDetail.setOriginalMoney(supplierAcc.getNormalMoney());
		supplierAccDetail.setDealMoney(order.getMoney());
		supplierAccDetail.setDealMatter(DealType.ORDER_DEAL_INCOME.getName() + "【" + order.getOrderNO() + "】");
		supplierAccDetail.setDealTime(new Date());
		accountDetailMapper.insert(supplierAccDetail);
		// 供货商收入：用户订单实付款 - 代发费
		BigDecimal incomeMoney = order.getActuallyPayMenyoy().subtract(agentAccDealMoney);
		supplierAcc.setNormalMoney(supplierAcc.getNormalMoney().add(incomeMoney));
		int supplierAccRow = accountMapper.updateByPrimaryKey(supplierAcc);
		if (supplierAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		// 资金从系统账户扣除
		SystemAccount systemAcc = new SystemAccount();
		systemAcc.setCreateTime(new Date());
		systemAcc.setSno(flowNo);
		systemAcc.setMoney(order.getActuallyPayMenyoy());
		systemAcc.setIncomeFlag(false);
		systemAcc.setUserId(order.getUserID());
		systemAcc.setMatter(DealType.ORDER_DEAL_PAY.getName() + "【" + order.getOrderNO() + "】");
		int systemAccRow = systemAccountMapper.insert(systemAcc);
		if (systemAccRow != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		// 订单物流信息写入订单？

		return new MsgBean(Code.SUCCESS, "订单确认收货成功", MsgLevel.NORMAL);
	}

	@Override
	public Map<String, Object> queryStatusCount(Integer userID, Integer userType) {
		return orderDao.queryStatusCount(userID, userType);
	}

	@Override
	public void updateOrder(Order order) {
		orderDao.updateOrder(order);
	}

	@Override
	public boolean isBuyGoods(int goods, int userID) {
		return orderDao.isBuyGoods(goods, userID);
	}

	@Override
	public Order queryOrderByOrderNo(String orderNo) {
		Order o = orderDao.queryOrderByOrderNo(orderNo);
		List<OrderDetail> odList = orderDao.queryOrderDetailByOrderId(o.getID());
		o.setDetails(odList);
		return o;
	}

	@Override
	public MsgBean modifyMoney(Integer oid, String money, boolean isAdmin) {
		if (oid == null || !VerifyUtil.isMoney(money)) {
			return new MsgBean(Code.FAIL, "参数错误", MsgLevel.ERROR);
		}
		Order order = orderDao.queryOrderByID(oid);
		if (order == null) {
			return new MsgBean(Code.FAIL, "未找到订单", MsgLevel.ERROR);
		}
		// 所有者检查
		if (!isAdmin) {
			if (order.getStoreUserID() != SessionHelper.getSessionUser().getUserId()) {
				throw new ServiceException("只有卖家才能修改金额！");
			}
		}
		if (order.getStatus() != OrderStatus.ORDER_WAIT_PAY.getValue()) {
			return new MsgBean(Code.FAIL, "修改失败，该订单状态已改变", MsgLevel.ERROR);
		}
		BigDecimal newOrderMoney = new BigDecimal(money);
		if (newOrderMoney.floatValue() < order.getPayableMenoy().floatValue() * 0.7) {
			// 金额修改保护
			return new MsgBean(Code.FAIL, "修改失败，修改后的订单金额不能小于原订单金额的70%", MsgLevel.ERROR);
		}
		if (newOrderMoney.floatValue() < order.getLogisticsMoney().add(order.getActuallyPayMenyoy()).floatValue()) {
			return new MsgBean(Code.FAIL, "修改失败，修改后的订单金额不足以支付代发/快递费", MsgLevel.ERROR);
		}
		order.setPayableMenoy(newOrderMoney);
		int row = orderDao.updateOrderMoney(order);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "订单金额修改成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean handlerGoodsSendConfirm(int orderID, String expressNo, boolean isAgent) {
		Order order = orderDao.queryOrderByID(orderID);
		if (order == null) {
			return new MsgBean(Code.FAIL, "订单不存在！", MsgLevel.ERROR);
		}
		if (isAgent) {
			// 此处代发商为现后台管理用户
			if (SessionHelper.getSessionAdmin() == null) {
				return new MsgBean(Code.FAIL, "订单不存在！", MsgLevel.ERROR);
			}
		} else {
			// 供货处理发货
			Store store = storeDao.queryStoreByID(order.getStoreID());
			if (store.getUserID() != SessionHelper.getSessionUser().getUserId()) {
				return new MsgBean(Code.FAIL, "非法操作！", MsgLevel.ERROR);
			}
		}

		if (order.getStatus() != OrderStatus.ORDER_WAIT_SEND.getValue()) {
			return new MsgBean(Code.FAIL, "订单状态错误", MsgLevel.ERROR);
		}
		order.setLogisticsNO(expressNo);
		order.setStatus(OrderStatus.ORDER_WAIT_CONFIRM_RECEIVE_GOODS.getValue());
		int row = orderDao.updateOrderStatus(order);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "处理成功", MsgLevel.NORMAL);
	}

	@Override
	public List<AgentUser> queryAllAgentUser() {
		return agentUserMapper.selectAll();
	}

	@Override
	public List<Logistics> queryAllLogistics() {
		return logisticsMapper.selectAll();
	}

	@Override
	public int queryOrderCountByUserID(int userID) {

		return orderDao.queryOrderCountByUserID(userID);
	}

	@Override
	public int updateOrderDelFlagByOrderID(Integer orderID, boolean deleteFlag) {

		return orderDao.updateOrderDelFlagByOrderID(orderID, deleteFlag);
	}

}
