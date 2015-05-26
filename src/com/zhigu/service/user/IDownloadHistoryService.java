package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.DownloadHistory;
import com.zhigu.model.PageBean;

/**
 * 用户下载历史
 * 
 * @author HeSiMin
 * @date 2014年8月7日
 *
 */
public interface IDownloadHistoryService {
	/**
	 * 添加下载历史记录
	 * 
	 * @param userID
	 * @param commodityID
	 */
	public void addDownloadHistory(int userID, int commodityID);

	/**
	 * 根据用户ID查询下载记录(userID必须，其他可为空)
	 * 
	 * @param userID
	 * @param commodityName
	 * @param storeName
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public List<DownloadHistory> queryDownloadHistoryByPage(PageBean<DownloadHistory> page);

	/**
	 * 批量删除
	 * 
	 * @param IDs
	 */
	public void deleteDownloadHistory(int[] IDs);
}
