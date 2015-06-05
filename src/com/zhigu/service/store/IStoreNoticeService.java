package com.zhigu.service.store;

import java.util.List;

import com.zhigu.model.PageBean;
import com.zhigu.model.StoreNotice;
import com.zhigu.model.dto.MsgBean;

public interface IStoreNoticeService {

	/**
	 * 保存店铺公告
	 * 
	 * @param notice
	 */
	public MsgBean saveStoreNotice(Integer storeID, String content, int type);

	/**
	 * 根据店铺ID和类型查询店铺公告
	 * 
	 * @param storeID
	 * @param type
	 *            1:商品动态日志 2:商家日志
	 * @return
	 */
	public List<StoreNotice> queryStoreNoticeByPage(PageBean<StoreNotice> page, Integer storeID, Integer type);

	/**
	 * 删除指定ID的店铺公告
	 * 
	 * @param id
	 * @return
	 */
	public MsgBean delStoreNotice(Integer id);

}
