package com.zhigu.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.AdminResource;
import com.zhigu.model.AdminRole;

/**
 * 
 * 
 * 后台用户数据层接口
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
public interface AdminUserMapper {

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
	 * @param map
	 * @return
	 */
	public AdminResource queryAdminResourceByResourceUrl(String resourceUrl);

	/**
	 * 检查权限
	 * 
	 * @param map
	 * @return
	 */
	public AdminResource checkPermission(Map<String, Object> map);

	/**
	 * 添加角色
	 * 
	 * @param adminRole
	 * @return
	 */
	public int addAdminRole(AdminRole adminRole);

	/**
	 * 更新角色
	 * 
	 * @param adminRole
	 * @return
	 */
	public int updateAdminRole(AdminRole adminRole);

	/**
	 * 添加角色资源关系
	 * 
	 * @param roleID
	 * @param resourceID
	 * @return
	 */
	public int addAdminRoleToResource(@Param("roleID") int roleID, @Param("resourceID") int resourceID);

	/**
	 * 删除角色资源
	 * 
	 * @param roleID
	 * @param resourceID
	 * @return
	 */
	public int deleteAdminRoleToResource(@Param("roleID") int roleID, @Param("resourceID") int resourceID);

	/**
	 * 角色可分配的资源
	 * 
	 * @return
	 */
	public List<AdminResource> queryAdminResourceAll();

}
