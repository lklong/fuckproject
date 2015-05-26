/**
 * 
 */
package com.zhigu.service.alibaba;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeoutException;

import net.sf.json.JSONArray;

import com.zhigu.common.alibaba.AlibabaConfig;

/**
 * @author Administrator
 *
 */
public interface AliItemPropService extends AlibabaConfig {

	ArrayList<Map<String, Object>> getItemCateSPUProps(Long cid, String keyAttributes, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	ArrayList<Map<String, Object>> getItemCateProps(Long cid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	ArrayList<Map<String, Object>> getCateTradeProps(Long cid, String accessToken) throws InterruptedException, ExecutionException, TimeoutException;

	public JSONArray getChildrenProps(Long catId, String pathValues) throws UnsupportedEncodingException;

}
