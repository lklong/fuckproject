/**
 * @ClassName: TaobaoSKUServiceImpl.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月18日
 * 
 */
package com.zhigu.service.taobao.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.Sku;
import com.taobao.api.request.ItemSkuAddRequest;
import com.taobao.api.response.ItemSkuAddResponse;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.model.ConvertSkuModel;
import com.zhigu.service.taobao.ITaobaoSKUService;

/**
 * @author Administrator
 *
 */
@Service
public class TaobaoSKUServiceImpl implements ITaobaoSKUService {

	public List<Sku> addItemSku(ConvertSkuModel model, Long numIId, String sessionKey) throws ApiException {

		List<Sku> skus = new ArrayList<Sku>();

		TaobaoClient client = new DefaultTaobaoClient(TaobaoConfig.API_URL, TaobaoConfig.APP_KEY, TaobaoConfig.APP_SECRET);
		ItemSkuAddRequest req = new ItemSkuAddRequest();
		req.setNumIid(numIId);

		List<ConvertSkuModel> models = model.getSkus();
		ItemSkuAddResponse response = null;
		for (ConvertSkuModel sku : models) {
			if (sku.getQuality() != null && sku.getPrice() != null) {
				req.setProperties(sku.getPropIdStr());// "1627207:28326;1630696:3266779"
				req.setQuantity(Long.valueOf(sku.getQuality()));
				req.setPrice(sku.getPrice().toString());
				response = client.execute(req, sessionKey);
				skus.add(response.getSku());
			}
		}

		return skus;

	}
}
