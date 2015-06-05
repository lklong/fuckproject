package com.zhigu.controllers.open;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.common.IEmailService;

@Controller
@RequestMapping("/email")
public class EmailController {
	@Autowired
	private IEmailService emailService;

	@RequestMapping("/verifyBindEmail")
	public ModelAndView verifyBindEmail(String uid, ModelAndView mv) {
		MsgBean msg = emailService.verifyBindEmail(uid);
		mv.addObject("msg", msg.getMsg());
		mv.setViewName("/tips/tips");
		return mv;
	}
}
