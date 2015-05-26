package com.zhigu.common.utils.logistics;
/**
 * http://www.ickd.cn/api/doc.html<br>
 * 查询接口配置
 * @author zhouqibing
 * 2014年8月16日上午9:30:15
 */
public class ExpressConfig {
	final static String ID = "106033";//在新版中ID为一个纯数字型，此时必须添加参数secret（secret为一个小写的字符串
	final static String URL = "http://api.ickd.cn";//api地址
	final static String SECRET = "6e86b4193da1c9fd76f2911190c3c910";//该参数为新增加，老用户可以使用申请时填写的邮箱和接收到的KEY值登录http://api.ickd.cn/users/查看对应secret值
	final static String TYPE = "json";//返回结果类型，值分别为 html | json（默认） | text | xml   ---> 解析是按照json来解析的，如更改此项，则需要修改Querier
	final static String ENCODE = "utf8";//gbk（默认）| utf8
	final static String ORDER = "asc";//asc（默认）|desc，返回结果排序
	final static String LANG = "en";//en返回英文结果，目前仅支持部分快递（EMS、顺丰、DHL）
	
}
