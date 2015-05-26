package com.zhigu.controllers.supplier;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.StoreNoticeType;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.StoreNotice;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.storeNotice.IStoreNoticeService;

/**
 * 店铺公告（供应商）
 * 
 * @author Y.Z.X
 * @since 2015-05-21
 */
@Controller
@RequestMapping("/supplier/storeNotice")
public class SupplierStoreNoticeController {

	@Autowired
	private IStoreNoticeService storeNoticeService;

	@Autowired
	private IStoreService storeService;

	/**
	 * 店铺公告
	 * 
	 * @return
	 */
	@RequestMapping("/storeNoticeList")
	@ResponseBody
	public ModelAndView StoreNoticeList() {
		ModelAndView mav = new ModelAndView();
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserID());
		List<StoreNotice> sn = storeNoticeService.queryStoreNoticeByPage(new PageBean<StoreNotice>(), store.getID(), StoreNoticeType.LOGGER);
		mav.addObject("storeNotice", sn);
		mav.addObject("storeID", store.getID());
		mav.setViewName("supplier/storeNotice/list");
		return mav;
	}

	/**
	 * 跳转 添加商家公告页面
	 * 
	 * @return
	 */
	@RequestMapping("/addStoreNoticePage")
	public ModelAndView addStoreNoticePage(Integer storeID) {
		ModelAndView mav = new ModelAndView();

		mav.addObject("storeID", storeID);

		mav.setViewName("supplier/storeNotice/add");
		return mav;
	}

	/**
	 * 保存 商家公告
	 * 
	 * @param storeNotice
	 * @return
	 */
	@RequestMapping("/addStoreNotice")
	@ResponseBody
	public MsgBean addStoreNotice(Integer storeID, String content) {
		return storeNoticeService.saveStoreNotice(storeID, content, StoreNoticeType.LOGGER);
	}

	/**
	 * 删除商家公告
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delStoreNotice", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean delStoreNotice(Integer id) {
		return storeNoticeService.delStoreNotice(id);
	}

}
