package com.zhigu.service.storeNotice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.mapper.StoreMapper;
import com.zhigu.mapper.StoreNoticeMapper;
import com.zhigu.model.PageBean;
import com.zhigu.model.Store;
import com.zhigu.model.StoreNotice;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.storeNotice.IStoreNoticeService;

@Service
public class StoreNoticeServiceImpl implements IStoreNoticeService {
	@Autowired
	private StoreNoticeMapper storeNoticeMapper;
	@Autowired
	private StoreMapper storeMapper;

	@Override
	public MsgBean saveStoreNotice(Integer storeID, String content, int type) {
		Store store = storeMapper.queryStoreByID(storeID);
		if (store == null)
			return new MsgBean(Code.FAIL, "数据出错!", MsgLevel.ERROR);

		StoreNotice sn = new StoreNotice();
		sn.setContent(content);
		sn.setStoreID(store.getID());
		sn.setStoreName(store.getStoreName());
		sn.setType(type);

		storeNoticeMapper.saveStoreNotice(sn);

		return new MsgBean(Code.SUCCESS, "保存成功!", MsgLevel.NORMAL);
	}

	@Override
	public List<StoreNotice> queryStoreNoticeByPage(PageBean<StoreNotice> page, Integer storeID, Integer type) {
		return storeNoticeMapper.queryStoreNoticeByPage(page, storeID, type);
	}

	@Override
	public MsgBean delStoreNotice(Integer id) {
		int row = storeNoticeMapper.delStoreNotice(id);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL);
	}

}
