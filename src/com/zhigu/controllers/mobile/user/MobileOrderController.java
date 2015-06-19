package com.zhigu.controllers.mobile.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.ShoppingCart;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.ICartService;
import com.zhigu.service.user.IOrderService;
import com.zhigu.service.user.IUserService;

/**
 * 用户订单
 * 
 * @author HeSiMin
 * @date 2014年11月17日
 *
 */
@Controller
@RequestMapping("/mobile/user/order")
public class MobileOrderController {
	@Autowired
	private ICartService cartService;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IUserService userService;

	/**
	 * 查看购物车
	 *
	 * @param mv
	 * @return
	 */
	@RequestMapping("/mycart")
	@ResponseBody
	public MsgBean myCart() {
		List<ShoppingCart> list = cartService.queryShoppingCart(SessionHelper.getSessionUser().getUserId(), true);
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(list);
	}

	// /**
	// * 查看购物车
	// *
	// * @param mv
	// * @return
	// */
	// @RequestMapping("/mycart")
	// @ResponseBody
	// public List<ShoppingCart> myCart() {
	// List<ShoppingCart> list =
	// cartService.shoppingCartList(SessionHelper.getSessionUser().getUserId());
	// return list;
	// }
	//
	// /**
	// * 删除购物车中的商品
	// *
	// * @param items
	// * @return
	// */
	// @RequestMapping("/cart/del")
	// @ResponseBody
	// public MsgBean cartDelete(Integer[] cartIDs) {
	// if (cartIDs == null || cartIDs.length == 0) {
	// return new MsgBean(Code.FAIL, "未选择删除商品！", MsgLevel.ERROR);
	// }
	// cartService.deleteShoppingCart(SessionHelper.getSessionUser().getUserId(),
	// Arrays.asList(cartIDs));
	// return new MsgBean(Code.SUCCESS, "商品已删除！", MsgLevel.NORMAL);
	// }
	//
	// /**
	// * 修改购物车商品选中状态
	// *
	// * @param ids
	// * @param isChecked
	// * @return
	// */
	// @RequestMapping("/cart/updateIsChecked")
	// @ResponseBody
	// public MsgBean cartUpdateIsChecked(String[] idAndIsChecked) {
	// if (idAndIsChecked == null || idAndIsChecked.length == 0) {
	// return new MsgBean(Code.FAIL, "未选择，请选择！", MsgLevel.ERROR);
	// }
	// for (String str : idAndIsChecked) {
	// String[] temp = str.split(Common.COLON);
	// cartService.updateCartIsChecked(Integer.parseInt(temp[0]),
	// Integer.parseInt(temp[1]));
	// }
	// return ServiceMsg.getMsgBean();
	// }
	//
	// /**
	// * 修改购物车中的商品数量
	// *
	// * @param id
	// * @param quantity
	// * @return
	// */
	// @RequestMapping("/cart/updateGoodsQuantity")
	// @ResponseBody
	// public MsgBean cartUpdateGoodsQuantity(int id, int quantity) {
	// cartService.updateCartGoodsQuantity(id, quantity);
	// return ServiceMsg.getMsgBean();
	// }
	//
	// /**
	// * 订单确认商品信息
	// *
	// * @return
	// */
	// @RequestMapping("/confirmOrderGoods")
	// @ResponseBody
	// public List<ShoppingCart> confirmOrderGoods() {
	// return
	// orderService.confirmOrderQuery(SessionHelper.getSessionUser().getUserId());
	// }
	//
	// /**
	// * 生成订单
	// *
	// * @param addressID
	// * @param orders
	// * @return
	// */
	// @RequestMapping("/createOrder")
	// @ResponseBody
	// public MsgBean createOrder(Integer addressID, Club club) {
	// // 需要店铺id、代发商物流id、留言
	// return
	// orderService.saveOrders(SessionHelper.getSessionUser().getUserId(),
	// addressID, club.getOrders(), 0);
	// }
	//
	// @RequestMapping("")
	// @ResponseBody
	// public JSONObject orderList(OrderCondition oc, PageBean<Order> page) {
	//
	// JSONObject jsonObject = new JSONObject();
	//
	// oc.setUserID(SessionHelper.getSessionUser().getUserId());
	// oc.setUserType(UserType.USER);
	//
	// orderService.queryOrders(page, oc);
	//
	// jsonObject.put("page", page);
	// jsonObject.put("oc", oc);
	// jsonObject.put("nowTime", System.currentTimeMillis());
	//
	// return jsonObject;
	// }
	//
	// /*
	// * 取消订单接口
	// */
	// @RequestMapping("/cancel")
	// @ResponseBody
	// public MsgBean cancelOrder(String orderNo) {
	// return orderService.handlerCancelOrder(orderNo);
	//
	// }
	//
	// /*
	// * 平台支付订单
	// */
	// @RequestMapping("/pay")
	// @ResponseBody
	// public MsgBean payment(Integer[] orderID) {
	//
	// return new MsgBean(Code.FAIL, "手机系统调整中", MsgLevel.ERROR);
	// }
	//
	// /*
	// * 确认支付
	// */
	// @RequestMapping("/pay/submit")
	// @ResponseBody
	// public MsgBean submitPay(String paypasswd, Integer[] orderID) {
	// return new MsgBean(Code.FAIL, "fail", MsgLevel.ERROR);
	// // return
	// //
	// orderService.handlerPaymentOrder(SessionHelper.getSessionUser().getUserId(),
	// // Arrays.asList(orderID));
	// }

}
