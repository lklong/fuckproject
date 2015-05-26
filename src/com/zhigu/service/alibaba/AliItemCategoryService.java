/**
 * 
 */
package com.zhigu.service.alibaba;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import com.zhigu.common.alibaba.AlibabaConfig;

/**
 * @author Administrator
 *
 */
public interface AliItemCategoryService extends AlibabaConfig {

	List<Map<String, Object>> getItemCatPath(Long cid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	ArrayList<Map<String, Object>> getAliCategories(Long pid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	String NAME_SPACE = "cn.alibaba.open";

	int VERSION = 1;

}
