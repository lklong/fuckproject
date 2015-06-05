package com.zhigu.controllers.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.utils.ServiceMsg;
import com.zhigu.model.Cement;
import com.zhigu.model.CementContent;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.system.CementContentService;

/**
 * 系统公告管理
 * 
 * @author YangKun
 * 
 *
 */
@Controller
@RequestMapping("/admin/system")
public class SystemController {
	@Autowired
	private CementContentService cementContentService;

	/**
	 * 查询所有资讯信息列表
	 * 
	 * @param mv
	 * @param page
	 * @return
	 */
	@RequestMapping("/CementContentsList")
	public ModelAndView CementContentsList(ModelAndView mv, PageBean<CementContent> page) {
		List<CementContent> comentList = cementContentService.queryCementContentsList(page);
		mv.addObject("page", page);
		mv.addObject("comentList", comentList);
		mv.setViewName("admin/system/cementlist");
		return mv;
	}

	/**
	 * 跳转添加界面
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "/coment/addAndUpdate", method = RequestMethod.GET)
	public ModelAndView addComentUI(ModelAndView mv, Integer id) {
		if (id != null) {
			CementContent cementContent = cementContentService.findCementGetById(id);
			mv.addObject("cementContent", cementContent);
		}
		List<Cement> cements = cementContentService.queryCements();
		mv.addObject("cements", cements);
		mv.setViewName("admin/system/updatecement");

		return mv;
	}

	/**
	 * 添加信息
	 * 
	 * @param cementContent
	 * @return
	 */
	@RequestMapping(value = "/coment/addAndUpdate", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean addComent(CementContent cementContent) {
		if (cementContent.getId() != null && cementContent.getId() > 0) {
			return cementContentService.updateCementContent(cementContent);
		} else {
			return cementContentService.saveCementContent(cementContent);
		}
	}

	/**
	 * 删除信息
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("/deleteComent")
	@ResponseBody
	public MsgBean deleteComent(int id) {
		cementContentService.deleteCementContentById(id);
		return ServiceMsg.getMsgBean();
	}

}
