/**
 * 
 */
package com.zhigu.service.alibaba.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import org.springframework.stereotype.Service;

import com.alibaba.openapi.client.Request;
import com.zhigu.common.alibaba.AlibabaUtil;
import com.zhigu.service.alibaba.AliItemCategoryService;

/**
 * @author Administrator
 *
 */
@Service
public class AliItemCategoryServiceImpl extends Thread implements AliItemCategoryService {

	/**
	 * 获取商品类目
	 * 
	 * @param pid
	 * @return
	 * @throws TimeoutException
	 * @throws ExecutionException
	 * @throws InterruptedException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<Map<String, Object>> getAliCategories(Long pid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "category.getCatListByParentId", VERSION);

		apiRequest.setParam("parentCategoryID", pid);

		apiRequest.setParam("getAllChildren", "F");

		Map<String, Object> object = AlibabaUtil.callAPI(accessToken, apiRequest, Map.class, false, false);

		ArrayList<Map<String, Object>> returnMap = AlibabaUtil.getReturnFromMap(object);

		return returnMap;
	}

	/**
	 * 本接口实现通过数据接口的形式，通过大市场叶子类目id，获取该类目的发布类目路径
	 * 
	 * @param cid
	 * @param accessToken
	 * @return
	 * @return
	 * @throws TimeoutException
	 * @throws ExecutionException
	 * @throws InterruptedException
	 */

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> getItemCatPath(Long cid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException {

		Request apiRequest = new Request(NAME_SPACE, "category.getCatePath", VERSION);

		apiRequest.setParam("categoryID", cid);

		Map<String, Object> object = AlibabaUtil.callAPI(accessToken, apiRequest, Map.class, false, true);

		// AliResult<Map<String, Object>> object =
		// AlibabaUtil.callAPI(accessToken, apiRequest, AliResult.class, false,
		// true);

		return AlibabaUtil.getReturnFromMap(object);
	}

	private static Set<Long> sets = new HashSet<Long>();

	private static List<Long> catIds = new ArrayList<Long>();

	public List<Long> getAllLeaves(long cid, String token) throws InterruptedException, ExecutionException, TimeoutException {

		ArrayList<Map<String, Object>> list = getAliCategories(cid, token);

		for (Map<String, Object> map : list) {

			Boolean leaf = (Boolean) map.get("leaf");

			Long catId = Long.valueOf(map.get("catsId").toString());

			if (!leaf) {

				getAllLeaves(catId, token);

			} else {

				catIds.add(catId);

			}

		}

		return catIds;
	}

	public Set<Long> getAllLeavesSet(long cid, String token) throws InterruptedException, ExecutionException, TimeoutException {

		ArrayList<Map<String, Object>> list = getAliCategories(cid, token);

		for (Map<String, Object> map : list) {

			Boolean leaf = (Boolean) map.get("leaf");

			Long catId = Long.valueOf(map.get("catsId").toString());

			if (!leaf) {

				getAllLeavesSet(catId, token);

			} else {

				sets.add(catId);

			}

		}

		return sets;
	}

}
