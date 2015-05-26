/**
 * 
 */
package com.zhigu.model.alibaba;

import java.util.List;

/**
 * @author Administrator
 * @param <T>
 *
 */
public class AliResult<T> {

	private int total;

	private String success;

	private List<T> toReturn;

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public List<T> getToReturn() {
		return toReturn;
	}

	public void setToReturn(List<T> toReturn) {
		this.toReturn = toReturn;
	}

}
