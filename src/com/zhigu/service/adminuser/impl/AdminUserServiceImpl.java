package com.zhigu.service.adminuser.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.AdminMemberMapper;
import com.zhigu.mapper.AdminUserMapper;
import com.zhigu.model.AdminResource;
import com.zhigu.model.AdminRole;
import com.zhigu.service.adminuser.IAdminUserService;

/**
 * 
 * 
 * 后台用户服务层接口实现
 * 
 * Michael
 * 
 * 2014年07月16日
 * 
 * @version 1.0.0
 *
 */
@Service
public class AdminUserServiceImpl implements IAdminUserService {
	@Autowired
	private AdminUserMapper adminUserDao;

	@Autowired
	private AdminMemberMapper memberDao;

	@Override
	public List<AdminResource> queryAdminResourcesByRoleID(int roleID) {
		return adminUserDao.queryAdminResourcesByRoleID(roleID);
	}

	@Override
	public List<AdminRole> queryAdminRoles() {
		return adminUserDao.queryAdminRoles();
	}

	@Override
	public List<AdminResource> queryAdminMenuByUserID(int userID) {
		return adminUserDao.queryAdminMenuByUserID(userID);
	}

	@Override
	public AdminResource queryAdminResourceByResourceUrl(String resourceUrl) {
		return adminUserDao.queryAdminResourceByResourceUrl(resourceUrl);
	}

	@Override
	public AdminResource checkPermission(int userID, String resourceURL) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userID", userID);
		map.put("resourceUrl", resourceURL);
		return adminUserDao.checkPermission(map);
	}

	@Override
	public void addRole(AdminRole adminRole, int[] resourceIDs) {
		int code = adminUserDao.addAdminRole(adminRole);
		if (code == 1) {
			if (resourceIDs != null && resourceIDs.length > 0) {
				for (int id : resourceIDs) {
					adminUserDao.addAdminRoleToResource(adminRole.getRoleID(), id);
				}
			}
		}
	}

	@Override
	public void updateRoleResource(AdminRole adminRole, int[] newResourceIDs) {
		adminUserDao.updateAdminRole(adminRole);
		adminUserDao.deleteAdminRoleToResource(adminRole.getRoleID(), -1);
		if (newResourceIDs != null) {
			for (int resourceIDnew : newResourceIDs) {
				adminUserDao.addAdminRoleToResource(adminRole.getRoleID(), resourceIDnew);
			}
		}
	}

	@Override
	public List<AdminResource> queryAdminResourceAll() {
		return adminUserDao.queryAdminResourceAll();
	}

	@Override
	public int updateAdminRole(AdminRole adminRole) {
		return adminUserDao.updateAdminRole(adminRole);
	}

}
