/**
 * @ClassName: LayerController.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月26日
 * 
 */
package com.zhigu.controllers.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Administrator
 * @description 测试弹出层
 */
@Controller
@RequestMapping("/layer")
public class LayerController {

	@RequestMapping("/{view}")
	public String layer(@PathVariable String view) {

		return "test/layer/" + view;
	}

}
