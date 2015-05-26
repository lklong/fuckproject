package com.zhigu.controllers.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.model.DownloadHistory;
import com.zhigu.model.PageBean;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IDownloadHistoryService;

/**
 * 用户下载管理
 * 
 * @author HeSiMin
 * @date 2014年8月7日
 *
 */
@Controller
@RequestMapping("user/downloadHistory")
public class DownloadHistoryControll {
	@Autowired
	private IDownloadHistoryService DownloadHistoryService;
	@Autowired
	private IStoreService storeSerice;

	/**
	 * 下载的商品
	 * 
	 * @param mv
	 * @param goodsName
	 * @param storeName
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@RequestMapping("goods")
	public ModelAndView goods(ModelAndView mv, @RequestParam(required = false) String goodsName, @RequestParam(required = false) String storeName, @RequestParam(required = false) String startDate,
			@RequestParam(required = false) String endDate, PageBean<DownloadHistory> page) {
		mv.setViewName("/user/downloadhistory");
		// 返回页面查询数据
		mv.addObject("goodsName", goodsName);
		mv.addObject("storeName", storeName);
		mv.addObject("startDate", startDate);
		mv.addObject("endDate", endDate);

		// 取得下载历史
		page.addParas("userID", SessionHelper.getSessionUser().getUserID());
		page.addParas("goodsName", goodsName);
		page.addParas("storeName", storeName);
		page.addParas("startDate", startDate);
		page.addParas("endDate", endDate);
		List<DownloadHistory> downloadHistorys = DownloadHistoryService.queryDownloadHistoryByPage(page);
		mv.addObject("page", page);
		mv.addObject("downloadHistorys", downloadHistorys);
		return mv;
	}

	/**
	 * 删除下载历史
	 * 
	 * @param mv
	 * @param IDs
	 * @return
	 */
	@RequestMapping("deleteDownloadHistory")
	public String deleteDownloadHistory(ModelAndView mv, int[] IDs) {
		if (IDs != null && IDs.length > 0) {
			DownloadHistoryService.deleteDownloadHistory(IDs);
		}
		return "forward:/user/downloadHistory/goods";
	}
}
