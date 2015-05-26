package com.zhigu.service.adminuser;

import java.util.List;

import com.zhigu.model.AdminResource;
import com.zhigu.model.AdminRole;

/**
 * 
 * 
 * 后台用户服务层接口
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
public interface IAdminUserService {

	/**
	 * 
	 * queryAdminResourcesByRoleID(根据角色ID查询资源)
	 * 
	 * @param roleID
	 * @return List<AdminResource>
	 * @exception
	 * @since 1.0.0
	 */
	public List<AdminResource> queryAdminResourcesByRoleID(int roleID);

	/**
	 * 
	 * queryAdminRoles(查询所有角色)
	 * 
	 * @return List<AdminRole>
	 * @exception
	 * @since 1.0.0
	 */
	public List<AdminRole> queryAdminRoles();

	/**
	 * 查询用户menu
	 * 
	 * @param userID
	 * @return
	 */
	public List<AdminResource> queryAdminMenuByUserID(int userID);

	/**
	 * queryAdminResourceByResourceUrl
	 * 
	 * @param
	 * @return
	 */
	public AdminResource queryAdminResourceByResourceUrl(String resourceUrl);

	/**
	 * 检查权限
	 * 
	 * @param userID
	 * @param resourceURL
	 * @return
	 */
	public AdminResource checkPermission(int userID, String resourceURL);

	/**
	 * 添加角色
	 * 
	 * @param adminRole
	 *            角色
	 * @param resourceIDs
	 *            角色拥有的资源ID
	 */
	public void addRole(AdminRole adminRole, int[] resourceIDs);

	/**
	 * 更新角色
	 * 
	 * @param adminRole
	 * @return
	 */
	public int updateAdminRole(AdminRole adminRole);

	/**
	 * 更新角色/角色资源（删除原来的重新添加）
	 * 
	 * @param adminRole
	 * @param newResourceIDs
	 */
	public void updateRoleResource(AdminRole adminRole, int[] newResourceIDs);

	public List<AdminResource> queryAdminResourceAll();

}
