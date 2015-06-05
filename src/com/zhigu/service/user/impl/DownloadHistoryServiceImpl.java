package com.zhigu.service.user.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.mapper.DownloadHistoryMapper;
import com.zhigu.mapper.GoodsMapper;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.model.DownloadHistory;
import com.zhigu.model.Goods;
import com.zhigu.model.GoodsAux;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.service.user.IDownloadHistoryService;

@Service
public class DownloadHistoryServiceImpl implements IDownloadHistoryService {
	@Autowired
	private DownloadHistoryMapper downloadHistoryDao;
	@Autowired
	private StoreMapper storeDao;
	@Autowired
	private GoodsMapper goodsDao;

	@Override
	public void addDownloadHistory(int userID, int goodsID) {
		// 商品信息
		Goods goods = goodsDao.queryGoodsById(goodsID);
		Store store = storeDao.queryStoreByID(goods.getStoreId());

		// 店铺所有者下载数据包不添加下载历史
		if (userID != store.getUserID()) {

			// 先判断该用户是否下载过该商品的数据包
			DownloadHistory _downloadHistory = downloadHistoryDao.queryDownloadHistory(userID, goodsID);
			if (_downloadHistory == null) {
				// 添加下载历史
				DownloadHistory downloadHistory = new DownloadHistory();
				downloadHistory.setUserID(SessionHelper.getSessionUser().getUserID());
				downloadHistory.setGoodsID(goodsID);
				downloadHistory.setGoodsName(goods.getName());
				downloadHistory.setStoreID(goods.getStoreId());
				downloadHistory.setImagePath(goods.getImage300());
				downloadHistory.setMinPrice(goods.getMinPrice().doubleValue());
				downloadHistory.setMaxPrice(goods.getMaxPrice().doubleValue());
				downloadHistory.setDownloadTime(new Date());
				downloadHistory.setStoreName(store.getStoreName());
				downloadHistoryDao.addDownloadHistory(downloadHistory);

			}
			// 修改商品下载统计数
			GoodsAux goodsAux = goodsDao.queryGoodsAux(goodsID);
			goodsAux.setDownloadCount(goodsAux.getDownloadCount() + 1);
			goodsDao.updateGoodsAux(goodsAux);

			// TODO mapper之后需要其他方式实现 aux.setOverallScore((float)
			// (aux.getDownloadCount() / 2 + aux.getEvaluateCount() / 2 +
			// aux.getPurchaseCount() * 1.5 + aux.getFavouriteCount() +
			// aux.getBrowseCount() / 4.0));
		}
	}

	@Override
	public List<DownloadHistory> queryDownloadHistoryByPage(PageBean<DownloadHistory> page) {
		return downloadHistoryDao.queryDownloadHistoryByPage(page);
	}

	@Override
	public void deleteDownloadHistory(int[] IDs) {
		downloadHistoryDao.deleteDownloadHistoryByIDs(IDs);
	}

}
