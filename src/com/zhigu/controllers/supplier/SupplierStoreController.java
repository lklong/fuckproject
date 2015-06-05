package com.zhigu.controllers.supplier;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.BusinessArea;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.StoreConst;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.StoreApproveState;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.model.Account;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.store.IStoreNoticeService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IOrderService;
import com.zhigu.service.user.IUserService;

/**
 * 店铺（供应商）
 * 
 * @author liyouzan 2014年7月24日13:21:51
 */
@Controller
@RequestMapping("/supplier/store")
public class SupplierStoreController {
	private static final Logger logger = Logger.getLogger(SupplierStoreController.class);
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IStoreNoticeService storeNoticeService;

	/**
	 * 注册页面初期化
	 * 
	 * @param store
	 * @param mv
	 * @return
	 */
	@RequestMapping("/registerInit")
	public ModelAndView registerInit(Store store, ModelAndView mv) {
		Store queryStore = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		if (queryStore != null) {
			if (queryStore.getApproveState() == StoreApproveState.OPEN.getValue() && SessionHelper.getSessionUser().getUserType() == UserType.SUPPLIER) {
				// 店铺用户首页
				mv.setViewName("redirect:/supplier/store/home");
			} else if (queryStore.getApproveState() == StoreApproveState.WAIT_APPROVED.getValue()) {
				mv.setViewName("supplier/store/register_wait_approved");
			} else {
				// TODO 店铺其他状态
				mv.setViewName("redirect:/user/home");
			}
			return mv;
		}

		SessionUser sessionUser = SessionHelper.getSessionUser();
		if (sessionUser != null) {
			if (sessionUser.getUserType() != UserType.USER) {
				mv.setViewName("redirect:/supplier/store/home");
				return mv;
			}
		}
		mv.setViewName("supplier/store/register");
		mv.addObject("businessArea", BusinessArea.values());
		mv.addObject("store", store);
		return mv;
	}

	/**
	 * 店铺注册
	 * 
	 * @param store
	 * @param mv
	 * @return
	 */
	@RequestMapping("/register")
	@ResponseBody
	public MsgBean register(Store store) {
		// 供应商注册保存
		return storeService.registerStore(store);
	}

	/**
	 * 支付店铺会员费
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/payStoreCost")
	public ModelAndView payStoreCost(ModelAndView mv) {
		// 帐户信息
		mv.addObject("acc", accountService.queryAccountByUserID(SessionHelper.getSessionUser().getUserID()));
		mv.setViewName("supplier/store/payStoreCost");
		return mv;
	}

	/**
	 * 供应商首页
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/home")
	public ModelAndView storeHome(ModelAndView mv, OrderCondition oc) {
		mv.setViewName("supplier/store/home");
		int userID = SessionHelper.getSessionUser().getUserID();
		// 店铺信息
		Store store = storeService.queryStoreByUserID(userID);
		mv.addObject("store", store);
		// 用户基本信息
		UserInfo userInfo = userService.queryUserInfoById(userID);
		mv.addObject("userInfo", userInfo);
		// 今天日期
		mv.addObject("today", DateUtil.format(DateUtil.MM_dd_E));
		// 用户账户金额信息
		Account account = accountService.queryAccountByUserID(userID);
		mv.addObject("account", account);
		// 手机、邮箱绑定信息
		UserAuth userAuth = userService.queryUserAuthByUserID(userID);
		mv.addObject("userAuth", userAuth);
		// 用户上次登录日志
		mv.addObject("loginLog", userService.queryLastTimeLogin(userID));
		// 卖出商品信息
		oc.setUserID(userID);
		oc.setUserType(UserType.SUPPLIER);// 网商
		PageBean<Order> page = new PageBean<Order>();
		page.setPageNo(1);
		page.setPageSize(3);
		List<Order> orders = orderService.queryOrders(page, oc);
		mv.addObject("orders", orders);
		if (store.getFullMemberFlg() == Flg.OFF) {
			Date openDate = store.getOpenStoreDate();
			Date now = new Date();
			int residue = 0;
			if (DateUtil.getDateBefore(now, StoreConst.PROBATION_PERIOD).before(openDate)) {
				residue = StoreConst.PROBATION_PERIOD - (int) ((now.getTime() - openDate.getTime()) / (24 * 60 * 60 * 1000));
			}
			mv.addObject("residue", residue);
		}
		mv.addObject("statusCount", orderService.queryStatusCount(userID, UserType.SUPPLIER));
		return mv;
	}

	/**
	 * 查看店铺
	 * 
	 * @return
	 */
	@RequestMapping("/lookStore")
	public String lookStore() {
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		return "redirect:/store/index?storeId=" + store.getID();
	}

	/**
	 * 店铺基本信息设置
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/baseInfoInit")
	public ModelAndView baseInfoInit(ModelAndView mv) {
		mv.setViewName("supplier/store/base_info");
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		mv.addObject("store", store);
		mv.addObject("businessArea", BusinessArea.values());
		return mv;
	}

	/**
	 * 店铺基本信息设置
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "/updateBaseInfo", method = RequestMethod.GET)
	public ModelAndView updateBaseInfoUI(ModelAndView mv) {
		mv.setViewName("supplier/store/updateBaseInfo");
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		mv.addObject("store", store);
		mv.addObject("businessArea", BusinessArea.values());
		return mv;
	}

	/**
	 * 保存店铺基本信息修改
	 * 
	 * @param store
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "/updateBaseInfo", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean updateBaseInfo(Store store) {
		// 更新店铺信息
		return storeService.updateStoreBase(store);
	}

	/**
	 * 店铺装饰
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/decorateInit")
	public ModelAndView decorateInit(ModelAndView mv) {
		mv.setViewName("supplier/store/decorate");
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		mv.addObject("store", store);
		return mv;
	}

	/**
	 * 更新店铺装饰
	 * 
	 * @param introduction
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/updateDecorate")
	public String updateDecorate(Store store) throws IOException {
		store.setUserID(SessionHelper.getSessionUser().getUserID());
		storeService.updateStoreDecorate(store);
		return "redirect:/store/index?storeId=" + store.getID();
	}

	/**
	 * 刷新店铺
	 * 
	 * @param goodsID
	 * @return
	 * 
	 */
	@RequestMapping("/refresh")
	@ResponseBody
	public MsgBean refresh() {
		return storeService.updateRefreshDate();
	}

}
