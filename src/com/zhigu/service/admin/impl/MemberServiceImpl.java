package com.zhigu.service.admin.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.mapper.AdminMemberMapper;
import com.zhigu.model.MemberCondition;
import com.zhigu.model.MemberInfo;
import com.zhigu.model.PageBean;
import com.zhigu.model.StaffMember;
import com.zhigu.model.UserInfo;
import com.zhigu.service.admin.IMemberService;

/**
 * 会员
 * 
 * @author zhouqibing 2014年8月28日下午4:02:52
 */
@Service
public class MemberServiceImpl implements IMemberService {
	@Autowired
	private AdminMemberMapper memberDao;

	@Override
	public List<MemberInfo> querySupplieMemberList(PageBean<MemberInfo> page, MemberCondition mc) {
		return memberDao.querySupplieMemberByPage(page, mc);
	}

	@Override
	public void saveAllotMember(Integer staffID, List<Integer> mems) {
		StaffMember sm;
		memberDao.updateAllotMember(mems);
		for (Integer id : mems) {
			sm = new StaffMember();
			sm.setUserID(id);
			sm.setStaffID(staffID);
			memberDao.saveAllotMember(sm);
		}

	}

	@Override
	public void updateMemStatus(Integer status, List<Integer> mems) {
		memberDao.updateMemStatus(status, mems);
	}

	@Override
	public int updateIsInnerEmployee(int userID, int isInnerEmployee) {
		return memberDao.updateIsInnerEmployee(userID, isInnerEmployee);
	}

	@Override
	public List<MemberInfo> queryCommonMemberList(PageBean<MemberInfo> page, MemberCondition mc) {
		return memberDao.queryCommonMemberListByPage(page, mc);
	}

	@Override
	public List<MemberInfo> queryUnableMemberList(PageBean<MemberInfo> page, MemberCondition mc) {
		return memberDao.queryUnableMemberListByPage(page, mc);
	}

	@Override
	public List<MemberInfo> queryInnerEmployeeMember(PageBean<MemberInfo> page, MemberCondition mc) {
		return memberDao.queryInnerEmployeeMemberByPage(page, mc);
	}

	@Override
	public List<UserInfo> queryMemberByRecommendUser(int recommendUserID) {
		return memberDao.queryMemberByRecommendUser(recommendUserID);
	}
}
