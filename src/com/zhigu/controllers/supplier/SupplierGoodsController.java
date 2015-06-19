package com.zhigu.controllers.supplier;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.StoreNoticeType;
import com.zhigu.common.constant.UserType;
import com.zhigu.common.constant.enumconst.CategoryType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Category;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.GoodsImage;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.GoodsSku;
import com.zhigu.model.PageBean;
import com.zhigu.model.Property;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreNoticeService;
import com.zhigu.service.store.IStoreService;

/**
 * 商品
 * 
 * @author zhouqibing 2014年9月28日下午5:26:23
 */
@Controller
@RequestMapping("supplier/goods")
public class SupplierGoodsController {
	private static final Logger logger = Logger.getLogger(SupplierGoodsController.class);
	@Autowired
	private ICategoryService categoryService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IStoreNoticeService storeNoticeService;

	/**
	 * 发布商品
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/add")
	public ModelAndView add(ModelAndView mv) {
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserId());
		if (store.getSupplierType() == UserType.SUPPLIER) {// 普通供应商（实物）
			List<Category> category = categoryService.queryCategoryByParent(0);
			List<Category> categorykeep = new ArrayList<Category>();
			for (Category c : category) {
				// 排除服务类目
				if (c.getId() != CategoryType.STORE_DECORATE.getValue() && c.getId() != CategoryType.PHOTOGRAPH.getValue()) {
					// 2015.02.28 取消美妆、美食类目
					if (c.getId() != 103 && c.getId() != 74) {
						categorykeep.add(c);
					}
				}
			}
			mv.addObject("category", categorykeep);
			mv.setViewName("supplier/goods/shoe/add");
		} else if (store.getSupplierType() == UserType.SERVICE_DECORATE) {// 店铺装修
			mv.addObject("categoryId", CategoryType.STORE_DECORATE.getValue());
			mv.addObject("properties", categoryService.queryPropertyByCategory(CategoryType.STORE_DECORATE.getValue()));

			mv.setViewName("supplier/goods/service/add");
		} else if (store.getSupplierType() == UserType.SERVICE_PHOTOGRAPH) {// 摄影
			mv.addObject("categoryId", CategoryType.PHOTOGRAPH.getValue());
			mv.addObject("properties", categoryService.queryPropertyByCategory(CategoryType.PHOTOGRAPH.getValue()));
			mv.setViewName("supplier/goods/service/add");
		}
		return mv;
	}

	/**
	 * 保存商品
	 * 
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public MsgBean saveGoods(Goods goods, String propertyStr, String skuStr, String imagesStr) {
		List<GoodsProperty> properties = JSON.parseArray(propertyStr, GoodsProperty.class);
		List<GoodsSku> skus = JSON.parseArray(skuStr, GoodsSku.class);
		List<GoodsImage> images = JSON.parseArray(imagesStr, GoodsImage.class);

		return goodsService.saveGoods(goods, skus, properties, images);
	}

	/**
	 * 发布的服务列表
	 * 
	 * @param page
	 * @param mv
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView finishList(GoodsCondition gc, PageBean<Goods> page, ModelAndView mv) {
		page.setPageSize(10);

		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserId());
		if (gc.getStatus() == null)
			gc.setStatus(1);

		gc.setStoreId(store.getID());
		goodsService.queryGoodsList(gc, page);
		mv.addObject("gc", gc);
		mv.addObject("page", page);
		mv.setViewName("supplier/goods/list");
		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param goodsId
	 * @param mv
	 * @return
	 */
	@RequestMapping("/edit")
	public ModelAndView edit(Integer goodsId, ModelAndView mv) {
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserId());
		Goods goods = goodsService.queryGoods(goodsId);
		if (goods == null || goods.getStoreId() != store.getID())
			return mv;

		if (store.getSupplierType() == UserType.SUPPLIER) {// 普通供应商（鞋子）
			mv.setViewName("supplier/goods/shoe/edit");
		} else if (store.getSupplierType() == UserType.SERVICE_DECORATE || store.getSupplierType() == UserType.SERVICE_PHOTOGRAPH) {// 装修

			mv.setViewName("supplier/goods/service/edit");
		}

		List<Property> properties = categoryService.queryPropertyByCategory(goods.getCategoryId());
		mv.addObject("properties", properties);
		mv.addObject("goods", goods);

		return mv;
	}

	/**
	 * 保存商品
	 * 
	 * @return
	 */
	@RequestMapping("/update")
	@ResponseBody
	public MsgBean updateGoods(Goods goods, String propertyStr, String skuStr, String imagesStr) {
		List<GoodsProperty> properties = JSON.parseArray(propertyStr, GoodsProperty.class);
		List<GoodsSku> skus = JSON.parseArray(skuStr, GoodsSku.class);
		List<GoodsImage> images = JSON.parseArray(imagesStr, GoodsImage.class);

		return goodsService.updateGoods(goods, skus, properties, images);
	}

	/**
	 * 下架
	 * 
	 * @return
	 */
	@RequestMapping("/soldOut")
	@ResponseBody
	public MsgBean soldOut(Integer goodsId) {
		Store store = storeService.queryStoreByUserID(SessionHelper.getSessionUser().getUserId());
		Goods goods = goodsService.queryGoods(goodsId);
		if (goods.getStoreId() != store.getID()) {
			return new MsgBean(Code.FAIL, "不能操作其它商店的商品", MsgLevel.ERROR);
		}
		String msg = null;
		String flg = "";
		if (goods.getStatus() == GoodsStatus.NORMAL.getValue()) {
			goods.setStatus(GoodsStatus.SOLD_OUT.getValue());
			msg = "商品成功下架";
			flg = "  下架了  ";
		} else if (goods.getStatus() == GoodsStatus.SOLD_OUT.getValue()) {
			goods.setStatus(GoodsStatus.NORMAL.getValue());
			msg = "商品成功上架";
			flg = "  上架了  ";
		} else {
		}
		goodsService.updateGoods(goods);

		storeNoticeService.saveStoreNotice(store.getID(), store.getStoreName() + flg + goods.getName() + " 商品！", StoreNoticeType.GOODS);

		return new MsgBean(Code.SUCCESS, msg, MsgLevel.NORMAL);
	}

	/**
	 * 商品刷新
	 * 
	 * @param goodsID
	 * @return
	 * 
	 */
	@RequestMapping("/refresh")
	@ResponseBody
	public MsgBean refresh(@RequestParam(required = false) Integer goodsID) {
		return goodsService.updateGoodsRefreshDate(goodsID);
	}

	/**
	 * 删除商品
	 * 
	 * @return
	 */
	@RequestMapping("/delGoods")
	@ResponseBody
	public MsgBean delGoods(Integer goodsID) {
		Goods goods = goodsService.queryGoods(goodsID);
		if (goods == null)
			return new MsgBean(Code.FAIL, "未找到该商品", MsgLevel.ERROR);

		goods.setStatus(GoodsStatus.SOLD_OUT.getValue()); // 已删除的商品设置为下架

		goodsService.updateGoods(goods);
		goodsService.updateGoodsDeleteFlagByGoodsID(goods.getId(), true);// 并改变商品的删除标示

		return new MsgBean(Code.SUCCESS, "删除成功", MsgLevel.NORMAL);
	}
}
