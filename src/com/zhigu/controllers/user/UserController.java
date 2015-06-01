package com.zhigu.controllers.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.model.Account;
import com.zhigu.model.Goods;
import com.zhigu.model.Message;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.UserAuth;
import com.zhigu.model.UserInfo;
import com.zhigu.model.UserRecommend;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.message.IMessageSendService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IFavouriteService;
import com.zhigu.service.user.IOrderService;
import com.zhigu.service.user.IUserService;

/**
 * 用户信息
 * 
 * @author zhouqibing 2014年7月22日上午8:54:49
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private IUserService userService;
	@Autowired
	private IAccountService account;
	@Autowired
	private IFavouriteService favouriteService;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IMessageSendService messageSendService;
	@Autowired
	private IStoreService storeService;

	/**
	 * 登录首页
	 * 
	 * @param request
	 * @param mv
	 * @return
	 */
	@RequestMapping("/home")
	public ModelAndView home(HttpServletRequest request, ModelAndView mv) {
		if (SessionHelper.getSessionUser().getUserType() > UserType.USER) {
			mv.setViewName("redirect:/supplier/store/home");
			return mv;
		}
		int userID = SessionHelper.getSessionUser().getUserID();
		// 店铺信息
		Store store = storeService.queryStoreByUserID(userID);
		mv.addObject("store", store);
		Account acc = account.queryAccountByUserID(userID);
		UserInfo info = userService.queryUserInfoById(userID);
		mv.addObject("acc", acc);
		mv.addObject("info", info);
		// 今天日期
		mv.addObject("today", DateUtil.format(DateUtil.MM_dd_E));
		mv.setViewName("user/home");
		// 商品收藏栏
		PageBean<Goods> page = new PageBean<Goods>();
		page.setPageNo(1);
		page.setPageSize(5);
		page = favouriteService.queryFavouriteGoodsByPage(page, userID);
		mv.addObject("favouritegoods", page.getDatas());
		// 店铺收藏栏
		PageBean<Store> page2 = new PageBean<Store>();
		page2.setPageNo(1);
		page2.setPageSize(5);
		page2 = favouriteService.queryFavouriteStoreByPage(page2, userID);
		mv.addObject("favouriteStores", page2.getDatas());

		// 订单状态统计
		mv.addObject("statusCount", orderService.queryStatusCount(userID, UserType.USER));
		OrderCondition oc = new OrderCondition(userID, UserType.USER, null, null, null, 0, null, null);
		PageBean<Order> page3 = new PageBean<Order>();
		page3.setPageNo(1);
		page3.setPageSize(3);
		List<Order> orders = orderService.queryOrders(page3, oc);
		mv.addObject("orders", orders);
		// 用户信息
		mv.addObject("userAuth", userService.queryUserAuthByUserID(userID));
		// 用户上次登录日志
		mv.addObject("loginLog", userService.queryLastTimeLogin(userID));
		return mv;
	}

	/**
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/info")
	public ModelAndView info(ModelAndView mv) {
		mv.setViewName("user/baseinfo");
		UserAuth auth = userService.queryUserAuthByUserID(SessionHelper.getSessionUser().getUserID());
		UserInfo info = userService.queryUserInfoById(SessionHelper.getSessionUser().getUserID());

		mv.addObject("auth", auth);
		mv.addObject("info", info);
		return mv;
	}

	/**
	 * 修改用户基本信息
	 * 
	 * @param info
	 * @param mv
	 * @return
	 */
	@RequestMapping("/info/modify")
	@ResponseBody
	public MsgBean modify(UserInfo info, String username, ModelAndView mv) {

		int userID = SessionHelper.getSessionUser().getUserID();

		// JSONObject json = new JSONObject();
		// 修改用户名
		if (!StringUtil.isEmpty(username)) {
			if (!VerifyUtil.usernameVerify(username)) {
				return new MsgBean(Code.FAIL, "用户名只能使用汉字、数字、字母、下划线组成，不能以数字或下划线开头，不能用下划线结尾，2位以上！", MsgLevel.ERROR);
			}
			UserInfo ui = userService.queryUserInfoById(userID);
			if (ui.getUsernameModify() == 0) {
				UserAuth auth = userService.queryUserAuthByUsername(username);
				UserAuth email = userService.queryUserAuthByEmail(username);
				UserAuth phone = userService.queryUserAuthByPhone(username);
				if (auth != null && auth.getUserID() != userID) {
					return new MsgBean(Code.FAIL, "用户名已经存在！", MsgLevel.ERROR);
				}
				if (email != null && email.getUserID() != userID) {
					return new MsgBean(Code.FAIL, "用户名已经存在！", MsgLevel.ERROR);
				}
				if (phone != null && phone.getUserID() != userID) {
					return new MsgBean(Code.FAIL, "用户名已经存在！", MsgLevel.ERROR);
				}
			} else {
				// 修改过用户名不能再修改
				username = ui.getUserName();
			}
		}

		info.setUserID(SessionHelper.getSessionUser().getUserID());
		userService.updateUserInfo(username, info);

		return new MsgBean(Code.SUCCESS, "修改信息成功！", MsgLevel.NORMAL);
	}

	@RequestMapping("/getUserInfo")
	@ResponseBody
	public UserInfo getUserInfo() {
		UserInfo userInfo = userService.queryUserInfoById(SessionHelper.getSessionUser().getUserID());
		return userInfo;
	}

	/**
	 * 推广链接
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/recommend")
	public ModelAndView recommend(ModelAndView mv) {
		mv.setViewName("user/recommend/recommend");
		int userID = SessionHelper.getSessionUser().getUserID();
		String url = ZhiguConfig.getValue(ZhiguConfig.HOST) + "register?recommendUserID=" + userID;
		mv.addObject("recommendUrl", url);
		return mv;
	}

	/**
	 * 被推荐的人(仅有账户信息)
	 * 
	 * @return
	 */
	@RequestMapping("/recommended")
	@ResponseBody
	public List<UserInfo> recommended() {
		return userService.queryRecommended(SessionHelper.getSessionUser().getUserID());
	}

	/**
	 * 查询用户填写的推荐
	 * 
	 * @return
	 */
	@RequestMapping("/queryUserWriteRecommend")
	@ResponseBody
	public List<UserRecommend> queryUserWriteRecommend(PageBean<UserRecommend> page) {
		page.setPageSize(100);
		return userService.queryUserRecommendByUserID(page, SessionHelper.getSessionUser().getUserID());
	}

	/**
	 * 删除用户填写的推荐
	 * 
	 * @return
	 */
	@RequestMapping("/deleteUserWriteRecommend")
	@ResponseBody
	public MsgBean deleteUserWriteRecommend(int id) {
		userService.deleteUserWriteRecommend(id);
		return new MsgBean(Code.SUCCESS, "删除成功", MsgLevel.NORMAL);
	}

	/**
	 * 保存用户记录被推荐人
	 * 
	 * @param userRecommend
	 * @return
	 */
	@RequestMapping("/saveUserRecommend")
	@ResponseBody
	public MsgBean saveUserRecommend(UserRecommend userRecommend) {
		userRecommend.setUserId(SessionHelper.getSessionUser().getUserID());
		userService.saveUserRecommend(userRecommend);
		return ServiceMsg.getMsgBean();
	}

	@RequestMapping("getSendingMessage")
	@ResponseBody
	public MsgBean getSendingMessage() {
		SessionUser sessionUser = SessionHelper.getSessionUser();
		if (sessionUser == null) {
			return new MsgBean(Code.SUCCESS, "未登陆！", MsgLevel.ERROR);
		}
		MsgBean msgBean = new MsgBean(Code.SUCCESS, "发送成功", MsgLevel.ERROR);

		List<Message> messageList = messageSendService.querySendingMessage(sessionUser.getUserID());
		msgBean.setData(messageList);

		return msgBean;
	}
}
