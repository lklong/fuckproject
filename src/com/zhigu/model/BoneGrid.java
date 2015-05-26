package com.zhigu.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 
 * Ajax表格实体类
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
public class BoneGrid implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int currentPage;

	private int totalRowsCount;

	private List<String[]> rows;

	// 存在反序列化风险
	private List<GridColumn> columnsDef;

	private int totalPagesCount;

	private int pageSize;

	private int startIndex;

	public BoneGrid() {
		columnsDef = new ArrayList<GridColumn>();
		rows = new ArrayList<String[]>();
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRowsCount() {
		return totalRowsCount;
	}

	public void setTotalRowsCount(int totalRowsCount) {
		this.totalRowsCount = totalRowsCount;
	}

	public List<String[]> getRows() {
		return rows;
	}

	public void setRows(List<String[]> rows) {
		this.rows = rows;
	}

	public List<GridColumn> getColumnsDef() {
		return columnsDef;
	}

	public void setColumnsDef(List<GridColumn> columnsDef) {
		this.columnsDef = columnsDef;
	}

	public int getTotalPagesCount() {
		return (int) Math.ceil((double) totalRowsCount / (double) pageSize);
	}

	public void setTotalPagesCount(int totalPagesCount) {
		this.totalPagesCount = totalPagesCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public void addHeader(String[] header) {
		int index = 1;
		for (String item : header) {
			BoneGrid.GridColumn gridColumn = new BoneGrid.GridColumn();
			gridColumn.setId("item" + (index++));
			gridColumn.setCaption(item);
			gridColumn.setSortable(false);
			columnsDef.add(gridColumn);
		}
	}

	public class GridColumn {
		private String id;

		private String caption;

		private boolean sortable;

		private String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getCaption() {
			return caption;
		}

		public void setCaption(String caption) {
			this.caption = caption;
		}

		public boolean isSortable() {
			return sortable;
		}

		public void setSortable(boolean sortable) {
			this.sortable = sortable;
		}
	}
}