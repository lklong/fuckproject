package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.DownloadHistory;
import com.zhigu.model.PageBean;

/**
 * 下载历史数据接口
 * 
 * @author HeSiMin
 * @date 2014年8月7日
 *
 */
public interface DownloadHistoryMapper {
	/**
	 * 添加下载历史记录
	 * 
	 * @param downloadHistory
	 */
	public void addDownloadHistory(DownloadHistory downloadHistory);

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
	public void deleteDownloadHistoryByIDs(int[] IDs);

	/**
	 * 查询下载历史
	 * 
	 * @param userID
	 * @param goodsID
	 * @return
	 */
	public DownloadHistory queryDownloadHistory(@Param("userId") int userId, @Param("goodsId") int goodsId);
}
