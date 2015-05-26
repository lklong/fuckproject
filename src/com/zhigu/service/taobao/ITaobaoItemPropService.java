package com.zhigu.service.taobao;

import java.util.List;

import com.taobao.api.ApiException;
import com.taobao.api.domain.ItemProp;
import com.taobao.api.domain.PropValue;

public interface ITaobaoItemPropService {

	/**
	 * 获取商品属性
	 * 
	 * @param cid
	 * @return
	 * @throws ApiException
	 */
	List<ItemProp> getItemProp(Long cid) throws ApiException;

	/**
	 * 获取属性的属性值
	 * 
	 * @param cid
	 * @param propId
	 * @return
	 * @throws ApiException
	 */
	public List<PropValue> getPropValues(Long cid, Long propId) throws ApiException;

	/**
	 * 获取属性的信息
	 * 
	 * @param cid
	 * @param propId
	 * @return
	 */
	public ItemProp getProp(Long cid, Long propId);

}
