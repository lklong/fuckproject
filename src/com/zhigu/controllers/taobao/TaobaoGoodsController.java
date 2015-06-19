/**
 * 
 */
package com.zhigu.controllers.taobao;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.taobao.api.ApiException;
import com.taobao.api.domain.DeliveryTemplate;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.domain.SellerCat;
import com.taobao.api.domain.User;
import com.taobao.api.domain.UserInfo;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.enumconst.PlatType;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.common.utils.ZhiguConfig;
import com.zhigu.model.CategoryRef;
import com.zhigu.model.ConvertModel;
import com.zhigu.model.ConvertSkuModel;
import com.zhigu.model.Goods;
import com.zhigu.model.TaobaoToken;
import com.zhigu.service.convert.DataConvertService;
import com.zhigu.service.data.CategoryRefService;
import com.zhigu.service.goods.ICategoryService;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.taobao.ITaobaoCategoryService;
import com.zhigu.service.taobao.ITaobaoImageService;
import com.zhigu.service.taobao.ITaobaoItemPropService;
import com.zhigu.service.taobao.ITaobaoItemService;
import com.zhigu.service.taobao.ITaobaoTokenService;
import com.zhigu.service.taobao.ITaobaoUserRelateService;

/**
 * @author liukailong
 * 
 *         淘宝分销（需登录本系统）
 *
 */
