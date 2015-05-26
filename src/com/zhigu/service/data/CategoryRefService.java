/**
 * @ClassName: CategoryRefService.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年4月14日
 * 
 */
package com.zhigu.service.data;

import java.util.List;

import com.zhigu.model.CategoryRef;

/**
 * @author Administrator
 *
 */
public interface CategoryRefService {

	public CategoryRef add(CategoryRef ref);

	public CategoryRef getById(Integer id);

	public List<CategoryRef> selectAll();

	public int deleteByPrimaryKey(Integer id);

	CategoryRef selectTBCatByPlat(Integer catId);

}
