package com.zhigu.service.taobao;

import java.util.List;
import java.util.Map;

import com.taobao.api.ApiException;
import com.taobao.api.domain.ItemCat;
import com.zhigu.common.taobao.TaobaoConfig;

public interface ITaobaoCategoryService extends TaobaoConfig {

	/**
	 * 获取类目的叶子目录
	 * 
	 * @param pid
	 *            类目的id
	 * @throws ApiException
	 */

	List<ItemCat> getCats(Long pid) throws ApiException;

	/**
	 * 获取叶子类目map
	 * 
	 * @param pid
	 * @return
	 * @throws ApiException
	 */

	Map<String, Long> getTaobaoCatsMap(Long pid) throws ApiException;

}
