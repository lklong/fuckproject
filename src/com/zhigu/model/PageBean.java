package com.zhigu.model;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.Alias;

import com.zhigu.common.constant.SystemConstants;

@Alias("page")
public class PageBean<T> implements Serializable {
	/** 当前页码 */
	private Integer pageNo = 1;
	/** 总页数 */
	private int totalPage;
	/** 每页数量 */
	private int pageSize = SystemConstants.PAGINATION_PAGE_SIZE;
	/** 总条数 */
	private int totalRow;
	/** 取出数据 */
	private List<T> datas;
	/** 排序方式- *0:ASC、*1:DESC */
	private Integer orderBy;
	/** 分页开始行 */
	private int startRow;

	private Map<String, Object> paras = new HashMap<String, Object>();

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		if (pageNo == null || pageNo < 1)
			pageNo = 1;
		this.pageNo = pageNo;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		if (pageSize > SystemConstants.PAGINATION_PAGE_MAX_SIZE)
			pageSize = SystemConstants.PAGINATION_PAGE_MAX_SIZE;
		this.pageSize = pageSize;
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
		this.totalPage = (totalRow + (pageSize - 1)) / pageSize;
		this.totalPage = this.totalPage == 0 ? 1 : this.totalPage;
	}

	public List<T> getDatas() {
		return datas;
	}

	public void setDatas(List<T> datas) {
		this.datas = datas;
	}

	public int getStartRow() {
		return this.getPageSize() * (this.getPageNo() - 1);
	}

	public Integer getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(Integer orderBy) {
		this.orderBy = orderBy;
	}

	public Map<String, Object> getParas() {
		return paras;
	}

	public void setParas(Map<String, Object> paras) {
		this.paras = paras;
	}

	public void addParas(String key, Object obj) {
		this.paras.put(key, obj);
	}
}
