package com.zhigu.controllers.taobao.ajax;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taobao.api.ApiException;
import com.taobao.api.domain.Item;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.domain.Picture;
import com.taobao.api.request.ItemAddRequest;
import com.taobao.api.response.ItemAddResponse;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.SessionUser;
import com.zhigu.common.constant.enumconst.ApproveStatus;
import com.zhigu.common.taobao.JSONObject;
import com.zhigu.model.ConvertSkuModel;
import com.zhigu.service.taobao.ITaobaoCategoryService;
import com.zhigu.service.taobao.ITaobaoImageService;
import com.zhigu.service.taobao.ITaobaoItemPropService;
import com.zhigu.service.taobao.ITaobaoItemService;
import com.zhigu.service.taobao.ITaobaoSKUService;

/**
 * 
 * ajax调用淘宝接口获取数据淘宝数据
 * 
 * @author liukailong
 *
 */
@Controller
@RequestMapping("/taobao/ajax")
public class AjaxTaobaoGoodsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AjaxTaobaoGoodsController.class);

	@Autowired
	private ITaobaoCategoryService categoryService;

	@Autowired
	private ITaobaoItemService taobaoItemService;

	@Autowired
	private ITaobaoImageService imageService;

	@Autowired
	private ITaobaoItemPropService taobaoItemPropService;

	@Autowired
	private ITaobaoSKUService skuService;

	@RequestMapping(value = "/item/save", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public JSONObject editTaobaoItem(ConvertSkuModel skuModel, Integer goodsId, String key, String saleProps, String images, String upDate, String upHour, String upMinute, ItemAddRequest itemRequest)
			throws ParseException {

		SessionUser user = SessionHelper.getSessionUser();

		String approveStatus = itemRequest.getApproveStatus();

		if (ApproveStatus.schdule.getType().equals(approveStatus)) {
			// 上架时间
			Date date = DateUtils.parseDate(upDate + " " + upHour + ":" + upMinute, new String[] { "yyyy-MM-dd HH:mm" });

			itemRequest.setListTime(date);
		}

		String msg = "发布成功！";

		boolean status = true;

		if (StringUtils.isBlank(images)) {

			msg = "请选择一张主图！";

			status = false;

			return new JSONObject(msg, status);

		}

		try {

			String[] imageUrls = images.split(",");

			itemRequest.setPicPath(imageUrls[0]);

			ItemAddResponse response = taobaoItemService.itemAdd(key, goodsId, itemRequest);

			if (StringUtils.isNotBlank(response.getErrorCode())) {

				status = false;

				msg = response.getSubMsg();

				return new JSONObject(msg, status);

			} else {

				Item item = response.getItem();

				Long numIid = item.getNumIid();

				imageService.uploadItemImg(key, numIid, images);

				// 销售sku
				skuService.addItemSku(skuModel, numIid, key);

			}

			// 插入商品分销表
			taobaoItemService.saveGoodsDistribution(Long.valueOf(goodsId), itemRequest.getPrice().toString(), user.getUserID(), response.getItem().getNumIid());

		} catch (ApiException e) {

			LOGGER.error(e.getMessage());

			msg = "发布失败，请稍后再试！";

			status = false;

		}

		return new JSONObject(msg, status);

	}

	/**
	 * 获取叶子类目
	 * 
	 * @param pid
	 * @return
	 */
	@RequestMapping(value = "/category", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<ItemCat> getCategoriesByPid(Long pid) {

		List<ItemCat> categories = new ArrayList<ItemCat>();

		try {

			categories = categoryService.getCats(pid);

		} catch (ApiException e) {

			LOGGER.error(e.getMessage());
		}

		return categories;

	}

	/**
	 * 图片一键搬家功能
	 * 
	 * @param descImages
	 * @param access
	 * @return
	 */
	@RequestMapping(value = "/image/move", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public JSONObject moveImageToImageSpace(String descImages, String access) {

		boolean status = true;

		String msg = "搬家成功！";

		List<Picture> pics = new ArrayList<Picture>();

		try {

			pics = imageService.uploadToImageSpace(access, descImages);

		} catch (Exception e) {

			status = false;

			msg = "搬家失败！";

			LOGGER.error(e.getMessage());

		}

		return new JSONObject(msg, pics, status);

	}

	/**
	 * 
	 * @param cid
	 * @return
	 * @throws ApiException
	 */
	@RequestMapping("/props")
	@ResponseBody
	public JSONObject getProps(Long cid) throws ApiException {

		List<ItemProp> props = taobaoItemPropService.getItemProp(cid);

		return new JSONObject(props, true);

	}

}
