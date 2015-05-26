package com.zhigu.controllers.goods;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.CookieKey;
import com.zhigu.common.constant.StoreNoticeType;
import com.zhigu.common.constant.StoreType;
import com.zhigu.common.constant.enumconst.CategoryType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.model.Category;
import com.zhigu.model.DownloadHistory;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsAux;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.GoodsProperty;
import com.zhigu.model.PageBean;
import com.zhigu.model.Property;
import com.zhigu.model.Store;
import com.zhigu.model.StoreNotice;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.goods.IGoodsComplaintService;
import com.zhigu.service.goods.IGoodsEvaluateService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.storeNotice.IStoreNoticeService;
import com.zhigu.service.user.IDownloadHistoryService;
import com.zhigu.service.user.IFavouriteService;

/**
 * 商品
 * 
 * @author zhouqibing 2014年9月28日下午5:26:23
 */
@Controller
@RequestMapping("/goods")
public class GoodsController {
	@Autowired
	private ICategoryService categoryService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IFavouriteService favouriteService;
	@Autowired
	private IDownloadHistoryService downloadHistoryService;
	@Autowired
	private IGoodsComplaintService goodsComplaintService;
	@Autowired
	private IGoodsEvaluateService goodsEvaluateService;
	@Autowired
	private IStoreNoticeService storeNoticeService;

	/**
	 * 全部货源
	 * 
	 * @param page
	 * @param mv
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(Integer categoryId, PageBean<Goods> page, ModelAndView mv) {
		categoryId = categoryId == null ? CategoryType.WOMEN_SHOES.getValue() : categoryId;

		Category category = categoryService.queryCategoryById(categoryId);

		List<Category> childCategories = null;
		if (category.getIsParent()) {
			childCategories = categoryService.queryCategoryByParent(categoryId);
		} else {
			childCategories = categoryService.queryCategoryByParent(category.getParentId());
		}

		List<Property> properties = categoryService.queryPropertyByCategory(categoryId);
		Category paramCategory = categoryService.queryCategoryById(categoryId);

		GoodsCondition gc = new GoodsCondition();
		gc.setCategoryId(categoryId);
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		// gc.setSort(10);
		page.setPageSize(40);
		page.setDatas(goodsService.queryGoodsList(gc, page));

		mv.addObject("page", page);
		mv.addObject("childCategories", childCategories);
		mv.addObject("properties", properties);
		mv.addObject("categoryId", categoryId);
		mv.addObject("paramCategory", paramCategory);
		mv.setViewName("goods/goods/index");
		return mv;
	}

	/**
	 * ajax 查询,全部货源
	 * 
	 * @param page
	 * @param condition
	 * @param categoryID
	 * @param mv
	 * @return
	 */
	@RequestMapping("/ajaxShoe")
	public ModelAndView ajaxQueryShoe(PageBean<Goods> page, String[] property, GoodsCondition gc, ModelAndView mv) {
		page.setPageSize(20);
		List<GoodsProperty> list = null;
		// 条件处理
		if (property != null) {
			list = new ArrayList<GoodsProperty>();
			GoodsProperty gp = null;
			String[] ps = null;
			for (int i = 0; i < property.length; i++) {
				ps = property[i].split(":");
				gp = new GoodsProperty();
				gp.setPropertyId(Integer.parseInt(ps[0]));
				gp.setPropertyValueId(Integer.parseInt(ps[1]));
				list.add(gp);
			}
		}
		// 查询条件
		gc.setGps(list);
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		goodsService.queryGoodsList(gc, page);

		mv.setViewName("goods/goods/items");
		mv.addObject("page", page);

		return mv;
	}

