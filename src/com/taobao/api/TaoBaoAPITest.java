package com.taobao.api;

import com.taobao.api.request.ItemAddRequest;
import com.taobao.api.request.UserSellerGetRequest;
import com.taobao.api.response.ItemAddResponse;
import com.taobao.api.response.UserSellerGetResponse;

public class TaoBaoAPITest {
	protected static String url = "http://gw.api.tbsandbox.com/router/rest";// 沙箱环境调用地址
	// 正式环境需要设置为:http://gw.api.taobao.com/router/rest
	protected static String appkey = "1023006443";
	protected static String appSecret = "sandbox503ed26f594e9d8dcf06982a3";
	protected static String sessionkey = "6101a12acfee9a2f8a141b1201519afd10c5730f45ed93c3655360001"; // 如

	// 沙箱测试帐号sandbox_c_1授权后得到的sessionkey

	public static void testUserGet() {
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, appSecret);// 实例化TopClient类
		UserSellerGetRequest req = new UserSellerGetRequest();// 实例化具体API对应的Request类
		req.setFields("nick,user_id,type");
		// req.setNick("sandbox_c_1");
		UserSellerGetResponse response;
		try {
			response = client.execute(req, sessionkey); // 执行API请求并打印结果
			System.out.println("result:" + response.getBody());

		} catch (ApiException e) {
			// deal error
		}
	}

	public static void testItemAdd() {
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, appSecret);// 实例化TopClient类
		ItemAddRequest req = new ItemAddRequest();
		req.setCid(162404L);
		req.setDesc("<P>miaoshushangping</P>");
		req.setLocationCity("成都");
		req.setLocationState("四川");
		req.setTitle("沙箱测试:icewing100");
		req.setNum(99L);
		req.setPrice("321");
		req.setImage(new FileItem("D:\\QQ截图20150204145657.jpg"));
		req.setStuffStatus("new");
		req.setType("fixed");
		req.setApproveStatus("instock");
		try {
			req.check();
		} catch (ApiRuleException e) {
			e.printStackTrace();
		}
		ItemAddResponse response;
		try {
			response = client.execute(req, sessionkey); // 执行API请求并打印结果
			System.out.println("result:" + response.getBody());

		} catch (ApiException e) {
			// deal error
		}
	}

	public static void main(String[] args) {
		TaoBaoAPITest.testItemAdd();
	}
}
