package com.zhigu.common.utils.logistics;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

/**
 * 物流查询器
 * 
 */
public class Querier {

	/**
	 * 物流查询
	 * 
	 * @param com
	 *            物流公司代码（英文)
	 * @param num
	 *            物流号
	 * @return
	 */
	public static JSONObject query(String com, String num) {
		JSONObject obj = new JSONObject();
		CloseableHttpClient httpclient = HttpClients.createDefault();
		QueryResponse queryResp = new QueryResponse();
		try {
			// 请求参数
			HttpPost httpPost = getRequestParam(com, num);
			// 执行查询并得到响应结果
			CloseableHttpResponse httpResp = httpclient.execute(httpPost);
			try {
				HttpEntity entity = httpResp.getEntity();
				// 解析
				obj = toJson(EntityUtils.toString(entity));
				EntityUtils.consume(entity);// 销毁entity
			} finally {
				httpResp.close();
			}
		} catch (Exception e) {
			queryResp.setStatus(0);// 查询失败
			e.printStackTrace();
		} finally {
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return obj;
	}

	/**
	 * 进度
	 * 
	 * @param com
	 * @param num
	 * @return
	 */
	public static JSONArray queryProgress(String com, String num) {
		return query(com, num).getJSONArray("data");
	}

	/**
	 * 查询请求参数
	 * 
	 * @param com
	 * @param num
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	private static HttpPost getRequestParam(String com, String num) throws UnsupportedEncodingException {
		HttpPost httpPost = new HttpPost(ExpressConfig.URL);
		// 请求参数
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("id", ExpressConfig.ID));
		nvps.add(new BasicNameValuePair("secret", ExpressConfig.SECRET));// key
		nvps.add(new BasicNameValuePair("type", ExpressConfig.TYPE));
		nvps.add(new BasicNameValuePair("ord", ExpressConfig.ORDER));
		nvps.add(new BasicNameValuePair("com", com));// 物流公司代码
		nvps.add(new BasicNameValuePair("nu", num));// 物流号

		httpPost.setEntity(new UrlEncodedFormEntity(nvps));// 参数进行url编码
		return httpPost;
	}

	/**
	 * 将json数据进行转换
	 * 
	 * @param json
	 * @return
	 */
	private static JSONObject toJson(String jsonStr) {
		return new JSONObject().fromObject(jsonStr);
	}
}