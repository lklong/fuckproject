/**
 * 
 */
package com.zhigu.controllers.goods;

import java.io.UnsupportedEncodingException;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.model.Result;
import com.zhigu.service.goods.IGoodsService;
import com.zhigu.service.user.ICartService;

/**
 * @author liukailong 商品的ajax请求控制器
 */
@Controller
@RequestMapping("/ajax/goods")
public class AjaxGoodsController {

	/** 注入商品业务处理接口 */
	@Autowired
	private IGoodsService goodsService;

	@Autowired
	private ICartService cartService;

	/**
	 * 
	 * 商品名称自动补全控制器
	 * 
	 * @param keyword
	 * @return json对象
	 * @throws UnsupportedEncodingException
	 * 
	 */
	@RequestMapping("/names")
	@ResponseBody
	public JSONArray getGoodsNames(String term) throws UnsupportedEncodingException {

		JSONArray json = new JSONArray();

		List<String> goods = goodsService.queryGoodsNames(term);

		if (goods != null) {

			json = JSONArray.fromObject(goods);

		}

		return json;

	}

	/**
	 * sku 组合查询
	 * 
	 * @param goodsId
	 * @param sku1
	 * @param sku2
	 * @return
	 */
	@RequestMapping("/sku")
	@ResponseBody
	public Result getGoodsSkuByPropIdStr(int goodsId, String skuStr) {

		if (StringUtils.isBlank(skuStr)) {

			return new Result(false, "未正确选择销售属性");

		}
		return new Result(true, goodsService.queryGoodsSkuByPropStr(goodsId, skuStr));

	}

}
