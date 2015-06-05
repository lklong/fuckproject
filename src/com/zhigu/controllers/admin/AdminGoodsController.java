package com.zhigu.controllers.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.CategoryType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.PageBean;
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