	/**
	 * 装修服务
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/decorate")
	public ModelAndView decorate(PageBean<Goods> page, String[] condition, ModelAndView mv) {
		page.setPageSize(20);
		List<Property> properties = categoryService.queryPropertyByCategory(1);

		GoodsCondition gc = new GoodsCondition();
		gc.setCategoryId(1);
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		goodsService.queryGoodsList(gc, page);

		mv.setViewName("goods/service/decorate");
		mv.addObject("page", page);
		mv.addObject("properties", properties);

		return mv;
	}

	// 旧系统图片处理，大图切为300小图
	// @RequestMapping("/goodsImageHandle")
	// @ResponseBody
	// public String goodsImageHandle(int code, int pageNo) {
	// PageBean page = new PageBean();
	// page.setPageNo(pageNo);
	// page.setPageSize(50);
	// if (code == 99) {
	// List<Goods> gList = goodsService.queryGoodsList(new GoodsCondition(),
	// page);
	// this.image300Handle(gList, page);
	// }
	// return "==========ok";
	// }
	//
	// private void image300Handle(List<Goods> list, PageBean page) {
	// if (list != null && !list.isEmpty()) {
	// for (Goods g : list) {
	// logger.info("start-->pageNo=" + page.getPageNo() + "====" +
	// g.getImage300() + "***goodsID:" + g.getId());
	// String targetPath = g.getImage300();
	// if (targetPath.indexOf("_300") <= 0) {
	// targetPath = targetPath.substring(0, targetPath.indexOf(".")) + "_300" +
	// FileUtil.getFileExtensionName(targetPath).toLowerCase();
	// try {
	// FileUtil.imageResize(g.getImage300(), targetPath, 300);
	// g.setImage300(targetPath);
	// goodsService.updateGoods(g);
	// } catch (IOException e) {
	// logger.warn("fail======picture-300--fail>" + g.getImage300() +
	// "***goodsID:" + g.getId());
	// }
	// logger.info("ok----picture-300--ok>" + g.getImage300() + "***goodsID:" +
	// g.getId());
	// } else {
	// logger.warn("fail - 2======picture-300--fail>" + g.getImage300() +
	// "***goodsID:" + g.getId());
	// }
	// }
	// page.setPageNo(page.getPageNo() + 1);
	// List<Goods> gList = goodsService.queryGoodsList(new GoodsCondition(),
	// page);
	// this.image300Handle(gList, page);
	// } else {
	// return;
	// }
	// }

	/**
	 * 摄影服务
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/photograph")
	public ModelAndView photographIndex(PageBean<Goods> page, String[] condition, ModelAndView mv) {
		page.setPageSize(20);
		List<Property> properties = categoryService.queryPropertyByCategory(CategoryType.PHOTOGRAPH.getValue());

		GoodsCondition gc = new GoodsCondition();
		gc.setCategoryId(CategoryType.PHOTOGRAPH.getValue());
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		goodsService.queryGoodsList(gc, page);

		mv.setViewName("goods/service/photograph");
		mv.addObject("page", page);
		mv.addObject("properties", properties);

		return mv;
	}

	/**
	 * ajax查询商品
	 * 
	 * @param page
	 * @param condition
	 * @param mv
	 * @return
	 */
	@RequestMapping("/service/ajaxQueryGoods")
	public ModelAndView ajaxQueryGoods(PageBean<Goods> page, String[] condition, int categoryID, ModelAndView mv) {
		page.setPageSize(20);
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
		gc.setGps(list);
		gc.setCategoryId(categoryID);
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		goodsService.queryGoodsList(gc, page);

		mv.setViewName("goods/service/items");
		mv.addObject("page", page);

		return mv;
	}

	/**
	 * 商品描述特殊处理
	 * 
	 * @param desc
	 * @return
	 */
	private String process(String desc) {
		Document doc = Jsoup.parse(desc);
		Elements imgs = doc.select("img[src]");
		for (Element img : imgs) {
			String src = img.attr("src");
			img.attr("data-original", src).addClass("lazy").removeAttr("src");
		}
		return doc.getElementsByTag("body").html();
	}

	/**
	 * 商品详情
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/detail")
	public ModelAndView detail(Integer goodsId, HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		Goods goods = goodsService.queryGoods(goodsId);

		Map<String, List<GoodsProperty>> skuMap = goodsService.queryGoodsSkuFromProperty(goodsId);
		mv.addObject("skuMap", skuMap);

		if (goods == null) {
			// response.setStatus(404);
			mv.addObject("msg", "很抱歉，您查看的商品找不到了！");
			mv.setViewName("/error/error-tips");
			return mv;
		}
		// 描述特殊处理用于延迟加载
		String desc = goods.getDescription();
		if (StringUtils.isNotBlank(desc)) {
			String _desc = process(desc);
			goods.setDescription(_desc);
		}

		Store store = storeService.queryStoreByID(goods.getStoreId());
		if (store == null) {
			mv.addObject("msg", "很抱歉，您查看的商品找不到了！（商品数据不全）");
			mv.setViewName("/error/error-tips");
			return mv;
		}

		mv.addObject("store", store);
		mv.addObject("goods", goods);

		// 装修、摄影
		if (store.getSupplierType() == StoreType.SERVICE_DECORATE || store.getSupplierType() == StoreType.SERVICE_PHOTOGRAPH) {
			mv.setViewName("goods/service/detail");
		} else if (store.getSupplierType() == StoreType.SUPPLIER) {
			PageBean<Goods> page = new PageBean<Goods>();
			page.setPageSize(5);
			GoodsCondition gc = new GoodsCondition();
			gc.setStatus(GoodsStatus.NORMAL.getValue());
			gc.setStoreId(store.getID());
			gc.setSort(2);
			List<Goods> sellGoods = goodsService.queryGoodsList(gc, page);
			gc.setSort(6);
			List<Goods> download = goodsService.queryGoodsList(gc, page);

			PageBean<StoreNotice> snpage = new PageBean<StoreNotice>();
			snpage.setPageSize(5);
			snpage.setDatas(storeNoticeService.queryStoreNoticeByPage(snpage, store.getID(), StoreNoticeType.GOODS));

			mv.addObject("page", snpage);
			mv.addObject("sellGoods", sellGoods);
			mv.addObject("download", download);
			mv.addObject("statSell", statSellProperty(goods.getProperties()));
			mv.addObject("complaintType", goodsComplaintService.queryGoodsComplaintType());

			mv.setViewName("goods/goods/detail");
		}
		browseStat(goodsId, request, response);// 记录浏览次数
		return mv;
	}

	/**
	 * ajax查询商品信息
	 * 
	 * @param goodsId
	 * @return
	 */
	@RequestMapping("/ajaxQueryGoods")
	@ResponseBody
	public MsgBean ajaxQueryGoods(int goodsId) {

		Goods goods = goodsService.queryGoods(goodsId);
		if (goods != null)
			return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(goods);

		return new MsgBean(Code.FAIL, "出错了", MsgLevel.NORMAL);
	}

