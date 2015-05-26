package com.zhigu.service.admin;

import java.util.List;

import com.zhigu.model.MemberCondition;
import com.zhigu.model.MemberInfo;
import com.zhigu.model.PageBean;
import com.zhigu.model.UserInfo;

/**
 * 会员信息
 * 
 * @author zhouqibing 2014年8月28日下午3:52:13
 */
public interface IMemberService {
	/**
	 * 供应商会员信息
	 * 
	 * @param page
	 * @param mc
	 */
	public List<MemberInfo> querySupplieMemberList(PageBean<MemberInfo> page, MemberCondition mc);

	/**
	 * 保存分配会员信息
	 * 
	 * @param staffID
	 * @param mems
	 */
	public void saveAllotMember(Integer staffID, List<Integer> mems);

	/**
	 * 修改会员状态
	 * 
	 * @param mems
	 */
	public void updateMemStatus(Integer status, List<Integer> mems);

	/**
	 * 修改会员是否公司员工
	 * 
	 * @param userID
	 * @param isInnerEmployee
	 * @return
	 */
	public int updateIsInnerEmployee(int userID, int isInnerEmployee);

	/**
	 * 查询普通会员
	 * 
	 * @param page
	 * @param mc
	 * @return
	 */
	public List<MemberInfo> queryCommonMemberList(PageBean<MemberInfo> page, MemberCondition mc);

	/**
	 * 禁用会员
	 * 
	 * @param page
	 * @param mc
	 * @return
	 */
	public List<MemberInfo> queryUnableMemberList(PageBean<MemberInfo> page, MemberCondition mc);

	/**
	 * 公司员工会员
	 * 
	 * @param page
	 * @param mc
	 * @return
	 */
	public List<MemberInfo> queryInnerEmployeeMember(PageBean<MemberInfo> page, MemberCondition mc);

	/**
	 * 查询会员，通过推荐人
	 * 
	 * @param recommendUserID
	 * @return
	 */
	public List<UserInfo> queryMemberByRecommendUser(int recommendUserID);
}
