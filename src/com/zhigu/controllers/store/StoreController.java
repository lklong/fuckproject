package com.zhigu.controllers.store;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.constant.BusinessArea;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.Flg;
import com.zhigu.common.constant.StoreType;
import com.zhigu.common.constant.enumconst.CompanyType;
import com.zhigu.common.constant.enumconst.GoodsStatus;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.DateUtil;
import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.CompanyAuth;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsCondition;
import com.zhigu.model.PageBean;
import com.zhigu.model.RealStoreAuth;
import com.zhigu.model.Store;
import com.zhigu.model.UserInfo;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.store.IStoreService;
import com.zhigu.service.user.IUserService;

/**
 * 店铺
 * 
 * @author HeSiMin
 * @date 2014年8月7日
 *
 */
@Controller
@RequestMapping("/store")
public class StoreController {
	@Autowired
	private IStoreService storeService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IGoodsService goodsService;

	/**
	 * 店铺
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("")
	public String store(String name, HttpServletResponse response) {
		return "forward:/store/index?domain=" + name;
	}

	/**
	 * 供应商家列表
	 * 
	 * @param page
	 * @param mv
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(String searchStoreName, Integer scope, PageBean<Store> page, ModelAndView mv) {

		// 分页查询店铺
		page.setPageSize(20);
		page = storeService.queryStoreByPage(page, scope, searchStoreName);

		mv.addObject("page", page);
		// 查询参数回传到画面

		mv.addObject("searchStoreName", searchStoreName);
		mv.addObject("scope", scope);
		mv.addObject("orderBy", page.getOrderBy());
		mv.addObject("businessAreas", BusinessArea.values());
		// 广告栏
		// mv.addObject("adRight",adService.queryADByGroup(ADGroupType.STORE_INDEX_RIGHT));
		mv.setViewName("store/list");

		return mv;
	}

	/**
	 * 查询店铺信息
	 * 
	 * @param storeId
	 * @return
	 */
	@RequestMapping("/info")
	@ResponseBody
	public MsgBean queryInfo(int storeId) {
		Store store = storeService.queryStoreByID(storeId);
		if (store == null) {
			return new MsgBean(Code.FAIL, "未找到店铺！", MsgLevel.ERROR);
		}
		UserInfo storeMaster = userService.queryUserInfoById(store.getUserID());
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			BeanUtils.populate(store, map);
		} catch (Exception e) {
			e.printStackTrace();
			return new MsgBean(Code.FAIL, "数据转换错误！", MsgLevel.ERROR);
		}
		map.put("isRealUserAuth", storeMaster.getRealUserAuthFlg() == Flg.ON);
		return ServiceMsg.getMsgBean().setData(map);
	}

	/**
	 * 店铺
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView index(PageBean<Goods> page, GoodsCondition gc, String domain, ModelAndView mv) {
		Store store = null;
		if (gc.getStoreId() != null) {
			store = storeService.queryStoreByID(gc.getStoreId());
		}
		if (store == null && !StringUtil.isEmpty(domain)) {
			store = storeService.queryStoreByDomain(domain);
		}
		if (store == null) {
			mv.addObject("msg", "很抱歉，未找到该店铺！");
			mv.setViewName("/error/error-tips");
			return mv;
		}

		gc.setStatus(GoodsStatus.NORMAL.getValue());// 正常
		page.setPageSize(50);

		if (store.getSupplierType() == StoreType.SUPPLIER) {
			gc.setSort(2);
			mv.setViewName("store/shoe/index");
		} else if (store.getSupplierType() == StoreType.SERVICE_DECORATE) {
			mv.setViewName("store/service/finish");
		} else if (store.getSupplierType() == StoreType.SERVICE_PHOTOGRAPH) {
			mv.setViewName("store/service/photograph/home");
		}
		goodsService.queryGoodsList(gc, page);

		mv.addObject("gc", gc);
		mv.addObject("page", page);
		mv.addObject("store", store);
		return mv;
	}

	/**
	 * 商品介绍
	 * 
	 * @param storeId
	 * @return
	 */
	@RequestMapping("/intro")
	public ModelAndView intro(int storeId, ModelAndView mv) {
		// 店铺相关信息
		Store store = storeService.queryStoreByID(storeId);
		if (store == null)
			return mv;
		GoodsCondition gc = new GoodsCondition();
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		gc.setStoreId(storeId);
		PageBean<Goods> page = new PageBean<Goods>();
		page.setPageSize(Integer.MAX_VALUE);
		goodsService.queryGoodsList(gc, page);
		int storeCommodityNumber = page.getDatas() == null ? 0 : page.getDatas().size();
		mv.addObject("storeCommodityNumber", storeCommodityNumber);

		// 企业认证
		CompanyAuth companyAuth = storeService.queryCompanyAuthByStoreID(storeId);
		if (companyAuth != null) {
			mv.addObject("companyType", CompanyType.getNameByValue(companyAuth.getCompanyType()));
		}
		// 实体认证
		RealStoreAuth realStoreAuth = storeService.queryRealStoreAuthByStoreID(storeId);

		mv.addObject("openStoreDate", DateUtil.format(store.getOpenStoreDate(), DateUtil.yyyy_MM_dd));
		mv.addObject("introduction", store.getIntroduction());
		mv.addObject(
				"address",
				StringUtil.nullToBlank(store.getProvince()) + " " + StringUtil.nullToBlank(store.getCity()) + " " + StringUtil.nullToBlank(store.getDistrict()) + " "
						+ StringUtil.nullToBlank(store.getStreet()) + " " + BusinessArea.getNameByValue(store.getBusinessArea() == null ? 0 : store.getBusinessArea()));
		mv.addObject("companyAuth", companyAuth);
		mv.setViewName("store/shoe/intro");
		mv.addObject("realStoreAuth", realStoreAuth);
		mv.addObject("store", store);
		return mv;
	}

	/**
	 * 店铺首页展示商品列表(inner部分用)
	 * 
	 * @param storeID
	 * @param pageNo
	 * @param mv
	 * @return
	 */
	@RequestMapping("/showCommodityList")
	public ModelAndView showCommodity(int storeID, @RequestParam(required = false) Integer pageNo, ModelAndView mv) {
		mv.setViewName("store/store_commodity_list");
		// 店铺商品分页
		PageBean page = new PageBean();
		page.setPageNo(pageNo == null ? 1 : pageNo.intValue());
		page = storeService.queryStoreGoodsByPage(page, storeID);
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * 店铺商品(用于店铺左下商品展示)
	 * 
	 * @param storeID
	 * @param orderBy
	 * @return
	 */
	@RequestMapping("commodityAreaPart")
	public ModelAndView commodityAreaPart(ModelAndView mv, int storeID, @RequestParam(required = false) Integer orderBy) {
		PageBean<Goods> page = new PageBean<Goods>();
		page.setPageNo(1);
		page.setPageSize(5);
		page.setOrderBy(orderBy);
		page = storeService.queryStoreGoodsByPage(page, storeID);
		mv.setViewName("store/store_area_part");
		mv.addObject("commodities", page.getDatas());
		mv.addObject("orderBy", orderBy);
		return mv;
	}

	/**
	 * 公司档案
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/dossier")
	public ModelAndView dossier(ModelAndView mv, int storeID) {
		mv.setViewName("store/service/dossier");
		// 店铺相关信息
		Store store = storeService.queryStoreByID(storeID);
		mv.addObject("openStoreDate", DateUtil.format(store.getOpenStoreDate(), DateUtil.yyyy_MM_dd));
		mv.addObject("introduction", store.getIntroduction());
		mv.addObject(
				"address",
				StringUtil.nullToBlank(store.getProvince()) + " " + StringUtil.nullToBlank(store.getCity()) + " " + StringUtil.nullToBlank(store.getDistrict()) + " "
						+ StringUtil.nullToBlank(store.getStreet()) + " " + BusinessArea.getNameByValue(store.getBusinessArea()));
		// 店铺商品总数

		GoodsCondition gc = new GoodsCondition();
		gc.setStatus(GoodsStatus.NORMAL.getValue());
		gc.setStoreId(storeID);
		PageBean<Goods> page = new PageBean<Goods>();
		page.setPageSize(Integer.MAX_VALUE);
		goodsService.queryGoodsList(gc, page);

		int storeCommodityNumber = page.getDatas() == null ? 0 : page.getDatas().size();
		mv.addObject("storeCommodityNumber", storeCommodityNumber);
		// 企业认证
		CompanyAuth companyAuth = storeService.queryCompanyAuthByStoreID(storeID);
		mv.addObject("companyAuth", companyAuth);
		if (companyAuth != null) {
			mv.addObject("companyType", CompanyType.getNameByValue(companyAuth.getCompanyType()));
		}
		// 实体认证
		RealStoreAuth realStoreAuth = storeService.queryRealStoreAuthByStoreID(storeID);
		mv.addObject("realStoreAuth", realStoreAuth);
		mv.addObject("store", store);
		return mv;
	}

	/**
	 * 公司档案
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping("/service/dossier")
	public ModelAndView serviceDossier(ModelAndView mv, int storeID) {
		mv.setViewName("store/service/dossier");
		// 店铺相关信息
		Store store = storeService.queryStoreByID(storeID);
		mv.addObject("openStoreDate", DateUtil.format(store.getOpenStoreDate(), DateUtil.yyyy_MM_dd));
		mv.addObject("introduction", store.getIntroduction());
		mv.addObject(
				"address",
				StringUtil.nullToBlank(store.getProvince()) + " " + StringUtil.nullToBlank(store.getCity()) + " " + StringUtil.nullToBlank(store.getDistrict()) + " "
						+ StringUtil.nullToBlank(store.getStreet()) + " " + BusinessArea.getNameByValue(store.getBusinessArea()));
		// 企业认证
		CompanyAuth companyAuth = storeService.queryCompanyAuthByStoreID(storeID);
		mv.addObject("companyAuth", companyAuth);
		if (companyAuth != null) {
			mv.addObject("companyType", CompanyType.getNameByValue(companyAuth.getCompanyType()));
		}
		// 实体认证
		RealStoreAuth realStoreAuth = storeService.queryRealStoreAuthByStoreID(storeID);
		mv.addObject("realStoreAuth", realStoreAuth);
		mv.addObject("store", store);
		return mv;
	}
}
