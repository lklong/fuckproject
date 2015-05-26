package com.zhigu.model;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * 
 * 后台角色实体类
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
public class AdminRole implements Serializable {
	/**
	 * 角色ID
	 */
	private int roleID;
	/**
	 * 角色名
	 */
	private String roleName;
	/**
	 * 角色资源
	 */
	private List<AdminResource> adminResource;

	public int getRoleID() {
		return roleID;
	}

	public void setRoleID(int roleID) {
		this.roleID = roleID;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<AdminResource> getAdminResource() {
		return adminResource;
	}

	public void setAdminResource(List<AdminResource> adminResource) {
		this.adminResource = adminResource;
	}

}