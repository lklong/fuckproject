package com.zhigu.controllers.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SessionKey;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.CategoryType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.model.Category;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.Shortcutgoods;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;

/**
 * 后台管理商品
 * 
 * @author HeSiMin
 * @date 2014年9月10日
 *
 */
@Controller
@RequestMapping("/admin/goods")
public class AdminGoodsController {
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private ICategoryService categoryService;

	/**
	 * 商品列表
	 *
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView index(ModelAndView mv, PageBean<Goods> page, GoodsCondition goodsCondition) {
		List<Goods> goods = goodsService.queryGoodsList(goodsCondition, page);
		mv.addObject("page", page);
		mv.addObject("goods", goods);
		mv.addObject("gc", goodsCondition);
		mv.addObject("categoryTypes", CategoryType.values());
		mv.setViewName("admin/goods/index");
		return mv;
	}

	@RequestMapping("/shortcutGoods")
	public ModelAndView shortcutGoods(ModelAndView mv, PageBean<Shortcutgoods> page) {
		// int userId = SessionHelper.getSessionUser().getUserID();

		page.setDatas(goodsService.queryshortcutgoodsByManagerList(page));
		mv.addObject("shortcutgoodsList", page.getDatas());
		mv.addObject("page", page);

		mv.setViewName("admin/goods/shortcutGoods");
		return mv;
	}

	@RequestMapping("/add")
	public ModelAndView add(Integer shortcutGoodsID, ModelAndView mv) {
		Shortcutgoods shortcutGoods = goodsService.queryShortcutGoodsByID(shortcutGoodsID);
		// 因为使用session存数据，检查是否在快捷发布其他商品
		Object sessionShortcutGoodsID = SessionHelper.getAttribute(SessionKey.PROXY_GOODS_SHORTCUTGOODS_ID);
		if (sessionShortcutGoodsID != null) {
			if ((int) sessionShortcutGoodsID != shortcutGoods.getId()) {
				throw new ServiceException("你正在代发其他商品，请先完成！<a href='admin/goods/add?shortcutGoodsID=" + sessionShortcutGoodsID + "' target='_blank'>去完成</a>");
			}
		}
		// 创建代发账号
		SessionUser sessionUser = new SessionUser();
		sessionUser.setUsername("代发商品账号");
		sessionUser.setFakeUserID(shortcutGoods.getUserId());
		SessionHelper.setSessionUser(sessionUser);
		SessionHelper.setAttribute(SessionKey.PROXY_GOODS_SHORTCUTGOODS_ID, shortcutGoods.getId());

		mv.addObject("saveFile", shortcutGoods.getFilePath());
		Store store = storeService.queryStoreByUserID(shortcutGoods.getUserId());
		if (store.getSupplierType() == UserType.SUPPLIER) {// 普通供应商（鞋子、服装）
			List<Category> category = categoryService.queryCategoryByParent(0);
			List<Category> categorykeep = new ArrayList<Category>();
			for (Category c : category) {
				if (c.getId() != CategoryType.STORE_DECORATE.getValue() && c.getId() != CategoryType.PHOTOGRAPH.getValue()) {
					categorykeep.add(c);
				}
			}
			mv.addObject("category", categorykeep);
			mv.setViewName("supplier/goods/shoe/add");
		} else if (store.getSupplierType() == UserType.SERVICE_DECORATE) {// 店铺装修
			mv.addObject("properties", categoryService.queryPropertyByCategory(CategoryType.STORE_DECORATE.getValue()));
			mv.setViewName("supplier/goods/service/add");
		} else if (store.getSupplierType() == UserType.SERVICE_PHOTOGRAPH) {// 摄影
			mv.addObject("properties", categoryService.queryPropertyByCategory(CategoryType.PHOTOGRAPH.getValue()));
			mv.setViewName("supplier/goods/service/add");
		}

		return mv;
	}

	@RequestMapping("/changeShortcutGoodsStatus")
	@ResponseBody
	public MsgBean changeShortcutGoodsStatus(Shortcutgoods shortcutgoods) {
		int userId = SessionHelper.getSessionAdmin().getId();
		shortcutgoods.setHandlerId(userId);
		shortcutgoods.setHandleDate(new Date());
		boolean isOk = goodsService.changeShortcutGoodsStatus(shortcutgoods);
		if (isOk)
			return new MsgBean(Code.SUCCESS, "修改状态成功!", MsgLevel.NORMAL);
		return new MsgBean(Code.FAIL, "修改状态失败!", MsgLevel.ERROR);
	}

	/**
	 * 商品下架
	 *
	 * @param goodsID
	 * @return
	 */
	@RequestMapping("/soldout")
	@ResponseBody
	public MsgBean soldout(int goodsID, String soldOutReason) {
		Goods goods = goodsService.queryGoods(goodsID);
		if (goods == null) {
			return new MsgBean(Code.FAIL, "商品下架失败！", MsgLevel.ERROR);
		} else {
			goods.setStatus(GoodsStatus.SOLD_OUT.getValue());
			goodsService.updateGoods(goods);
			return new MsgBean(Code.SUCCESS, "商品下架成功！", MsgLevel.NORMAL);
		}
	}
}
