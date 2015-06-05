package com.zhigu.controllers.user;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.constant.enumconst.OrderStatus;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.AgentUser;
import com.zhigu.model.Logistics;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.OrderDetail;
import com.zhigu.model.PageBean;
import com.zhigu.model.ShoppingCart;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsEvaluateService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IAddressService;
import com.zhigu.service.user.ICartService;
import com.zhigu.service.user.IOrderService;
import com.zhigu.service.user.IUserService;

/**
 * 购物车
 * 
 * @author zhouqibing 2014年7月17日上午10:22:36
 */
@Controller
@RequestMapping("/user/order")
public class OrderController {

	@Autowired
	private IOrderService orderService;
	@Autowired
	private IAddressService shippingAddressService;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IGoodsEvaluateService goodsEvaluateService;
	@Autowired
	private ICartService cartService;
	/** 加密key */
	private static final String RANDOM_KEY = "a)=d]f/*-+,r[;zd#4y1zzbrreye&wrt";

	/**
	 * 订单列表
	 * 
	 * @param mv
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("")
	public ModelAndView orderList(ModelAndView mv, OrderCondition oc, String startDateStr, String endDateStr, PageBean<Order> page) throws ParseException {
		page.setPageSize(5);

		oc.setUserID(SessionHelper.getSessionUser().getUserID());
		oc.setUserType(UserType.USER);
		if (StringUtils.isNotBlank(startDateStr)) {
			oc.setStartDate(DateUtils.parseDate(startDateStr, "yyyy-MM-dd"));
		}
		if (StringUtils.isNotBlank(endDateStr)) {
			oc.setEndDate(DateUtils.parseDate(endDateStr, "yyyy-MM-dd"));
		}

		orderService.queryOrders(page, oc);
		mv.addObject("page", page);
		mv.addObject("orders", page.getDatas());
		mv.addObject("oc", oc);
		mv.addObject("nowTime", System.currentTimeMillis());
		mv.setViewName("user/order/list");
		return mv;
	}

	/**
	 * 订单确认
	 * 
	 * @return
	 */
	@RequestMapping(value = "/confirm", method = RequestMethod.GET)
	public ModelAndView confirmOrder(ModelAndView mv) {
		int userId = SessionHelper.getSessionUser().getUserID();
		// 收货地址
		// List<Address> address =
		// shippingAddressService.queryAddressByUserID(userId);
		// mv.addObject("addresses", address);

		List<ShoppingCart> shoppingCarts = cartService.queryShoppingCart(userId, true);

		List<AgentUser> agentUsers = orderService.queryAllAgentUser();
		mv.addObject("agentUsers", agentUsers);

		List<Logistics> logistics = orderService.queryAllLogistics();
		mv.addObject("logistics", logistics);

		mv.addObject("shoppingCarts", shoppingCarts);
		mv.setViewName("user/order/confirm");
		return mv;
	}

