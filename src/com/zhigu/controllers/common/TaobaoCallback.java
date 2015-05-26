package com.zhigu.controllers.common;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.taobao.api.TaobaoAPI;
import com.zhigu.model.UserTaobao;
import com.zhigu.service.user.IUserService;

/**
 * 淘宝回调
 * 
 * @author HeSiMin
 * @date 2014年8月21日
 *
 */
@Controller
public class TaobaoCallback {
	@Autowired
	private IUserService userService;

	/**
	 * 用户授权后淘宝回调
	 * 
	 * @return
	 */
	@RequestMapping("/taobaoCallback")
	public String taobaoCallback(HttpServletRequest request) {
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		// 获取并保存用户淘宝授权信息
		Map<String, String> map = TaobaoAPI.accessToken(code);
		if (map != null && !map.isEmpty()) {
			UserTaobao userTaobao = new UserTaobao();
			String userid = TaobaoAPI.splitTaobaoState(state).get("userid");
			userTaobao.setUserID(Integer.parseInt(userid));
			userTaobao.setAccess_token(map.get("access_token"));
			String expires_in = map.get("expires_in");
			userTaobao.setExpires_in(Integer.parseInt(expires_in));
			userTaobao.setRefresh_token(map.get("refresh_token"));
			userTaobao.setTaobao_user_nick(map.get("taobao_user_nick"));
			userTaobao.setTaobao_user_id(map.get("taobao_user_id"));
			userService.addUserTaobao(userTaobao);
		} else {
			// TODO 淘宝回调，授权失败
		}
		return "redirect:/index";
	}
}
