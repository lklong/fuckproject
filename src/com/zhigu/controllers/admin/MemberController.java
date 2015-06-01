package com.zhigu.controllers.admin;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionAdmin;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.dto.TreeBean;
import com.zhigu.model.AccountDetail;
import com.zhigu.model.MemberCondition;
import com.zhigu.model.MemberInfo;
import com.zhigu.model.Order;
import com.zhigu.model.OrderCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealUserAuth;
import com.zhigu.model.Store;
import com.zhigu.model.UserInfo;
import com.zhigu.model.UserRecommend;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.admin.IAdminOrderService;
import com.zhigu.service.admin.IAdminService;
import com.zhigu.service.admin.IMemberService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IAccountService;
import com.zhigu.service.user.IAddressService;
import com.zhigu.service.user.IOrderService;
import com.zhigu.service.user.IRealUserAuthService;
import com.zhigu.service.user.IUserService;

@Controller()
@RequestMapping("admin/member")
public class MemberController {
	@Autowired
	private IMemberService memberService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IAccountService accountService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IAddressService addressService;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IAdminOrderService adminOrderService;
	@Autowired
	private IAdminService adminService;
	@Autowired
	private IRealUserAuthService realUserAuthService;

	/**
	 * 普通会员列表
	 * 
	 * @param mv
	 * @param page
	 * @param mc
	 * @return
	 */
	@RequestMapping("/commonMember")
	public ModelAndView commonMember(ModelAndView mv, PageBean<MemberInfo> page, MemberCondition mc) {
		if (mc.getOrder() == null)
			mc.setOrder(2);// 注册时间降

		if (mc.getStatus() == null)
			mc.setStatus(0);

		if (mc.getEndDate() != null)
			mc.setEndDate(DateUtil.getDateBefore(mc.getEndDate(), -1));

		SessionAdmin au = SessionHelper.getSessionAdmin();

		if (au.getRoleId() != 1)
			mc.setStaffID(au.getId());

		page.setDatas(memberService.queryCommonMemberList(page, mc));

		// mv.addObject("adminUsers", adminService.qeuryAdminAll());
		mv.addObject("page", page);
		mv.addObject("mc", mc);

		mv.setViewName("admin/member/common");

		return mv;
	}

	/**
	 * 所有会员列表
	 * 
	 * @param mv
	 * @param page
	 * @param mc
	 * @return
	 */
	@RequestMapping("/allMember")
	public ModelAndView allMember(ModelAndView mv, PageBean<MemberInfo> page, MemberCondition mc) {
		if (mc.getOrder() == null)
			mc.setOrder(2);// 注册时间降
		if (mc.getStatus() == null)
			mc.setStatus(0);
		if (mc.getEndDate() != null)
			mc.setEndDate(DateUtil.getDateBefore(mc.getEndDate(), -1));
		page.setDatas(memberService.queryCommonMemberList(page, mc));
		mv.addObject("adminUsers", adminService.qeuryAdminAll());
		mv.addObject("page", page);
		mv.addObject("mc", mc);
		mv.setViewName("admin/member/common");
		return mv;
	}

