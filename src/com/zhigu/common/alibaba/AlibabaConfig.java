/**
 * 
 */
package com.zhigu.common.alibaba;

/**
 * @author lkl
 *
 */
public interface AlibabaConfig {

	String redirect_uri = "http://127.0.0.1:8080/alibaba/category/choose";

	String client_id = "1017926";

	String secret_key = "tiGLwxEQW4";

	String site = "china";

	String code_url = "http://gw.open.1688.com/auth/authorize.htm";

	String token_url = "https://gw.open.1688.com/openapi/http/1/system.oauth2/getToken/";

	String host = "gw.open.1688.com"; // 国际交易请用"gw.api.alibaba.com"

	String grant_type = "authorization_code";

	Boolean need_refresh_token = true;

	String NAME_SPACE = "cn.alibaba.open";

	String img_host = "http://img.china.alibaba.com/";

	int VERSION = 1;

	String product_url = "http://detail.1688.com/offer/";// 商品详情地址

	String suffix = ".html";

	Long ALILADY_DRESS_ID = 10166L;// 女装
	Long ALIGENTLE_DRESS_CAT_PID = 10165L; // 男装
	Long ALICHILD_DRESS_CAT_PID = 311L; // 童装
	Long ALISHOE_CAT_CID = 1038378L;// 鞋

	int ZLADY_DRESS_CAT_PID = 19;// 女装
	int ZGENTLE_DRESS_CAT_PID = 20; // 男装
	int ZCHILD_DRESS_CAT_PID = 108; // 童装
	int ZSHOE_CAT_PID = 101;// 鞋子

}
