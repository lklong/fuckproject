package com.zhigu.controllers.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class JspController {

	private static final String FOLDER = "test/";

	@RequestMapping("/{dir}/{jsp}")
	public String index(@PathVariable String dir, @PathVariable String jsp) {
		return FOLDER + dir + "/" + jsp;
	}

	public static void main(String[] args) {
		System.out.println(1024 * 1024 * 0.8 / 1024 / 1024.00);
	}
}