	private List<Map<String, Object>> statSellProperty(List<GoodsProperty> properties) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		Map<String, Set<String>> handlerMap = new HashMap<String, Set<String>>();
		for (GoodsProperty gp : properties) {
			if (!gp.isSku())
				continue;
			Set<String> nowSet = null;
			if (handlerMap.containsKey(gp.getPropertyName())) {
				nowSet = handlerMap.get(gp.getPropertyName());
			} else {
				nowSet = new HashSet<String>();
				// 以属性名做key，该属性值集合做value
				handlerMap.put(gp.getPropertyName(), nowSet);
			}
			nowSet.add(gp.getPropertyValueName());
		}
		Set<String> keys = handlerMap.keySet();
		if (keys.isEmpty())
			return resultList;

		Iterator<String> it = keys.iterator();
		while (it.hasNext()) {
			// 页面上使用key、count、names
			Map<String, Object> temp = new HashMap<String, Object>();
			String key = it.next();
			temp.put("key", key);
			// 数量
			Set<String> nowSet = handlerMap.get(key);
			temp.put("count", nowSet.size());
			// 属性值字符串拼接
			String str = "(";
			Iterator<String> iter = nowSet.iterator();
			while (iter.hasNext()) {
				str += iter.next();
				if (iter.hasNext()) {
					str += ";";
				}
			}
			str += ")";
			temp.put("names", str);
			resultList.add(temp);
		}
		return resultList;
	}

	/**
	 * 浏览次数统计
	 * 
	 * @param goodsId
	 * @param request
	 */
	private void browseStat(int goodsId, HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cs = request.getCookies();
		Cookie cookie = null;
		boolean isStat = false;// 是否记录
		if (cs != null) {
			for (Cookie c : cs) {
				if (CookieKey.BROWSE.equals(c.getName())) {
					cookie = c;
					break;
				}
			}
		}
		if (cookie != null) {
			String value = cookie.getValue();
			if (value.indexOf("[" + goodsId + "]") < 0) {
				cookie.setValue(value + "[" + goodsId + "]");
				response.addCookie(cookie);
				isStat = true;
			}
		} else {
			cookie = new Cookie(CookieKey.BROWSE, "[" + goodsId + "]");
			cookie.setMaxAge(60);// 60s
			response.addCookie(cookie);
			isStat = true;
		}
		// 修改记录
		if (isStat) {
			GoodsAux aux = goodsService.queryGoodsAux(goodsId);
			aux.setBrowseCount(aux.getBrowseCount() + 1);
			goodsService.updateGoodsAux(aux);
		}

	}

	/**
	 * 商品下载记录
	 * 
	 * @param page
	 * @param goodsId
	 * @return
	 */
	@RequestMapping("/downloadHistory")
	public ModelAndView downloadHistory(PageBean<DownloadHistory> page, Integer goodsId, ModelAndView mv) {
		page.setPageSize(30);
		goodsService.queryDownloadHistory(page, goodsId);
		mv.addObject("page", page);
		mv.addObject("goodsId", goodsId);
		mv.setViewName("goods/goods/download");
		return mv;
	}

	/**
	 * 下载商品数据包
	 * 
	 * @param goodsID
	 * @return
	 */
	@RequestMapping("/user/downloadDatas")
	@ResponseBody
	public MsgBean downloadDataZip(int goodsID) {
		if (SessionHelper.getSessionUser() == null) {
			return new MsgBean(Code.FAIL, "未登陆", MsgLevel.WARNING);
		}
		// 商品信息
		Goods goods = goodsService.queryGoods(goodsID);
		if (goods == null || goods.getFile() == null || goods.getFile().equals("")) {
			return new MsgBean(Code.FAIL, "没有数据可下载！", MsgLevel.WARNING);
		} else {
			if (!new File(ZhiguConfig.getSaveFileRoot() + goods.getFile()).exists()) {
				return new MsgBean(Code.FAIL, "没找到数据文件！", MsgLevel.ERROR);
			}
		}
		// 添加下载历史
		downloadHistoryService.addDownloadHistory(SessionHelper.getSessionUser().getUserID(), goodsID);

		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(goods.getFile());
	}
}
