/**
 * @ClassName: PropValueRefService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月15日
 * 
 */
package com.zhigu.service.data;

import java.util.List;

import com.zhigu.model.ValueRef;

/**
 * @author Administrator
 *
 */
public interface ValueRefService {

	public int insertSelective(ValueRef record);

	/**
	 * @param refId
	 * @return
	 */
	public List<ValueRef> selectPropValueRefs(Integer refId);

	/**
	 * @param id
	 */
	public void deleteByPrimaryKey(Integer id);

}