	@RequestMapping("/unableMember")
	public ModelAndView unableMember(ModelAndView mv, PageBean<MemberInfo> page, MemberCondition mc) {
		if (mc.getOrder() == null)
			mc.setOrder(2);// 注册时间降
		if (mc.getStatus() == null)
			mc.setStatus(0);
		if (mc.getEndDate() != null)
			mc.setEndDate(DateUtil.getDateBefore(mc.getEndDate(), -1));
		SessionAdmin au = SessionHelper.getSessionAdmin();
		if (au.getRoleId() != 1)
			mc.setStaffID(au.getId());
		page.setDatas(memberService.queryUnableMemberList(page, mc));
		mv.addObject("page", page);
		mv.addObject("mc", mc);
		mv.setViewName("admin/member/unable");
		return mv;
	}

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView mv, PageBean<MemberInfo> page, MemberCondition mc) {
		if (mc.getOrder() == null)
			mc.setOrder(2);// 注册时间降
		if (mc.getStatus() == null)
			mc.setStatus(0);
		if (mc.getEndDate() != null)
			mc.setEndDate(DateUtil.getDateBefore(mc.getEndDate(), -1));
		SessionAdmin au = SessionHelper.getSessionAdmin();
		if (au.getRoleId() != 1)
			mc.setStaffID(au.getId());
		page.setDatas(memberService.querySupplieMemberList(page, mc));
		mv.addObject("page", page);
		mv.addObject("mc", mc);
		mv.setViewName("admin/member/index");
		return mv;
	}

	/**
	 * 会员分配
	 * 
	 * @return
	 */
	@RequestMapping("/allot")
	@ResponseBody
	public MsgBean allot(Integer staffID, Integer[] mems) {
		memberService.saveAllotMember(staffID, Arrays.asList(mems));
		return new MsgBean(Code.SUCCESS, "会员分配成功", MsgLevel.NORMAL);
	}

	/**
	 * 禁用会员
	 * 
	 * @param mems
	 * @return
	 */
	@RequestMapping("/freeze")
	@ResponseBody
	public MsgBean freeze(@RequestParam Integer[] mems) {
		memberService.updateMemStatus(9, Arrays.asList(mems));
		return new MsgBean(Code.SUCCESS, "会员禁用成功", MsgLevel.NORMAL);
	}

	/**
	 * 禁用会员
	 * 
	 * @param mems
	 * @return
	 */
	@RequestMapping("/using")
	@ResponseBody
	public MsgBean using(@RequestParam Integer[] mems) {
		memberService.updateMemStatus(0, Arrays.asList(mems));
		return new MsgBean(Code.SUCCESS, "会员启用成功", MsgLevel.NORMAL);
	}

	@RequestMapping("/detail")
	public ModelAndView detail(@RequestParam Integer memberID, ModelAndView mv) {
		// 基本资料
		mv.addObject("info", userService.queryUserInfoById(memberID));
		mv.addObject("auth", userService.queryUserAuthByUserID(memberID));
		mv.addObject("defAdd", addressService.queryDefaultAddress(memberID));
		mv.addObject("stat", adminOrderService.memberOrderStat(memberID));
		// 实名认证资料
		RealUserAuth realUserAuth = realUserAuthService.queryRealUserAuth(memberID);
		mv.addObject("realUserAuth", realUserAuth);
		if (realUserAuth != null) {
			if (realUserAuth.getAddAdminId() != 0) {
				mv.addObject("addRealUser", adminService.queryAdmin(realUserAuth.getAddAdminId()));
			}
			if (realUserAuth.getApproveAdminId() != 0) {
				mv.addObject("approve", adminService.queryAdmin(realUserAuth.getApproveAdminId()));
			}
		}
		// 店铺资料
		Store store = storeService.queryStoreByUserID(memberID);
		mv.addObject("store", store);

		mv.setViewName("admin/member/detail");
		mv.addObject("memberID", memberID);
		return mv;
	}

	@RequestMapping("/detail/order")
	public ModelAndView detailOrder(Integer memberID, Integer userType, ModelAndView mv, PageBean<Order> page) {
		OrderCondition oc = new OrderCondition();
		oc.setUserType(userType);// 1:买家，2：卖家
		oc.setUserID(memberID);
		orderService.queryOrders(page, oc);

		mv.addObject("page", page);
		mv.setViewName("admin/member/detail/order");
		return mv;
	}

	@RequestMapping("/detail/acc")
	public ModelAndView detailAcc(@RequestParam Integer memberID, PageBean<AccountDetail> page, ModelAndView mv) {
		// 帐号信息
		accountService.queryAccountDetailList(page, memberID, null, null);
		mv.addObject("acc", accountService.queryAccountByUserID(memberID));
		mv.addObject("page", page);
		mv.setViewName("admin/member/detail/acc");
		return mv;
	}

	/**
	 * 修改会员是否公司员工
	 * 
	 * @param userID
	 * @param isInnerEmployee
	 * @return
	 */
	@RequestMapping("/updateIsInnerEmployee")
	@ResponseBody
	public MsgBean updateIsInnerEmployee(int userID, int isInnerEmployee) {
		if (memberService.updateIsInnerEmployee(userID, isInnerEmployee) != 1) {
			return new MsgBean(Code.FAIL, "", MsgLevel.ERROR);
		}
		return new MsgBean(Code.SUCCESS, "修改成功！", MsgLevel.NORMAL);
	}

	/**
	 * 查询会员，通过推荐人
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping("/queryMemberByRecommendUser")
	@ResponseBody
	public TreeBean[] queryMemberByRecommendUser(int userId) {
		int u = userId;
		List<UserInfo> userInfos = memberService.queryMemberByRecommendUser(u);
		TreeBean[] ts = null;
		if (userInfos.size() > 0) {
			// 转为树形结构需要的数据
			ts = new TreeBean[userInfos.size()];
			for (int i = 0; i < userInfos.size(); i++) {
				UserInfo temp = userInfos.get(i);
				ts[i] = new TreeBean(temp.getUserID(), userId, temp.getUserName());
			}
		} else {
			TreeBean tb = new TreeBean(-1, -1, "无推荐会员");
			tb.setIsParent(false);
			ts = new TreeBean[] { tb };
		}
		return ts;
	}

	/**
	 * 查询用户填写的推荐
	 * 
	 * @return
	 */
	@RequestMapping("/queryUserWriteRecommend")
	public ModelAndView queryUserWriteRecommend(ModelAndView mv, PageBean<UserRecommend> page, int userID) {
		page.setPageSize(3);
		mv.setViewName("admin/member/inner_writerecommendrecord");
		userService.queryUserRecommendByUserID(page, userID);
		mv.addObject("userID", userID);
		mv.addObject("page", page);
		return mv;
	}
}
