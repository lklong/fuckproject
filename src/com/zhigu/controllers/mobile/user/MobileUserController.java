package com.zhigu.controllers.mobile.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.model.PageBean;
import com.zhigu.model.UserInfo;
import com.zhigu.model.UserRecommend;
import com.zhigu.model.dto.MsgBean;
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
@RequestMapping("/mobile/user")
public class MobileUserController {

	@Autowired
	private IUserService userService;
	@Autowired
	private IAccountService account;
	@Autowired
	private IFavouriteService favouriteService;
	@Autowired
	private IOrderService orderService;

	/*
	 * 取得和当前账号相关的推广链接
	 */
	@RequestMapping("/recommend")
	@ResponseBody
	public String recommend() {
		int userID = SessionHelper.getSessionUser().getUserID();
		String url = ZhiguConfig.getValue(ZhiguConfig.HOST) + "register?recommendUserID=" + userID;
		return url;
	}

	/*
	 * 登陆用户 推荐 别的用户接口
	 */
	@RequestMapping("/saveUserRecommend")
	@ResponseBody
	public MsgBean saveUserRecommend(UserRecommend userRecommend) {
		userRecommend.setUserId(SessionHelper.getSessionUser().getUserID());
		userService.saveUserRecommend(userRecommend);
		return ServiceMsg.getMsgBean();
	}

	/*
	 * 得到当前账号 推荐的用户
	 */
	@RequestMapping("/queryUserWriteRecommend")
	@ResponseBody
	public PageBean<UserRecommend> queryUserWriteRecommend(PageBean<UserRecommend> page) {
		userService.queryUserRecommendByUserID(page, SessionHelper.getSessionUser().getUserID());
		return page;
	}

	/*
	 * 取得被推荐，并且 已经注册了的账号
	 */
	@RequestMapping("/recommended")
	@ResponseBody
	public List<UserInfo> recommended() {
		return userService.queryRecommended(SessionHelper.getSessionUser().getUserID());
	}

}
