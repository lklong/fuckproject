package com.zhigu.mapper;

import java.util.List;

import com.zhigu.model.CementContent;
import com.zhigu.model.PageBean;

public interface CementContentMapper {

	/**
	 * 所有栏目下面的文章
	 * 
	 * @return
	 */
	public List<CementContent> queryAllCementContent();

	/**
	 * 根据栏目类型查询
	 * 
	 * @param type
	 * @return
	 */
	public List<CementContent> queryPageHomeCementContent(int type);

	/**
	 * 分页查询信息列表
	 * 
	 * @param page
	 * @return
	 */
	public List<CementContent> queryCementContentByPage(PageBean<CementContent> page);

	/**
	 * 根据id得到对象
	 * 
	 * @param id
	 * @return
	 */
	public CementContent queryById(int id);

	/**
	 * 添加信息
	 * 
	 * @param cementContent
	 */
	public void saveCementContent(CementContent cementContent);

	/**
	 * 修改信息
	 * 
	 * @param cementContent
	 */
	public void updateCementContent(CementContent cementContent);

	/**
	 * 删除信息
	 * 
	 * @param id
	 */
	public void deleteCementContentById(int id);

}
