package com.zhigu.controllers.store;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.constant.StoreNoticeType;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.StoreNotice;
import com.zhigu.model.UserInfo;
import com.zhigu.service.store.IStoreNoticeService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IUserService;

/**
 * 店铺公告
 * 
 * @author Y.Z.X
 *
 */
@Controller
@RequestMapping("/store/notice")
public class StoreNoticeController {

	@Autowired
	private IStoreService storeService;

	@Autowired
	private IStoreNoticeService storeNoticeService;

	@Autowired
	private IUserService userService;

	/**
	 * 店铺动态
	 * 
	 * @param storeID
	 * @return
	 */
	@RequestMapping("")
	public ModelAndView notice(int storeId, ModelAndView mv) {
		Store store = storeService.queryStoreByID(storeId);
		if (store == null)
			return mv;
		UserInfo user = userService.queryUserInfoById(store.getUserID());
		if (user != null)
			mv.addObject("userInfo", user);
		mv.addObject("notice", storeNoticeService.queryStoreNoticeByPage(new PageBean<StoreNotice>(), store.getID(), StoreNoticeType.LOGGER));
		mv.addObject("store", store);
		mv.setViewName("store/shoe/notice");
		return mv;
	}

}
