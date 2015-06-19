package com.zhigu.controllers.home;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.BusinessArea;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.CategoryType;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.geoip.GeoIPUtils;
import com.zhigu.common.utils.geoip.GeoVO;
import com.zhigu.common.utils.geoip.RequestIPUtils;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.AreaService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.system.CementContentService;
import com.zhigu.service.user.ICartService;
import com.zhigu.service.user.IOrderService;

/**
 * 首页
 * 
 * @author zhouqibing 2014年7月22日下午2:38:37
 */
@Controller
public class IndexController {

	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private CementContentService cementContentService;
	@Autowired
	private ICartService cartService;

	@Autowired
	private AreaService areaService;

	/** 全部商品页面每个类目下的商品条数 */
	private static final int PAGESIZE = 12;

	private GeoVO getCity(HttpServletRequest request, GeoVO geoVO) {
		String cityCode = geoVO.getCityCode();
		if (StringUtils.isBlank(cityCode)) {
			String ip = RequestIPUtils.getIpAddr(request);
			geoVO = GeoIPUtils.getAddressByIP(ip);
			if (StringUtils.isBlank(geoVO.getCity())) {
				cityCode = "510100";
			}
		}
		return geoVO;
	}

	/**
	 * 首页
	 * 
	 * @param mv
	 * @param city
	 *            默认为 ：成都
	 * @return
	 */
	@RequestMapping("/welcome")
	public ModelAndView welcome(ModelAndView mv, GeoVO geoVO, HttpServletRequest request) {

		geoVO = getCity(request, geoVO);
		String cityCode = geoVO.getCityCode();

		mv.addObject("cAction", "welcome");
		PageBean<Goods> page = new PageBean<Goods>();
		page.setPageSize(PAGESIZE);
		Map<String, Object> paras = page.getParas();
		paras.put("cityCode", cityCode);
		page.setParas(paras);

		// 男鞋
		GoodsCondition gc = new GoodsCondition();

		gc.setCategoryId(CategoryType.MAN_SHOES.getValue());
		List<Goods> manShoes = goodsService.queryGoodsList(gc, page);
		mv.addObject("manShoes", manShoes);

		// 女鞋
		gc.setCategoryId(CategoryType.WOMAN_SHOES.getValue());
		List<Goods> womanShoes = goodsService.queryGoodsList(gc, page);
		mv.addObject("womanShoes", womanShoes);

		// 男装
		gc.setCategoryId(CategoryType.MAN_DRESS.getValue());
		List<Goods> manDress = goodsService.queryGoodsList(gc, page);
		mv.addObject("manDress", manDress);

		// 女装
		gc.setCategoryId(CategoryType.WOMAN_DRESS.getValue());
		List<Goods> womanDress = goodsService.queryGoodsList(gc, page);
		mv.addObject("womanDress", womanDress);

		// 童鞋
		gc.setCategoryId(CategoryType.CHILDREN_SHOES.getValue());
		List<Goods> childrenShoes = goodsService.queryGoodsList(gc, page);
		mv.addObject("childrenShoes", childrenShoes);

		// 童装
		gc.setCategoryId(CategoryType.CHILDREN_DRESS.getValue());
		List<Goods> childrenDress = goodsService.queryGoodsList(gc, page);
		mv.addObject("childrenDress", childrenDress);

		// 热销
		page.setPageSize(5);
		gc.setCategoryId(null);

		List<Goods> hotSale = goodsService.queryGoodsList(gc, page);
		mv.addObject("hotSale", hotSale);
		mv.setViewName("welcome");
		return mv;
	}

	/**
	 * 搜索店铺列表
	 * 
	 * @param mv
	 * @param pageNo
	 * @param businessArea
	 * @param orderBy
	 * @return
	 */
	@RequestMapping("searchStore")
	public ModelAndView searchStore(ModelAndView mv, GeoVO geoVO, @RequestParam(required = false) Integer pageNo, @RequestParam(required = false) Integer businessArea,
			@RequestParam(required = false) String searchName, HttpServletRequest request) {

		geoVO = getCity(request, geoVO);
		String cityCode = geoVO.getCityCode();

		// mv.setViewName("home/search_store");
		mv.setViewName("store/list");

		PageBean<Store> page = new PageBean<Store>();
		Map<String, Object> paras = page.getParas();
		paras.put("cityCode", cityCode);
		page.setParas(paras);

		if (pageNo != null) {
			page.setPageNo(pageNo);
		}
		if (page.getOrderBy() == null || page.getOrderBy() == 0) {
			page.setOrderBy(31);
		}
		// 分页查询店铺
		page.setPageSize(10);
		page = storeService.queryStoreByPage(page, businessArea, searchName);
		// 查询店铺的商品
		for (Store s : page.getDatas()) {
			PageBean<Goods> pageGoods = new PageBean<Goods>();
			pageGoods.setPageSize(4);
			pageGoods.setPageNo(1);
			pageGoods = storeService.queryStoreGoodsByPage(pageGoods, s.getID());
			s.setGoods(pageGoods.getDatas());
		}
		mv.addObject("page", page);
		// 查询参数回传到画面
		mv.addObject("businessAreas", BusinessArea.values());
		mv.addObject("businessArea", businessArea);
		mv.addObject("orderBy", page.getOrderBy());
		mv.addObject("searchName", searchName);
		return mv;

	}

