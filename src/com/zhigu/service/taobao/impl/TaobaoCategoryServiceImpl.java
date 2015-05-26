/**
 * 
 */
package com.zhigu.service.taobao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.request.ItemcatsGetRequest;
import com.taobao.api.response.ItemcatsGetResponse;
import com.zhigu.service.taobao.ITaobaoCategoryService;

/**
 * @author Administrator
 *
 */
@Service
public class TaobaoCategoryServiceImpl implements ITaobaoCategoryService {

	/**
	 * 获取类目的叶子目录
	 * 
	 * @param pid
	 *            类目的id
	 * @throws ApiException
	 */

	public List<ItemCat> getCats(Long pid) throws ApiException {

		TaobaoClient client = new DefaultTaobaoClient(API_URL, APP_KEY, APP_SECRET);

		ItemcatsGetRequest req = new ItemcatsGetRequest();

		req.setFields("cid,parent_cid,name,is_parent");

		req.setParentCid(pid);

		ItemcatsGetResponse response = client.execute(req);

		return response.getItemCats();

	}

	/**
	 * 获取叶子类目map
	 * 
	 * @param pid
	 * @return
	 * @throws ApiException
	 */

	public Map<String, Long> getTaobaoCatsMap(Long pid) throws ApiException {

		List<ItemCat> cats = getCats(pid);

		Map<String, Long> map = new HashMap<String, Long>();

		if (CollectionUtils.isNotEmpty(cats)) {

			for (ItemCat cat : cats) {

				map.put(cat.getName(), cat.getCid());

			}

		}

		return map;

	}

}