	@RequestMapping(value = "/confirm", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean confirmOrder(String ordersJson, Integer addressId) {
		// if (club == null || club.getOrders() == null ||
		// club.getOrders().isEmpty()) {
		// return new MsgBean(Code.FAIL, "请检查提交的商品是否存在！", MsgLevel.ERROR);
		// }
		// List<Order> orders = club.getOrders();
		List<Order> orders = JSON.parseArray(ordersJson, Order.class);
		return orderService.saveOrders(SessionHelper.getSessionUser().getUserID(), addressId, orders);
	}

	/**
	 * 获取运费计算
	 * 
	 * @param addressId
	 * @param logisticsId
	 * @param weight
	 * @return
	 */
	@RequestMapping("/getLogisticsMoney")
	@ResponseBody
	public MsgBean getLogisticsMoney(Integer addressId, Integer logisticsId, BigDecimal weight) {
		if (addressId == null) {
			return new MsgBean(Code.FAIL, "请选择收货地址", MsgLevel.ERROR);
		}
		if (logisticsId == null) {
			return new MsgBean(Code.FAIL, "请选择配送方式", MsgLevel.ERROR);
		}
		MsgBean msg = new MsgBean(Code.SUCCESS, "ok", MsgLevel.NORMAL);
		msg.setData(orderService.getExpressMoney(addressId, logisticsId, weight));
		return msg;
	}

	/**
	 * 订单详情
	 * 
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/detail")
	public ModelAndView detail(ModelAndView mv, Integer orderID) {
		mv.setViewName("/user/order/detail");
		// 非自己订单不显示，商家暂不考虑
		Order order = orderService.queryOrder(orderID);
		if (order != null && order.getUserID() == SessionHelper.getSessionUser().getUserID()) {
			mv.addObject("order", order);
			mv.addObject("store", storeService.queryStoreByID(order.getStoreID()));
		}
		return mv;
	}

	/**
	 * 支付
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/pay")
	public ModelAndView pay(ModelAndView mv, String[] orderNo) {
		int userID = SessionHelper.getSessionUser().getUserID();
		if (orderNo == null || orderNo.length == 0) {
			throw new ServiceException("未找到订单");
		}
		List<Order> orders = new ArrayList<Order>();
		for (String no : orderNo) {
			Order o = orderService.queryOrderByOrderNo(no);
			if (o == null) {
				throw new ServiceException("未找到订单：" + no);
			}
			if (o.getStatus() == OrderStatus.ORDER_WAIT_PAY.getValue()) {
				orders.add(o);
			}
		}
		int orderSize = orders.size();
		if (orderSize == 0) {
			throw new ServiceException("没找到需要支付的订单，请确认");
		}
		StringBuilder payName = new StringBuilder();
		payName.append("支付订单：");
		BigDecimal totalOrderMoney = new BigDecimal(0);// 总金额
		for (int i = 0; i < orderSize; i++) {
			Order o = orders.get(i);
			if (o.getUserID() != userID) {
				throw new ServiceException("存在不属于自己的订单！订单号：" + o.getOrderNO());
			}
			totalOrderMoney = totalOrderMoney.add(o.getPayableMenoy());
			payName.append(o.getOrderNO());
			if (i != orderSize) {
				payName.append("、");
			}
		}
		// 帐户信息
		mv.addObject("acc", accountService.queryAccountByUserID(userID));
		mv.addObject("totalPayMoney", totalOrderMoney);
		mv.addObject("payName", payName.toString());
		mv.addObject("orders", orders);
		// 生成key用于数据验证
		Arrays.sort(orderNo);
		mv.addObject("key", Md5.convert(Arrays.toString(orderNo) + RANDOM_KEY));
		mv.setViewName("user/order/pay");
		return mv;
	}

	/**
	 * 提交订单支付
	 * 
	 * @param mv
	 * @param paymentPwd
	 * @param orderID
	 * @param attr
	 * @return
	 */
	@RequestMapping(value = "/pay/submit", method = RequestMethod.POST)
	public ModelAndView submitPay(ModelAndView mv, String payPasswd, String[] orderNo, String key, RedirectAttributes attr) {
		// key 验证
		Arrays.sort(orderNo);
		String ckey = Md5.convert(Arrays.toString(orderNo) + RANDOM_KEY);
		if (!ckey.equals(key)) {
			throw new ServiceException("数据验证错误");
		}
		payPasswd = StringUtil.decryptBASE64(payPasswd);
		MsgBean msgBean = orderService.handlerPaymentOrder(SessionHelper.getSessionUser().getUserID(), orderNo, payPasswd);
		if (msgBean.getCode() == Code.FAIL) {
			attr.addFlashAttribute("msg", msgBean.getMsg());
			StringBuilder urlParams = new StringBuilder();
			int orderNoSize = orderNo.length;
			for (int i = 0; i < orderNoSize; i++) {
				if (i > 0) {
					urlParams.append("&");
				}
				urlParams.append("orderNo=").append(orderNo[i]);
			}
			mv.setViewName("redirect:/user/order/pay?" + urlParams.toString());// 重定向到支付页面
			return mv;
		}
		mv.addObject("msgBean", msgBean);
		mv.setViewName("/user/order/paysuccess");
		return mv;
	}

	/**
	 * 取消订单
	 * 
	 * @param mv
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/cancel")
	@ResponseBody
	public MsgBean cancelOrder(String orderNo) {
		return orderService.handlerCancelOrder(orderNo, SessionHelper.getSessionUser().getUserID());
	}

	/**
	 * 确认收货
	 * 
	 * @param paymentPwd
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/confirmReceipt")
	@ResponseBody
	public MsgBean confirmReceipt(String payPasswd, Integer orderID) {
		payPasswd = StringUtil.decryptBASE64(payPasswd);
		MsgBean verifyPaypasswd = accountService.verifyPaypasswd(payPasswd);
		if (verifyPaypasswd.getCode() != Code.SUCCESS) {
			return verifyPaypasswd;
		}
		return orderService.handlerConfirmReceipt(SessionHelper.getSessionUser().getUserID(), orderID);
	}

	@Autowired
	private IGoodsService goodsService;

	/**
	 * 商品评论
	 * 
	 * @param orderId
	 * @param model
	 * @return
	 */
	@RequestMapping("/goods/comment/{orderId}")
	public String addComment(@PathVariable int orderId, ModelMap model) {
		Order order = orderService.queryOrder(orderId);
		List<OrderDetail> details = order.getDetails();
		Map<Integer, List<OrderDetail>> detailGroup = groupOrderDetailByGoodsId(details);
		model.addAttribute("detailGroup", detailGroup);
		return "/user/order/comment";
	}

	/**
	 * 订单详情按商品id分组
	 * 
	 * @param details
	 * @return
	 */
	private Map<Integer, List<OrderDetail>> groupOrderDetailByGoodsId(List<OrderDetail> details) {
		// 用于存放该商品在该订单中的交易概况（商品图片（goodsPic），名称（goodsName），总额(totalMoney)，数量(totalAmount)）
		Map<String, Object> keyMap = new HashMap<String, Object>();

		Map<Integer, List<OrderDetail>> detailGroup = new HashMap<Integer, List<OrderDetail>>();
		List<OrderDetail> _deDetails;
		for (OrderDetail detail : details) {
			int goodsId = detail.getGoodsID();
			_deDetails = detailGroup.get(goodsId);
			if (_deDetails == null) {
				_deDetails = new ArrayList<OrderDetail>();
			}
			_deDetails.add(detail);
			detailGroup.put(goodsId, _deDetails);
		}
		return detailGroup;

	}

	/**
	 * 删除订单 （逻辑删除）
	 * 
	 * @param orderID
	 * @return
	 */
	@RequestMapping("/delOrder")
	@ResponseBody
	public MsgBean delOrder(Integer orderID) {
		Order order = orderService.queryOrder(orderID);
		if (order == null)
			return new MsgBean(Code.FAIL, "订单不存在", MsgLevel.ERROR);
		orderService.updateOrderDelFlagByOrderID(order.getID(), true);
		return new MsgBean(Code.SUCCESS, "删除成功", MsgLevel.NORMAL);
	}

}