	/**
	 * 搜索商品
	 * 
	 * @param mv
	 * @param pageNo
	 * @param searchName
	 * @return
	 */
	@RequestMapping("/searchCommodity")
	public ModelAndView searchCommodity(ModelAndView mv, GeoVO geoVO, @RequestParam(required = false) Integer pageNo, @RequestParam(required = false) String searchName,
			@RequestParam(defaultValue = "0") Integer storeID, HttpServletRequest request) {
		PageBean<Goods> page = new PageBean<Goods>();

		geoVO = getCity(request, geoVO);
		String cityCode = geoVO.getCityCode();

		Map<String, Object> paras = page.getParas();
		paras.put("cityCode", cityCode);
		page.setParas(paras);

		page.setPageSize(24);
		page.setPageNo(pageNo == null ? 1 : pageNo.intValue());
		Goods goods = new Goods();
		goods.setName(searchName);
		goods.setStoreId(storeID);
		GoodsCondition gc = new GoodsCondition();
		gc.setGoodsName(searchName);
		mv.addObject("goods", goodsService.queryGoodsList(gc, page));
		mv.addObject("searchName", searchName);
		mv.addObject("storeID", storeID);
		mv.addObject("page", page);
		mv.setViewName("home/search_commodity");
		return mv;
	}

	/**
	 * 前台商品检索
	 * 
	 * @param model
	 * @param pageNo
	 * @param propName
	 * @param storeName
	 * @param goodsName
	 * @return
	 */
	@RequestMapping(value = "/home/search", method = { RequestMethod.POST, RequestMethod.GET })
	public String indexSearch(ModelMap model, GeoVO geoVO, RedirectAttributesModelMap redirectAttributesModelMap, @RequestParam(required = false) Integer pageNo,
			@RequestParam(required = false) String propName, @RequestParam(required = false) String storeName, @RequestParam(required = false) String goodsName, HttpServletRequest request) {

		geoVO = getCity(request, geoVO);
		String cityCode = geoVO.getCityCode();

		pageNo = pageNo == null ? 1 : pageNo;

		// 店铺搜索
		if (StringUtils.isNotBlank(storeName)) {
			redirectAttributesModelMap.addAttribute("pageNo", pageNo);
			redirectAttributesModelMap.addAttribute("searchStoreName", storeName);
			redirectAttributesModelMap.addAttribute("cityCode", cityCode);
			return "redirect:/store/list";
		}

		// 商品货号，名称搜索
		PageBean<Goods> page = goodsService.queryForHome(pageNo, propName, goodsName, cityCode);

		model.addAttribute("storeName", storeName);
		model.addAttribute("propName", propName);
		model.addAttribute("goodsName", goodsName);

		model.addAttribute("page", page);

		return "home/searchGoods";
	}

	/**
	 * 右边栏里购物车和订单的数量统计显示
	 * 
	 * @return json数组
	 */
	@RequestMapping("/index/count")
	@ResponseBody
	public MsgBean indexCount() {
		Map<String, Integer> map = new HashMap<String, Integer>();

		SessionUser user = SessionHelper.getSessionUser();

		if (user == null) {
			map.put("cartCount", 0);
			map.put("orderCount", 0);
			return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(map);
		}

		map.put("cartCount", cartService.countNumByUserId(user.getUserId()));
		map.put("orderCount", orderService.queryOrderCountByUserID(user.getUserId()));

		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(map);
	}

	/**
	 * 专题页
	 * 
	 * @return
	 */
	@RequestMapping("/topic")
	public String indexTopic(ModelMap model, GeoVO geoVO, HttpServletRequest request) {

		// TODO 专题数据过滤
		return "index";
	}

	/**
	 * 位置初始化
	 * 
	 * @return
	 */
	@RequestMapping("/ajax/addr")
	@ResponseBody
	public MsgBean getAddr(String parentId, GeoVO geoVO, HttpServletRequest request) {

		String city = geoVO.getCity();
		if (StringUtils.isBlank(city)) {
			String ip = RequestIPUtils.getIpAddr(request);
			geoVO = GeoIPUtils.getAddressByIP(ip);
			if (StringUtils.isBlank(geoVO.getCity())) {
				geoVO.setCityCode("510100");
			}
		}
		MsgBean msgBean = new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL);
		msgBean.setData(geoVO);
		return msgBean;
	}

}
