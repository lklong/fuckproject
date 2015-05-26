/**
 * @ClassName: Result.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月14日
 * 
 */
package com.zhigu.model;

/**
 * @author Administrator
 *
 */
public class Result {

	private boolean status;

	private String msg;

	private Object data;

	public Result(boolean status) {
		super();
		this.status = status;
	}

	public Result() {
		super();
	}

	public Result(boolean status, Object data) {
		super();
		this.status = status;
		this.data = data;
	}

	public Result(boolean status, String msg) {
		super();
		this.status = status;
		this.msg = msg;
	}

	public Result(boolean status, String msg, Object data) {
		super();
		this.status = status;
		this.msg = msg;
		this.data = data;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
