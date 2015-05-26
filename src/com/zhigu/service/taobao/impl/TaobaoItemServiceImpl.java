/**
 * 
 */
package com.zhigu.service.taobao.impl;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.Picture;
import com.taobao.api.request.ItemAddRequest;
import com.taobao.api.response.ItemAddResponse;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.mapper.GoodsMapper;
import com.zhigu.service.taobao.ITaobaoImageService;
import com.zhigu.service.taobao.ITaobaoItemService;

/**
 * @author Administrator
 *
 */
@Service
public class TaobaoItemServiceImpl implements ITaobaoItemService {

	private static final Logger LOGGER = LoggerFactory.getLogger(TaobaoItemServiceImpl.class);

	private static final TaobaoClient client = new DefaultTaobaoClient(TaobaoConfig.API_URL, TaobaoConfig.APP_KEY, TaobaoConfig.APP_SECRET);

	@Autowired
	private GoodsMapper goodsDao;

	@Autowired
	private ITaobaoImageService imageService;

	@Override
	public ItemAddResponse itemAdd(String access_token, int goodsId, ItemAddRequest req) throws ApiException {

		req.setLocationState("四川");

		req.setLocationCity("成都");

		req.setIsOffline("2");// 线上，下商品

		req.setType("fixed");

		req.setStuffStatus("new");

		// 处理属性
		String props = req.getProps();

		req.setProps(processProps(props));

		// 处理inputIds,inputStr
		String inputIds = req.getInputPids();

		String inputStr = req.getInputStr();

		if (StringUtils.isNotBlank(inputIds) && StringUtils.isNotBlank(inputStr)) {

			req.setInputPids(processProps(inputIds));

			req.setInputStr(processProps(inputStr));

		} else {

			req.setInputPids(null);

			req.setInputStr(null);

		}

		// 图片
		String picPath = req.getPicPath();

		List<Picture> pics = imageService.uploadToImageSpace(access_token, picPath);

		if (CollectionUtils.isNotEmpty(pics)) {

			String path = pics.get(0).getPicturePath();

			String path_name = path.substring(path.lastIndexOf("/"));

			path = path.substring(0, path.lastIndexOf("/"));

			path_name = path.substring(path.lastIndexOf("/")) + path_name;

			req.setPicPath(path_name);
		}

		String desc = req.getDesc();

		desc = imageService.proccessDesc(desc, access_token);

		req.setDesc(desc);

		ItemAddResponse response = client.execute(req, access_token);

		return response;

	}

	/**
	 * 属性字符串处理
	 * 
	 * @param props
	 * @return
	 */
	private String processProps(String props) {

		if (props.trim().startsWith(",")) {

			props = props.substring(props.indexOf(","));

		}

		props = props.replaceAll(",", ";").trim();

		return props;
	}

}
