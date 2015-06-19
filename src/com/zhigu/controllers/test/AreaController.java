package com.zhigu.controllers.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.constant.Code;
import com.zhigu.model.Area;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.AreaService;

@Controller
@RequestMapping("/area")
public class AreaController {

	@Autowired
	private AreaService areaService;

	/**
	 * 区域选择
	 * 
	 * @param parentId
	 * @param msgBean
	 * @return
	 */
	@RequestMapping("/{parentId}")
	@ResponseBody
	public MsgBean changeArea(@PathVariable String parentId, MsgBean msgBean) {
		msgBean.setCode(Code.SUCCESS);
		msgBean.setData(areaService.selectByParentId(parentId));
		return msgBean;
	}

	/**
	 * 区域回显控制
	 * 
	 * @param provinceId
	 * @param cityId
	 * @param districtId
	 * @param msgBean
	 * @return
	 */
	@RequestMapping("/default")
	@ResponseBody
	public MsgBean getDefaultArea(String provinceId, String cityId, String districtId, MsgBean msgBean) {
		msgBean.setCode(Code.SUCCESS);
		List<Area> provinces = areaService.selectByParentId("0");
		List<Area> cities = areaService.selectByParentId(provinceId);
		List<Area> districts = areaService.selectByParentId(cityId);
		Map<String, List<Area>> areaMap = new HashMap<String, List<Area>>();
		areaMap.put(provinceId, provinces);
		areaMap.put(cityId, cities);
		areaMap.put(districtId, districts);
		msgBean.setData(areaMap);
		return msgBean;
	}

}
