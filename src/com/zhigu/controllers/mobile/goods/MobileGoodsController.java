package com.zhigu.controllers.mobile.goods;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.goods.IGoodsService;

/**
 * 商品
 * 
 * @author HeSiMin
 * @date 2014年10月20日
 *
 */
@Controller
@RequestMapping("/mobile/goods")
public class MobileGoodsController {
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private ICategoryService categoryService;

	/**
	 * 商品列表
	 * 
	 * @return
	 */
	@RequestMapping("/goodsList")
	@ResponseBody
	public MsgBean goodsList(int pageNo, @RequestParam(required = false) String goodsName, @RequestParam(required = false) String[] condition, @RequestParam(required = false) Integer categoryID,
			@RequestParam(required = false) Integer sort) {
		PageBean page = new PageBean();
		page.setPageNo(pageNo);
		page.setPageSize(8);
		List<GoodsProperty> list = null;
		// 条件处理
		if (condition != null) {
			list = new ArrayList<GoodsProperty>();
			GoodsProperty gp = null;
			String[] ps = null;
			for (int i = 0; i < condition.length; i++) {
				ps = condition[i].split(":");
				gp = new GoodsProperty();
				gp.setPropertyId(Integer.parseInt(ps[0]));
				gp.setPropertyValueId(Integer.parseInt(ps[1]));
				list.add(gp);
			}
		}
		// 查询条件
		GoodsCondition gc = new GoodsCondition();
		if (!StringUtil.isEmpty(goodsName)) {
			gc.setGoodsName(goodsName);
		}
		gc.setSort(sort);
		gc.setGps(list);
		gc.setCategoryId(categoryID);
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		List<Goods> goodsList = goodsService.queryGoodsList(gc, page);
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(goodsList);
	}

	/**
	 * 商品详情
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/detail")
	@ResponseBody
	public MsgBean detail(Integer goodsId) {
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(goodsService.queryGoods(goodsId));
	}

	/**
	 * 商品类目
	 * 
	 * @param catagoryId
	 * @return
	 */
	@RequestMapping("/getCategoryByID")
	@ResponseBody
	public MsgBean getCategoryByID(int categoryID) {
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(categoryService.queryCategoryById(categoryID));
	}

	/**
	 * 商品子类目
	 * 
	 * @param catagoryId
	 * @return
	 */
	@RequestMapping("/getCategoryByParent")
	@ResponseBody
	public MsgBean getCategoryByParent(int categoryID) {
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(categoryService.queryCategoryByParent(categoryID));
	}

	/**
	 * 获取商品sku
	 * 
	 * @param goodsID
	 * @return
	 */
	@RequestMapping("/queryGoodsSku")
	@ResponseBody
	public MsgBean queryGoodsSku(int goodsID) {
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(goodsService.queryGoodsSkus(goodsID));
	}
}
