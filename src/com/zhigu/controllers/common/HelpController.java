package com.zhigu.controllers.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.model.CementContent;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.system.CementContentService;

@Controller
@RequestMapping("/help")
public class HelpController {
	/**
	 * 栏位5 智谷公告可能会随时发布 控制为5条显示
	 */
	private static final int COLUMN_NUMBER = 5;
	/**
	 * 文章栏目类型新手指南
	 */
	private static final int COLUMN_TYPE_NEW = 1;
	/**
	 * 文章栏目类型关与我们
	 */
	private static final int COLUMN_TYPE_WE = 3;
	/**
	 * 文章栏目类型公告
	 */
	private static final int COLUMN_TYPE_ANNOUN = 5;

	@Autowired
	private CementContentService cementContentService;

	@RequestMapping(value = "/home/cementcontents")
	@ResponseBody
	public MsgBean homePageShowCementContentAll(int type) {
		List<CementContent> cementContentAll = cementContentService.findPageHomeCementContent(type);
		if (type == COLUMN_TYPE_NEW) {
			if (cementContentAll.size() <= COLUMN_NUMBER) {
				ServiceMsg.getMsgBean().setData(cementContentAll);
			} else {
				ServiceMsg.getMsgBean().setData(cementContentAll.subList(0, COLUMN_NUMBER));
			}
		} else if (type == COLUMN_TYPE_WE) {
			if (cementContentAll.size() <= COLUMN_NUMBER) {
				ServiceMsg.getMsgBean().setData(cementContentAll);
			} else {
				ServiceMsg.getMsgBean().setData(cementContentAll.subList(0, COLUMN_NUMBER));
			}
		} else if (type == COLUMN_TYPE_ANNOUN) {
			if (cementContentAll.size() <= COLUMN_NUMBER) {
				ServiceMsg.getMsgBean().setData(cementContentAll);
			} else {
				ServiceMsg.getMsgBean().setData(cementContentAll.subList(0, COLUMN_NUMBER));
			}
		}
		return ServiceMsg.getMsgBean();
	}

	@RequestMapping("/cemment")
	public String showComment(ModelMap model, Integer id) {
		List<CementContent> cementContentAll = cementContentService.findAllCementContent();
		CementContent cementContent = cementContentService.findCementGetById(id);
		model.addAttribute("cementContent", cementContent);
		model.addAttribute("cementContentAll", cementContentAll);
		return "help/showcontent";
	}

	@RequestMapping("/{view}")
	public String getPage(@PathVariable String view) {
		return "help/" + view;
	}

}
