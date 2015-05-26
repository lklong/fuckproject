package com.zhigu.service.taobao.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.domain.PropValue;
import com.taobao.api.request.ItempropsGetRequest;
import com.taobao.api.response.ItempropsGetResponse;
import com.zhigu.common.taobao.TaobaoConfig;
import com.zhigu.service.taobao.ITaobaoItemPropService;

@Service
public class TaobaoItemPropServiceImpl implements ITaobaoItemPropService {

	private static final Logger LOGGER = Logger.getLogger(TaobaoItemPropServiceImpl.class);

	private static final TaobaoClient client = new DefaultTaobaoClient(TaobaoConfig.API_URL, TaobaoConfig.APP_KEY, TaobaoConfig.APP_SECRET);

	/**
	 * 获取叶子类目的属性
	 * 
	 * @param cid
	 * @return
	 * @throws ApiException
	 */
	public List<ItemProp> getItemProp(Long cid) throws ApiException {

		ItempropsGetRequest req = new ItempropsGetRequest();

		req.setFields("pid,name,must,multi,prop_values,is_sale_prop,is_key_prop,is_input_prop,is_enum_prop,is_color_prop,is_allow_alias,type");

		req.setCid(cid);

		req.setType(1L);

		ItempropsGetResponse response = client.execute(req);

		return response.getItemProps();

	}

	public List<PropValue> getPropValues(Long cid, Long propId) throws ApiException {

		List<ItemProp> itemProps = getItemProp(cid);

		for (ItemProp prop : itemProps) {

			if (prop.getPid().equals(propId)) {

				return prop.getPropValues();

			}

		}

		return null;

	}

	public ItemProp getProp(Long cid, Long propId) {

		List<ItemProp> itemProps;

		try {
			itemProps = getItemProp(cid);
			for (ItemProp prop : itemProps) {

				if (prop.getPid().equals(propId)) {

					return prop;

				}

			}

		} catch (ApiException e) {

			LOGGER.error(e.getMessage());
		}

		return null;

	}

}
