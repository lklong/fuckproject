package com.zhigu.common.utils.logistics;

import java.util.ArrayList;
import java.util.List;

import net.sf.ezmorph.bean.MorphDynaBean;

/**
 * 物流查询响应
 * 
 * @author zhouqibing 2014年8月16日上午9:16:46
 */
public class QueryResponse {

	private int status;// 查询结果状态，0|1|2|3|4，0表示查询失败，1正常，2派送中，3已签收，4退回,5其他问题
	private int errCode;// 错误代码，0无错误，1单号不存在，2验证码错误，3链接查询服务器失败，4程序内部错误，5程序执行错误，6快递单号格式错误，7快递公司错误，10未知错误，20API错误，21API被禁用，22API查询量耗尽。
	private String message;// 错误信息
	private List<Data> data;
	private String html;// 其他HTML，该字段不一定存在
	private String mailNo;// 快递单号
	private String expSpellName;// 快递公司英文代码
	private String expTextName;// 快递公司中文名
	private int update;// 最后更新时间（unix 时间戳）
	private int cache;// 缓存时间，当前时间与 update 之间的差值，单位为：秒
	private String ord;// 排序，ASC | DESC

	private String statusLabel;
	private String errCodeLabel;
	private String json;// json串

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getErrCode() {
		return errCode;
	}

	public void setErrCode(int errCode) {
		this.errCode = errCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<Data> getData() {
		return data;
	}

	// 注入为MorphDynaBean对象
	public void setData(List<MorphDynaBean> data) {
		if (data == null || data.isEmpty())
			return;
		this.data = new ArrayList<QueryResponse.Data>();
		for (MorphDynaBean mb : data) {
			this.data.add(new Data((String) mb.get("time"), (String) mb.get("context")));
		}
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getMailNo() {
		return mailNo;
	}

	public void setMailNo(String mailNo) {
		this.mailNo = mailNo;
	}

	public String getExpSpellName() {
		return expSpellName;
	}

	public void setExpSpellName(String expSpellName) {
		this.expSpellName = expSpellName;
	}

	public String getExpTextName() {
		return expTextName;
	}

	public void setExpTextName(String expTextName) {
		this.expTextName = expTextName;
	}

	public int getUpdate() {
		return update;
	}

	public void setUpdate(int update) {
		this.update = update;
	}

	public int getCache() {
		return cache;
	}

	public void setCache(int cache) {
		this.cache = cache;
	}

	public String getOrd() {
		return ord;
	}

	public void setOrd(String ord) {
		this.ord = ord;
	}

	// 0|1|2|3|4，0表示查询失败，1正常，2派送中，3已签收，4退回,5其他问题
	public String getStatusLabel() {
		switch (status) {
		case 0:
			statusLabel = "查询失败";
			break;
		case 1:
			statusLabel = "正常";
			break;
		case 2:
			statusLabel = "派送中";
			break;
		case 3:
			statusLabel = "已签收";
			break;
		case 4:
			statusLabel = "退回";
			break;
		default:
			statusLabel = "其他问题";
			break;
		}
		return statusLabel;
	}

	public String getErrCodeLabel() {
		return errCodeLabel;
	}

	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}

	// 物流进度
	static class Data {
		private String time;// 时间
		private String context;// 内容

		public Data() {
		}

		public Data(String time, String context) {
			super();
			this.time = time;
			this.context = context;
		}

		public String getTime() {
			return time;
		}

		public void setTime(String time) {
			this.time = time;
		}

		public String getContext() {
			return context;
		}

		public void setContext(String context) {
			this.context = context;
		}

	}
}
