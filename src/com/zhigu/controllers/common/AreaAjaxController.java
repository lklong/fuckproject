/**
 * @ClassName: AreaAjaxController.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年6月9日
 * 
 */
package com.zhigu.controllers.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.model.Area;
import com.zhigu.service.common.AreaService;

/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/ajax/area")
public class AreaAjaxController {

	@Autowired
	private AreaService areaService;

	@RequestMapping("/{parentId}")
	@ResponseBody
	public List<Area> getAreaByParentId(@PathVariable String parentId) {
		return areaService.selectByParentId(parentId);
	}

}
