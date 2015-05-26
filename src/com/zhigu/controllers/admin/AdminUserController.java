package com.zhigu.controllers.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Admin;
import com.zhigu.model.AdminResource;
import com.zhigu.model.AdminRole;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.admin.IAdminService;
import com.zhigu.service.adminuser.IAdminUserService;

/**
 * 
 * 
 * AuthController
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
@Controller
@RequestMapping("/admin/adminuser")
public class AdminUserController {
	@Autowired
	private IAdminUserService adminUserService;
	@Autowired
	private IAdminService adminService;

	/**
	 *
	 * index(跳转到后台管理员用户界面) (适用于后台登陆)
	 *
	 * @exception
	 * @since 1.0.0
	 */
	@RequestMapping("/index")
	public ModelAndView index(ModelAndView mv, PageBean<Admin> page) {
		// mv.addObject("roles", adminUserService.queryAdminRoles());
		// 获取结果集
		page = adminService.queryAdmin(page);
		mv.setViewName("admin/adminuser/index");
		mv.addObject("page", page);
		return mv;
	}

	/**
	 * create(新增管理员)
	 *
	 * @param adminUser
	 * @param mv
	 * @return ModelAndView
	 * @exception
	 * @since 1.0.0
	 */
	@RequestMapping(value = "/addAndUpate", method = RequestMethod.GET)
	public ModelAndView createUI(Integer id, ModelAndView mv) {
		List roleAll = adminUserService.queryAdminRoles();
		Admin admin = adminService.queryAdminById(id);
		mv.addObject("admin", admin);
		mv.addObject("roles", roleAll);
		mv.setViewName("/admin/adminuser/addAndUpate");
		return mv;
	}

	@RequestMapping(value = "/addAndUpate", method = RequestMethod.POST)
	@ResponseBody
	public MsgBean create(Admin admin) {
		if (admin.getId() != null && admin.getId() > 0) {
			if (admin.getId() == 1 && SessionHelper.getSessionAdmin().getId() != 1) {
				return new MsgBean(Code.FAIL, "该账号只有超级管理员自己才能修改", MsgLevel.ERROR);
			}
			return adminService.updateAdmin(admin);
		} else {
			return adminService.saveAdmin(admin);
		}
	}

	/**
	 * changeStatus(修改管理员状态)
	 *
	 * @param adminUser
	 * @param mv
	 * @return JSONObject
	 * @exception
	 * @since 1.0.0
	 */
	@RequestMapping("/changeStatus")
	@ResponseBody
	public MsgBean changeStatus(int id, int status, ModelAndView mv) {
		if (id == 1) {
			return new MsgBean(Code.FAIL, "不能修改该账号状态", MsgLevel.ERROR);
		}
		return adminService.updateAdminStatus(id, status);
	}

	/**
	 * 角色列表
	 *
	 * @param mv
	 * @return
	 */
	@RequestMapping("/rolelist")
	public ModelAndView rolelist(ModelAndView mv) {
		List<AdminRole> adminRoles = adminUserService.queryAdminRoles();
		for (AdminRole role : adminRoles) {
			List<AdminResource> list = adminUserService.queryAdminResourcesByRoleID(role.getRoleID());
			role.setAdminResource(list);
		}
		mv.addObject("adminRoles", adminRoles);
		mv.setViewName("admin/adminuser/role");
		return mv;
	}

	/**
	 * 角色可分配资源
	 *
	 * @return
	 */
	@RequestMapping("/resourceall")
	@ResponseBody
	public List adminResourceAll() {
		List<AdminResource> list = adminUserService.queryAdminResourceAll();
		return list;
	}

	/**
	 * 添加/更新角色
	 *
	 * @param roleName
	 * @param resourceIDs
	 * @return
	 */
	@RequestMapping("/saveRole")
	@ResponseBody
	public MsgBean saveRole(AdminRole adminRole, int[] resourceIDs) {
		if (adminRole.getRoleID() > 0) {
			if (adminRole.getRoleID() != 1) {
				adminUserService.updateRoleResource(adminRole, resourceIDs);
			} else {
				return new MsgBean(Code.FAIL, "不能修改超级管理员！", MsgLevel.ERROR);
			}
		} else {
			adminUserService.addRole(adminRole, resourceIDs);
		}
		return new MsgBean(Code.SUCCESS, "角色保存成功", MsgLevel.NORMAL);
	}

}
