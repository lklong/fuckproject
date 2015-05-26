package com.zhigu.service.system.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.mapper.CementContentMapper;
import com.zhigu.mapper.CementMapper;
import com.zhigu.model.Cement;
import com.zhigu.model.CementContent;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.system.CementContentService;

@Service
public class CementContentServiceImpl implements CementContentService {

	@Autowired
	private CementContentMapper cementContentMapper;

	@Autowired
	private CementMapper cementMapper;

	@Override
	public List<CementContent> findAllCementContent() {

		return cementContentMapper.queryAllCementContent();
	}

	public List<CementContent> findPageHomeCementContent(int type) {
		return cementContentMapper.queryPageHomeCementContent(type);
	}

	@Override
	public List<CementContent> queryCementContentsList(PageBean<CementContent> page) {

		return cementContentMapper.queryCementContentByPage(page);
	}

	@Override
	public CementContent findCementGetById(int id) {
		return cementContentMapper.queryById(id);
	}

	@Override
	public MsgBean saveCementContent(CementContent cementContent) {
		Cement c = cementMapper.selectByPrimaryKey(cementContent.getCementId());
		CementContent cc = new CementContent();
		cc.setCementId(cementContent.getCementId());
		cc.setTitle(cementContent.getTitle());
		cc.setContent(cementContent.getContent());
		cc.setAddTime(new Date());
		// cc.setCementimg(cementContent.getCementimg());
		cc.setSort(0);
		cc.setCementName(c.getName());
		cementContentMapper.saveCementContent(cc);
		return new MsgBean(Code.SUCCESS, "添加成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean updateCementContent(CementContent cementContent) {
		CementContent cc = cementContentMapper.queryById(cementContent.getId());
		Cement c = cementMapper.selectByPrimaryKey(cementContent.getCementId());
		cc.setCementId(cementContent.getCementId());
		cc.setTitle(cementContent.getTitle());
		cc.setContent(cementContent.getContent());
		cc.setAddTime(new Date());
		// cc.setCementimg(cementContent.getCementimg());
		cc.setSort(cementContent.getSort());
		cc.setCementName(c.getName());
		cementContentMapper.updateCementContent(cc);
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public void deleteCementContentById(int id) {
		CementContent cc = cementContentMapper.queryById(id);
		cementContentMapper.deleteCementContentById(cc.getId());
	}

	@Override
	public List<Cement> queryCements() {
		return cementMapper.queryCements();
	}
}
