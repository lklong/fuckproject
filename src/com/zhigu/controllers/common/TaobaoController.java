package com.zhigu.controllers.common;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.taobao.api.ApiException;
import com.taobao.api.ApiRuleException;
import com.taobao.api.FileItem;
import com.taobao.api.TaobaoAPI;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.request.ItemAddRequest;
import com.taobao.api.response.ItemAddResponse;
import com.taobao.api.response.ItemcatsGetResponse;
import com.taobao.api.response.ItempropsGetResponse;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.model.Goods;
import com.zhigu.model.UserTaobao;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.user.IUserService;

/**
 * 淘宝API
 * 
 * @author HeSiMin
 * @date 2014年8月19日
 *
 */
@Controller
@RequestMapping("/tb")
public class TaobaoController {
	@Autowired
	private IUserService userService;
	@Autowired
	private IGoodsService goodsService;

	/**
	 * 引导用户到淘宝授权
	 * 
	 * @return
	 */
	@RequestMapping("/taobaoAuthorize")
	public String TaobaoAuthorize() {
		return "redirect:" + TaobaoConfig.AUTHORIZE_URL + "?client_id=" + TaobaoConfig.APP_KEY + "&response_type=code&redirect_uri=" + TaobaoConfig.LOCAL_URL + "/taobaoCallback&state=userid:"
				+ SessionHelper.getSessionUser().getUserID();
	}

	/**
	 * 商品发布到淘宝信息确认
	 * 
	 * @param mv
	 * @param commodityID
	 * @return
	 */
	@RequestMapping("/releaseConfirm")
	public ModelAndView releaseConfirm(ModelAndView mv, int goodsId) {
		SessionUser user = SessionHelper.getSessionUser();
		// SessionHelper.setAttribute(SystemConstants.SESSION_TO_TAOBAO_COMMODITY_ID,
		// commodityID);
		if (user == null) {
			mv.setViewName("redirect:/login");
			return mv;
		}
		UserTaobao userTaobao = userService.queryUserTaobaoByUserID(user.getUserID());
		if (userTaobao == null) {
			mv.setViewName("forward:/tb/taobaoAuthorize");
			return mv;
		}
		Goods goods = goodsService.queryGoods(goodsId);
		if (goods == null) {// 不存在的商品
			mv.setViewName("/index");
			return mv;
		}
		mv.addObject("goods", goods);
		try {
			mv.addObject("firstType", TaobaoAPI.getItemcatsTop().getItemCats());
		} catch (ApiException e) {
			// 淘宝链接异常
			e.printStackTrace();
		}
		mv.setViewName("taobao/releaseConfirm");
		return mv;
	}

	/**
	 * 商品分类
	 * 
	 * @param cid
	 * @return
	 */
	@RequestMapping("/itemcats")
	@ResponseBody
	public List<ItemCat> itemcats(Long cid) {
		ItemcatsGetResponse res = null;
		try {
			res = TaobaoAPI.getItemcats(cid);
			return res.getItemCats();
		} catch (ApiException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 商品类目属性
	 * 
	 * @param cid
	 * @return
	 */
	@RequestMapping("/itemProps")
	public ModelAndView itemProps(ModelAndView mv, Long cid) {
		ItempropsGetResponse res = null;
		try {
			res = TaobaoAPI.getItemProps(cid);
			List<ItemProp> list = res.getItemProps();
			Collections.sort(list, new Comparator<ItemProp>() {
				@Override
				public int compare(ItemProp o1, ItemProp o2) {
					return Long.valueOf(o1.getSortOrder()).compareTo(Long.valueOf(o2.getSortOrder()));
				}
			});
			mv.addObject("props", list);
		} catch (ApiException e) {
			e.printStackTrace();
		}
		mv.setViewName("taobao/show_attribute");
		return mv;
	}

	/**
	 * 将商品发布到淘宝
	 * 
	 * @param mv
	 * @param commodityID
	 * @return
	 */
	@RequestMapping("/releaseToTaobao")
	public ModelAndView releaseToTaobao(ModelAndView mv, ItemAddRequest req) {
		SessionUser user = SessionHelper.getSessionUser();
		if (user == null) {
			mv.setViewName("redirect:/login");
			return mv;
		}
		UserTaobao userTaobao = userService.queryUserTaobaoByUserID(user.getUserID());
		if (userTaobao == null) {
			mv.setViewName("redirect:/tb/taobaoAuthorize");
			return mv;
		}
		TaobaoClient client = TaobaoAPI.getTaobaoClient();
		req = new ItemAddRequest();
		req.setCid(162404L);
		req.setDesc("<P>miaoshushangping</P>");
		req.setLocationCity("成都");
		req.setLocationState("四川");
		req.setTitle("mytest:icewing100");
		req.setNum(99L);
		req.setPrice("321");
		req.setImage(new FileItem("D:\\QQ截图20140819133932.jpg"));
		req.setStuffStatus("new");
		req.setType("fixed");
		try {
			req.check();
		} catch (ApiRuleException e) {
			// 商品数据不正确
			e.printStackTrace();
		}
		ItemAddResponse response;
		try {
			response = client.execute(req, userTaobao.getAccess_token()); // 执行API请求
			if (!StringUtil.isEmpty(response.getErrorCode())) {
				mv.addObject("code", response.getErrorCode());
				mv.addObject("msg", response.getMsg());
				mv.setViewName("error/error-taobao");
			}
		} catch (ApiException e) {
		}
		return mv;
	}

}
