package com.zhigu.service.taobao;

import com.taobao.api.ApiException;
import com.taobao.api.request.ItemAddRequest;
import com.taobao.api.response.ItemAddResponse;

public interface ITaobaoItemService {

	/**
	 * 发布商品到淘宝
	 * 
	 * @param assess_token
	 * @param goodsId
	 * @param req
	 * @return
	 */
	ItemAddResponse itemAdd(String assess_token, int goodsId, ItemAddRequest req) throws ApiException;

}
