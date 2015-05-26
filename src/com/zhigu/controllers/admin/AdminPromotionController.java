package com.zhigu.controllers.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.model.PageBean;
import com.zhigu.model.SendAward;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IUserPointService;

/**
 * 促销活动 / 推广
 * 
 * @author HeSiMin
 * @date 2014年9月30日
 *
 */
@Controller
@RequestMapping("/admin/promotion")
public class AdminPromotionController {
	@Autowired
	private IUserPointService userPointService;

	/**
	 * 用户充值积分
	 * 
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping("/userPointList")
	public ModelAndView userPointList(ModelAndView mv, PageBean page) {
		mv.setViewName("admin/promotion/rechargeList");
		mv.addObject("userPoints", userPointService.queryUserPointByPage(page));
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * 用户积分兑换列表
	 * 
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping("/userPointExchangeList")
	public ModelAndView userPointExchangeList(ModelAndView mv, PageBean page, @RequestParam(required = false) Integer status) {
		mv.setViewName("admin/promotion/userPointExchangeList");
		page.addParas("status", status);
		mv.addObject("userPointExchangeList", userPointService.queryUserPointExchange(page));
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * 发送用户积分兑换物品
	 * 
	 * 
	 * @return
	 */
	@RequestMapping("/sendUserPointExchange")
	@ResponseBody
	public MsgBean sendUserPointExchange(int id, @RequestParam(required = false) String comment) {
		userPointService.handlerSendUserPointExchange(id, comment);
		return new MsgBean(Flg.ON, "操作成功！", MsgLevel.NORMAL);
	}

	/**
	 * 保存发送奖励记录
	 * 
	 * @return
	 */
	@RequestMapping("/saveSendAward")
	@ResponseBody
	public MsgBean saveSendAward(SendAward sendAward) {
		sendAward.setAdminID(SessionHelper.getSessionAdmin().getId());
		userPointService.saveSendAward(sendAward);
		return ServiceMsg.getMsgBean();
	}

}
