package com.zhigu.service.system;

import java.util.List;

import com.zhigu.model.Cement;
import com.zhigu.model.CementContent;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;

public interface CementContentService {

	/**
	 * 所有栏目下面的文章
	 * 
	 * @return
	 */
	public List<CementContent> findAllCementContent();

	/**
	 * 根据栏目类型查询不同栏目下的信息
	 * 
	 * @param type
	 * @return
	 */
	public List<CementContent> findPageHomeCementContent(int type);

	/**
	 * 查询所有信息列表
	 * 
	 * @param page
	 * @return
	 */
	public List<CementContent> queryCementContentsList(PageBean<CementContent> page);

	public List<Cement> queryCements();

	/**
	 * 根据id得到当前对象
	 * 
	 * @param id
	 * @return
	 */
	public CementContent findCementGetById(int id);

	/**
	 * 添加信息
	 * 
	 * @param cementContent
	 */
	public MsgBean saveCementContent(CementContent cementContent);

	/**
	 * 修改信息
	 * 
	 * @param cementContent
	 */
	public MsgBean updateCementContent(CementContent cementContent);

	/**
	 * 根据id删除信息
	 * 
	 * @param id
	 */
	public void deleteCementContentById(int id);

}
