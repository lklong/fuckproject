/**
 * @ClassName: BaseMapper.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月28日
 * 
 */
package com.zhigu.mapper;

/**
 * @author Administrator
 *
 */
public interface BaseMapper<T> {

	int insert(T record);

	int deleteById(Object id);

	T selectById(Object id);

	int update(T record);
}
