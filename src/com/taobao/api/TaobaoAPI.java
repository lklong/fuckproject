package com.taobao.api;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.domain.PropValue;
import com.taobao.api.internal.util.WebUtils;
import com.taobao.api.request.ItemcatsGetRequest;
import com.taobao.api.request.ItempropsGetRequest;
import com.taobao.api.request.ItempropvaluesGetRequest;
import com.taobao.api.response.ItemcatsGetResponse;
import com.taobao.api.response.ItempropsGetResponse;
import com.taobao.api.response.ItempropvaluesGetResponse;

public class TaobaoAPI {
	public static TaobaoClient getTaobaoClient() {
		// 实例化TopClient类
		return new DefaultTaobaoClient(TaobaoConfig.API_URL, TaobaoConfig.APP_KEY, TaobaoConfig.APP_SECRET);
	}

	/**
	 * 获取后台供卖家发布商品的标准商品类目<br/>
	 * 顶级类目使用：getItemcatsTop
	 * 
	 * @param parentCid
	 * @return
	 * @throws ApiException
	 */
	public static ItemcatsGetResponse getItemcats(long parentCid) throws ApiException {
		TaobaoClient client = TaobaoAPI.getTaobaoClient();
		ItemcatsGetRequest req = new ItemcatsGetRequest();
		req.setParentCid(parentCid);
		return client.execute(req);
	}

	/**
	 * 取得商品顶级类目
	 * 
	 * @return
	 * @throws ApiException
	 */
	public static ItemcatsGetResponse getItemcatsTop() throws ApiException {
		ItemcatsGetResponse response = TaobaoAPI.getItemcats(0L);
		// 排除掉不需要的类目
		List<ItemCat> newItemCats = new ArrayList<ItemCat>();
		for (ItemCat ic : response.getItemCats()) {
			if (ic.getName().contains("男鞋") || ic.getName().contains("女鞋")) {
				newItemCats.add(ic);
			}
		}
		response.setItemCats(newItemCats);
		return response;
	}

	/**
	 * 获取标准商品类目属性
	 * 
	 * @param cid
	 * @return
	 * @throws ApiException
	 */
	public static ItempropsGetResponse getItemProps(long cid) throws ApiException {
		TaobaoClient client = TaobaoAPI.getTaobaoClient();
		ItempropsGetRequest req = new ItempropsGetRequest();
		req.setFields("pid,name,must,multi,prop_values,is_color_prop,is_enum_prop,is_input_prop,is_sale_prop,sort_order");
		req.setCid(cid);
		return client.execute(req);
	}

	/**
	 * 获取标准类目属性值(非预期测试结果！)
	 * 
	 * @return
	 * @throws ApiException
	 */
	public static ItempropvaluesGetResponse getItempropvalues(long cid, String pvs) throws ApiException {
		TaobaoClient client = TaobaoAPI.getTaobaoClient();
		ItempropvaluesGetRequest req = new ItempropvaluesGetRequest();
		req.setCid(cid);
		req.setPvs(pvs);
		req.setFields("cid,pid,prop_name,vid,name,name_alias,status,sort_order");
		return client.execute(req);
	}

	public static Map<String, String> splitTaobaoState(String state) {
		Map<String, String> map = new HashMap<String, String>();
		String[] states = state.split(";");
		String[] userids = states[0].split(":");
		map.put(userids[0], userids[1]);
		return map;
	}

	/**
	 * 获取访问淘宝用户令牌
	 * 
	 * @return
	 */
	public static Map<String, String> accessToken(String code) {
		Map<String, String> props = new HashMap<String, String>();
		props.put("grant_type", "authorization_code");
		props.put("code", code);
		props.put("client_id", TaobaoConfig.APP_KEY);
		props.put("client_secret", TaobaoConfig.APP_SECRET);
		props.put("redirect_uri", TaobaoConfig.LOCAL_URL);
		Map<String, String> resultMap = null;
		try {
			String accessTokenJson = WebUtils.doPost(TaobaoConfig.TOKEN_URL, props, 30000, 30000);
			resultMap = JSON.parseObject(accessTokenJson, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	public static void main(String[] args) {
		try {
			ItemcatsGetResponse ict = TaobaoAPI.getItemcatsTop();
			for (ItemCat ic : ict.getItemCats()) {
				System.out.println("top:" + ic.getName());
				ItemcatsGetResponse ict2 = TaobaoAPI.getItemcats(ic.getCid());
				for (ItemCat ic2 : ict2.getItemCats()) {
					ItempropsGetResponse props = TaobaoAPI.getItemProps(ic2.getCid());
					System.out.println("2级类目:" + ic2.getName() + "IsParen" + ic2.getIsParent());
					for (ItemProp p : props.getItemProps()) {
						System.out.println("--prop:" + p.getName());
						for (PropValue pv : p.getPropValues() == null ? new ArrayList<PropValue>() : p.getPropValues()) {
							System.out.println("------prop-value:" + pv.getName());
						}
					}
				}
			}
		} catch (ApiException e) {
			e.printStackTrace();
		}
	}
}