@Controller
@RequestMapping("/user/tb")
public class TaobaoGoodsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(TaobaoGoodsController.class);

	@Autowired
	private ICategoryService categoryService;

	@Autowired
	private ITaobaoUserRelateService userRelateService;

	@Autowired
	private ITaobaoItemService itemService;

	@Autowired
	private ITaobaoImageService imageService;

	@Autowired
	private ITaobaoItemPropService itemPropService;

	@Autowired
	private ITaobaoCategoryService taobaoCategoryService;

	@Autowired
	private IGoodsService goodsService;

	@Autowired
	private DataConvertService dataConvertService;

	@Autowired
	private ITaobaoImageService taobaoImageService;

	@Autowired
	private CategoryRefService categoryRefService;

	@Autowired
	private ITaobaoTokenService taobaoTokenService;

	/**
	 * 授权登录
	 * 
	 * @param goodsId
	 * @param redirectAttributes
	 * @param session
	 * @return
	 */
	@RequestMapping("/auth")
	public String publishToTaobao(String goodsId, RedirectAttributes redirectAttributes, HttpSession session) {

		SessionUser user = SessionHelper.getSessionUser();

		int userId = user.getUserId();

		session.setAttribute(String.valueOf(userId), goodsId);

		TaobaoToken taobaoToken = taobaoTokenService.getTaobaoTokenByUserId(userId);
		if (taobaoToken != null && StringUtils.isNotBlank(taobaoToken.getAccessToken())) {

			String access_token = taobaoToken.getAccessToken().trim();
			// 测试access_token是否可用
			UserInfo userInfo = imageService.getUserInfo(access_token);

			if (userInfo != null) {
				redirectAttributes.addAttribute("state", goodsId);
				return "redirect:/user/tb/item/publish";

			}

		}

		String redirect_url = ZhiguConfig.getValue("taobao_redirect_url");

		return "redirect:" + TaobaoConfig.AUTHORIZE_URL + "?client_id=" + TaobaoConfig.APP_KEY + "&response_type=code&redirect_uri=" + redirect_url;

	}

	/**
	 * 切换用户
	 * 
	 * @return
	 */
	@RequestMapping("/auth/change")
	public String changeAuth(String goodsId, RedirectAttributes redirectAttributes, HttpSession session) {

		SessionUser user = SessionHelper.getSessionUser();

		int userId = user.getUserId();

		session.setAttribute(String.valueOf(userId), goodsId);

		String redirect_url = ZhiguConfig.getValue("taobao_redirect_url");

		return "redirect:" + TaobaoConfig.AUTHORIZE_URL + "?client_id=" + TaobaoConfig.APP_KEY + "&response_type=code&redirect_uri=" + redirect_url;
	}

	/**
	 * 初始化淘宝页面
	 * 
	 * @param code
	 *            授权码
	 * @param state
	 *            商品id
	 * @param session
	 * @param model
	 * @return
	 * @throws IOException
	 * @throws ApiException
	 */
	@RequestMapping("/item/publish")
	public String initPublishItem(String code, Integer state, HttpSession session, ModelMap model) throws IOException, ApiException {

		SessionUser sessionUser = SessionHelper.getSessionUser();

		Integer userId = sessionUser.getUserId();

		Object _goodsId = session.getAttribute(userId.toString());

		state = _goodsId == null ? state : Integer.valueOf(_goodsId.toString());

		// 处理服务器失效时，刷新页面获取不到数据问题
		if (state == null) {

			return "redirect:" + ZhiguConfig.getHost();

		}

		String access_token = "";

		// 登录超时，授权
		try {

			access_token = taobaoTokenService.getToken(code, userId);

		} catch (Exception e) {

			LOGGER.error("获取token出错：" + e.getMessage());

			return "redirect:/user/tb/auth?goodsId=" + state;

		}

		// 未开店处理
		User user = userRelateService.getUser(access_token);

		if (user == null || !user.getHasShop()) {

			return "/taobao/no_shop";

		}

		Goods goods = goodsService.queryGoods(state);

		// 描述处理(将描述图片搬家到淘宝图片空间)
		goods.setDescription(taobaoImageService.proccessDesc(goods.getDescription(), access_token));

		// 获取映射类目
		CategoryRef catRef = categoryRefService.selectTBCatByPlat(goods.getCategoryId());

		model.addAttribute("catRef", catRef);

		// 属性,sku转换
		List<ConvertModel> _props = dataConvertService.convertProperty(goods, PlatType.Taobao.getType(), catRef);

		List<ConvertSkuModel> skuProps = dataConvertService.convertSku(goods, PlatType.Taobao.getType(), catRef);

		model.addAttribute("converts", JSONArray.fromObject(_props));

		model.addAttribute("skus", skuProps);

		// 用户自定义商品发布目录
		Map<SellerCat, List<SellerCat>> shopCatsMap = getSellerCats(user.getNick());

		// 淘宝用户信息
		UserInfo userInfo = imageService.getUserInfo(access_token);

		// 用户运费模板
		List<DeliveryTemplate> deTemplates = userRelateService.getDeliveryTemplate(access_token);

		// 对应的淘宝类目
		Long cid = catRef.getThirdCatID();

		// 类目属性
		List<ItemProp> props = itemPropService.getItemProp(cid);

		// 图片服务器的地址
		model.addAttribute("image_server", ZhiguConfig.getValue("image_server"));

		model.addAttribute("deTemplates", deTemplates);

		model.addAttribute("userInfo", userInfo);

		model.addAttribute("shopCatsMap", shopCatsMap);

		model.addAttribute("props", props);

		model.addAttribute("goods", goods);

		model.addAttribute("user", user);

		model.addAttribute("key", access_token);

		return "/taobao/publish";

	}

	/**
	 * 用户自定义产品发布目录
	 * 
	 * @param nick
	 * @return
	 */
	private Map<SellerCat, List<SellerCat>> getSellerCats(String nick) {

		Map<SellerCat, List<SellerCat>> shopCatsMap = new LinkedHashMap<SellerCat, List<SellerCat>>();

		List<SellerCat> shopCats;
		try {
			shopCats = userRelateService.getSellerCats(nick);

			List<SellerCat> subSellerCats = null;

			for (SellerCat sell : shopCats) {

				if (sell.getParentCid().longValue() == 0) {

					subSellerCats = new LinkedList<SellerCat>();

					for (SellerCat sell1 : shopCats) {

						if (sell1.getParentCid().equals(sell.getCid())) {

							subSellerCats.add(sell1);

						}

					}

					shopCatsMap.put(sell, subSellerCats);

				}

			}
		} catch (ApiException e) {

			LOGGER.error("获取用户自定义产品发布目录失败：" + e.getMessage());

		}

		return shopCatsMap;

	}

}
