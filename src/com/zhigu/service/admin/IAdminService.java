package com.zhigu.service.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.zhigu.common.exception.InputException;
import com.zhigu.model.Admin;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;

public interface IAdminService {
	/**
	 * 后台登陆
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public MsgBean login(String name, String password);

	public Admin queryAdminById(Integer id);

	/**
	 * 
	 * queryAdminByUsername(根据用户名查询用户信息)
	 * 
	 * @param username
	 * @return Admin
	 * @exception
	 * @since 1.0.0
	 */
	public Admin queryAdminByName(String name);

	/**
	 * 
	 * queryAdmin(查询管理员用户)
	 * 
	 * @param page
	 * @return List<Admin>
	 * @exception
	 * @since 1.0.0
	 */
	public PageBean<Admin> queryAdmin(PageBean<Admin> page);

	/**
	 * 
	 * 新增用户
	 * 
	 * @param admin
	 * @throws InputException
	 * @exception
	 * @since 1.0.0
	 */
	public MsgBean saveAdmin(Admin admin);

	/**
	 * 
	 * 查询用户详情
	 * 
	 * @param userID
	 * @return Admin
	 * @exception
	 * @since 1.0.0
	 */
	public Admin queryAdmin(int id);

	/**
	 * 更新用户
	 * 
	 * @param admin
	 * @throws InputException
	 */
	public MsgBean updateAdmin(Admin admin);

	/**
	 * 更新管理员状态
	 * 
	 * @param id
	 * @param status
	 */
	public MsgBean updateAdminStatus(int id, int status);

	/**
	 * 所有管理员
	 * 
	 * @return
	 */
	public List<Admin> qeuryAdminAll();

	/**
	 * 修改管理员密码
	 * 
	 * @param pwd
	 * @param id
	 * @return
	 */
	public MsgBean updateAdminPwdByID(HttpServletRequest request, String oldPwd, String newPwd);

}
