package com.zhigu.controllers.user;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Favourite;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IFavouriteService;

/**
 * 收藏信息
 * 
 * @author HeSiMin
 * @date 2014年7月29日
 */
@Controller
@RequestMapping("/user/favourite")
public class FavouriteController {
	@Autowired
	private IFavouriteService favouriteService;
	@Autowired
	private IStoreService storeService;

	/**
	 * 查询是否被当前用户收藏
	 * 
	 * @param fID
	 *            如果是店铺 那就是店铺的ID 如果是商品 那就是商品ID
	 * @param type
	 * @return
	 */
	@RequestMapping("/query")
	@ResponseBody
	public MsgBean queryFavourite(int fID, int type) {
		SessionUser user = SessionHelper.getSessionUser();
		Favourite favourite = null;
		if (user != null)
			favourite = favouriteService.queryFavourite(user.getUserId(), fID, type);
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(favourite == null ? false : true);
	}

	/**
	 * 收藏的商品
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/favouriteGoods")
	public ModelAndView favouritecmmodity(ModelAndView mv) {
		mv.setViewName("user/favouritegoods");
		List list = favouriteService.queryFavouriteGoods(SessionHelper.getSessionUser().getUserId());
		mv.addObject("goodsList", list);
		return mv;
	}

	/**
	 * 收藏的店铺
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/favouritestore")
	public ModelAndView favouriteStore(ModelAndView mv) {
		mv.setViewName("/user/favouritestore");
		List<Store> list = favouriteService.queryFavouriteStore(SessionHelper.getSessionUser().getUserId());
		// 查询店铺的商品
		for (Store s : list) {
			PageBean page = new PageBean();
			page.setPageSize(5);
			page.setPageNo(1);
			page = storeService.queryStoreGoodsByPage(page, s.getID());
			s.setGoods(page.getDatas());
		}
		mv.addObject("stores", list);
		return mv;
	}

	/**
	 * 购买过的店铺
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/boughtstore")
	public ModelAndView boughtStore(ModelAndView mv) {
		mv.setViewName("/user/boughtstore");
		List<Store> list = favouriteService.queryBoughtStore(SessionHelper.getSessionUser().getUserId());
		// 查询店铺的商品
		for (Store s : list) {
			PageBean page = new PageBean();
			page.setPageSize(5);
			page.setPageNo(1);
			page = storeService.queryStoreGoodsByPage(page, s.getID());
			s.setGoods(page.getDatas());
		}
		mv.addObject("stores", list);
		return mv;
	}

	/**
	 * 添加收藏商品
	 * 
	 * @param commodityID
	 */
	/*
	 * @RequestMapping("/addFavouriteGoods")
	 * 
	 * @ResponseBody public MsgBean addFavouriteGoods(@RequestParam int goodsID)
	 * { if (SessionHelper.getSessionUser() == null) { return new
	 * MsgBean(Code.FAIL, "未登录！", MsgLevel.ERROR); }
	 * favouriteService.addFavouriteCommodity
	 * (SessionHelper.getSessionUser().getUserId(), goodsID); return new
	 * MsgBean(Code.SUCCESS, "收藏成功！", MsgLevel.NORMAL); }
	 */
	@RequestMapping("/addFavouriteGoods")
	@ResponseBody
	public MsgBean addFavouriteGoods(String... goodsIds) {
		if (SessionHelper.getSessionUser() == null) {
			return new MsgBean(Code.FAIL, "未登录！", MsgLevel.ERROR);
		}
		// id 去重复
		List<String> _goodsIds = Arrays.asList(goodsIds);
		Set<String> idSet = new HashSet<String>();
		idSet.addAll(_goodsIds);

		for (String goodsId : idSet) {
			if (StringUtils.isNotBlank(goodsId)) {
				favouriteService.addFavouriteCommodity(SessionHelper.getSessionUser().getUserId(), Integer.valueOf(goodsId));
			}
		}
		MsgBean msgBean = new MsgBean(Code.SUCCESS, "收藏成功！", MsgLevel.NORMAL);
		msgBean.setData(goodsIds);
		return msgBean;
	}

	/**
	 * 添加收藏店铺
	 * 
	 * @param storiID
	 */
	@RequestMapping("/addFavouriteStore")
	@ResponseBody
	public MsgBean addFavouriteStore(@RequestParam int storeID) {
		if (SessionHelper.getSessionUser() == null) {
			return new MsgBean(Code.FAIL, "未登录！", MsgLevel.ERROR);
		}
		Store store = storeService.queryStoreByID(storeID);
		if (SessionHelper.getSessionUser().getUserId() == store.getUserID()) {
			return new MsgBean(Code.FAIL, "收藏失败，不能收藏自己！", MsgLevel.ERROR);
		} else {
			favouriteService.addFavouriteStore(SessionHelper.getSessionUser().getUserId(), storeID);
			return new MsgBean(Code.SUCCESS, "收藏成功！", MsgLevel.NORMAL);
		}
	}

	/**
	 * 删除收藏商品
	 */
	@RequestMapping("/delFavouriteGoods")
	@ResponseBody
	public MsgBean delFavouriteGoods(@RequestParam(required = false) int[] goodsID) {
		favouriteService.deleteFavouriteCommodity(SessionHelper.getSessionUser().getUserId(), goodsID);
		return new MsgBean(Code.SUCCESS, "删除收藏商品成功！", MsgLevel.NORMAL);
	}

	/**
	 * 删除收藏店铺
	 */
	@RequestMapping("/delFavouriteStore")
	@ResponseBody
	public String delFavouriteStore(@RequestParam(required = false) int[] storeID) {
		favouriteService.deleteFavouriteStore(SessionHelper.getSessionUser().getUserId(), storeID);
		return "200";
	}

	/**
	 * 删除购买过的店铺
	 */
	@RequestMapping("/delBoughtStoree")
	@ResponseBody
	public String delBoughtStoree(@RequestParam(required = false) int[] storeID) {
		favouriteService.deleteBoughtStoree(SessionHelper.getSessionUser().getUserId(), storeID);
		return "200";
	}
}
