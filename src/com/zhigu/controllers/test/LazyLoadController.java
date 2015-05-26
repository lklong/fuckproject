/**
 * @ClassName: LazyLoadController.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月18日
 * 
 */
package com.zhigu.controllers.test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Administrator 测试图片延迟加载
 */
@Controller
@RequestMapping("/lazy")
public class LazyLoadController {

	@RequestMapping("/load/img")
	public String lasyLoadImg(ModelMap model) {

		List<String> images = new ArrayList<String>();
		images.add("http://127.0.0.1/img/upload/201505/1594504b4c52492e8fda08cb88769fc7.JPG");
		images.add("http://127.0.0.1/img/upload/201505/18043be70273426884779053b5c8d4d8.JPG");
		images.add("http://127.0.0.1/img/upload/201505/4f756c150bf347c7be9dc8d26676173e.JPG");
		images.add("http://127.0.0.1/img/upload/201505/1.JPG");
		images.add("http://127.0.0.1/img/upload/201505/2.JPG");
		images.add("http://127.0.0.1/img/upload/201505/3.JPG");

		model.addAttribute("iamges", images);

		return "/test/lazyload/image";
	}
}
