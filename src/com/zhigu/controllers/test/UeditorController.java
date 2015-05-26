/**
 * @ClassName: UeditorController.java
 * @Author: liukailong
 * @Description: 
 * @Date: 2015年5月5日
 * 
 */
package com.zhigu.controllers.test;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author liukailong
 * @description ueditor 编辑器插件测试的控制器
 *
 */
@Controller
@RequestMapping("/ueditor")
public class UeditorController {

	private static final String FOLDER = "test/ueditor";

	/*
	 * @RequestMapping("/init") public void initUeditor(HttpServletRequest
	 * request, HttpServletResponse response) throws IOException {
	 * 
	 * request.setCharacterEncoding("utf-8");
	 * 
	 * response.setHeader("Content-Type", "text/html");
	 * 
	 * @SuppressWarnings("deprecation") String rootPath =
	 * request.getRealPath("/");
	 * 
	 * PrintWriter out = response.getWriter();
	 * 
	 * out.write(new ActionEnter(request, rootPath).exec());
	 * 
	 * }
	 */

	@RequestMapping("/index")
	public String Ueditor(HttpServletRequest request, HttpServletResponse response) throws IOException {

		return FOLDER + "/ueditor";

	}

}
