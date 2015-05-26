package com.zhigu.service.admin.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionAdmin;
import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.AdminStatus;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SessionKey;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.InputException;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.Md5;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.StringUtil.RandomType;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.mapper.AdminMapper;
import com.zhigu.mapper.AdminUserMapper;
import com.zhigu.model.Admin;
import com.zhigu.model.AdminResource;
import com.zhigu.model.PageBean;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.admin.IAdminService;

@Service
public class AdminService implements IAdminService {
	@Autowired
	private AdminMapper adminMapper;
	@Autowired
	private AdminUserMapper adminUserDao;

	@Override
	public MsgBean saveAdmin(Admin admin) {
		MsgBean checkResult = this.checkAdmin(admin);
		if (checkResult.getCode() != Code.SUCCESS) {
			return checkResult;
		}

		if (adminMapper.selectByName(admin.getName()) != null) {
			return new MsgBean(Code.FAIL, "该用户名已存在！", MsgLevel.ERROR);
		}
		// 密码、盐值
		if (!VerifyUtil.passwordVerify(admin.getPassword())) {
			return new MsgBean(Code.FAIL, "密码必须6位以上字母和数字组合！", MsgLevel.ERROR);
		}
		String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);
		admin.setPassword(Md5.convert(admin.getPassword(), salt));
		admin.setSalt(salt);
		admin.setStatus(AdminStatus.NORMAL);
		admin.setLoginCount(0);
		int row = adminMapper.insert(admin);
		if (row != 1) {
			throw new ServiceException("管理员创建失败！");
		}
		return new MsgBean(Code.SUCCESS, "管理员创建成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean updateAdmin(Admin admin) {
		Admin oldAdmin = adminMapper.selectByPrimaryKey(admin.getId());
		if (oldAdmin == null) {
			throw new ServiceException("未找到该管理员！");
		}

		if (!StringUtil.isEmpty(admin.getName())) {
			oldAdmin.setName(admin.getName());
		}
		if (!StringUtil.isEmpty(admin.getRealName())) {
			oldAdmin.setRealName(admin.getRealName());
		}
		if (admin.getRoleId() != null) {
			oldAdmin.setRoleId(admin.getRoleId());
		}
		if (!StringUtil.isEmpty(admin.getPassword())) {
			// 密码变更，生成盐值
			String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);
			oldAdmin.setPassword(Md5.convert(admin.getPassword(), salt));
			oldAdmin.setSalt(salt);
		}
		adminMapper.updateByPrimaryKeySelective(oldAdmin);
		return new MsgBean(Code.SUCCESS, "管理员修改成功", MsgLevel.NORMAL);
	}

	/**
	 * adminUser字段数据输入合法性检查
	 * 
	 * @param adminUser
	 * @return
	 * @throws InputException
	 */
	private MsgBean checkAdmin(Admin admin) {
		if (StringUtil.isEmpty(admin.getName())) {
			return new MsgBean(Code.FAIL, "用户名不能为空！", MsgLevel.ERROR);
		}
		if (StringUtil.isEmpty(admin.getRealName())) {
			return new MsgBean(Code.FAIL, "真实姓名不能为空！", MsgLevel.ERROR);
		}
		if (admin.getRoleId() == 0) {
			return new MsgBean(Code.FAIL, "请选择级别权限！", MsgLevel.ERROR);
		}
		return new MsgBean(Code.SUCCESS, "chek ok", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean login(String name, String password) {
		if (StringUtil.isEmpty(name)) {
			return new MsgBean(Code.FAIL, "请填写用户名！", MsgLevel.ERROR);
		}
		Admin admin = adminMapper.selectByName(name);
		if (admin != null && admin.getPassword().equals(Md5.convert(password, admin.getSalt()))) {
			if (admin.getStatus() != AdminStatus.NORMAL) {
				return new MsgBean(Code.FAIL, "该用户已被禁用，请联系超级管理员！", MsgLevel.ERROR);
			}
			admin.setLatestLoginTime(new Date());
			admin.setLoginCount(admin.getLoginCount() + 1);
			adminMapper.updateByPrimaryKeySelective(admin);

			// 可登陆系统标记
			List<AdminResource> adminResources = adminUserDao.queryAdminResourcesByRoleID(admin.getRoleId());
			List<String> loginSystem = new ArrayList<String>();
			for (AdminResource res : adminResources) {
				if (res.getIsMenu() == 3) {
					loginSystem.add(res.getResourceTreeBM());
				}
			}
			SessionAdmin sadmin = new SessionAdmin();
			sadmin.setId(admin.getId());
			sadmin.setLatestLoginTime(admin.getLatestLoginTime());
			sadmin.setLoginCount(admin.getLoginCount());
			sadmin.setName(admin.getName());
			sadmin.setRealName(admin.getRealName());
			sadmin.setRoleId(admin.getRoleId());
			sadmin.setStatus(admin.getStatus());
			sadmin.setLoginSystemMark(Collections.unmodifiableList(loginSystem));
			SessionHelper.getSession().setAttribute(SessionKey.SESSION_ADMIN, sadmin);
			return new MsgBean(Code.SUCCESS, "登陆成功！", MsgLevel.NORMAL);
		} else {
			return new MsgBean(Code.FAIL, "账号或密码填写错误！", MsgLevel.ERROR);
		}
	}

	@Override
	public Admin queryAdminByName(String name) {
		return adminMapper.selectByName(name);
	}

	@Override
	public PageBean<Admin> queryAdmin(PageBean<Admin> page) {
		List<Admin> adminList = adminMapper.selectByPage(page);
		page.setDatas(adminList);
		return page;
	}

	@Override
	public Admin queryAdmin(int id) {
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public MsgBean updateAdminStatus(int id, int status) {
		Admin admin = adminMapper.selectByPrimaryKey(id);
		admin.setStatus(status);
		adminMapper.updateByPrimaryKey(admin);
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public List<Admin> qeuryAdminAll() {
		return adminMapper.selectAll();
	}

	@Override
	public Admin queryAdminById(Integer id) {
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public MsgBean updateAdminPwdByID(HttpServletRequest request, String oldPwd, String newPwd) {
		SessionAdmin sessionAdmin = SessionHelper.getSessionAdmin();
		if (sessionAdmin != null) {
			Admin admin = adminMapper.selectByPrimaryKey(sessionAdmin.getId());
			if (!admin.getPassword().equals(Md5.convert(oldPwd, admin.getSalt()))) {
				return new MsgBean(Code.FAIL, "原密码输入不正确！", MsgLevel.WARNING);
			}
			// 生成盐值
			String salt = StringUtil.randomStr(RandomType.MIXTURE, 6);

			int row = adminMapper.updateAdminPwdByID(Md5.convert(newPwd, salt), admin.getId(), salt);

			if (row != 1) {
				return new MsgBean(Code.FAIL, "修改失败", MsgLevel.ERROR);
			}
			// 修改成功注销session
			request.getSession().invalidate();
		} else {
			return new MsgBean(Code.FAIL, "系统问题", MsgLevel.ERROR);
		}
		return new MsgBean(Code.SUCCESS, "修改成功，请重新登录！", MsgLevel.NORMAL);
	}

}
