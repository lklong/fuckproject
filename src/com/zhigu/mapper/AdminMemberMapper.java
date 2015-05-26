package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.MemberCondition;
import com.zhigu.model.MemberInfo;
import com.zhigu.model.PageBean;
import com.zhigu.model.StaffMember;
import com.zhigu.model.UserInfo;

public interface AdminMemberMapper {
	/**
	 * 供应商会员信息
	 * 
	 * @param page
	 * @param mc
	 */
	public List<MemberInfo> querySupplieMemberByPage(@Param("page") PageBean<MemberInfo> page, @Param("mc") MemberCondition mc);

	/**
	 * 保存分配会员信息
	 * 
	 * @param sm
	 */
	public void saveAllotMember(StaffMember sm);

	/**
	 * 修改分配会员状态 --->将记录变为无效
	 * 
	 * @param mems
	 */
	public void updateAllotMember(List<Integer> mems);

	/**
	 * 修改会员状态
	 * 
	 * @param mems
	 */
	public void updateMemStatus(@Param("status") Integer status, @Param("mems") List<Integer> mems);

	/**
	 * 修改会员是否公司员工
	 * 
	 * @param userID
	 * @param isInnerEmployee
	 * @return
	 */
	public int updateIsInnerEmployee(@Param("userID") int userID, @Param("isInnerEmployee") int isInnerEmployee);

	/**
	 * 查询普通会员
	 * 
	 * @param page
	 * @param mc
	 * @return
	 */
	public List<MemberInfo> queryCommonMemberListByPage(@Param("page") PageBean<MemberInfo> page, @Param("mc") MemberCondition mc);

	/**
	 * 禁用会员
	 * 
	 * @param page
	 * @param mc
	 * @return
	 */
	public List<MemberInfo> queryUnableMemberListByPage(@Param("page") PageBean<MemberInfo> page, @Param("mc") MemberCondition mc);

	/**
	 * 公司员工会员
	 * 
	 * @param page
	 * @param mc
	 * @return
	 */
	public List<MemberInfo> queryInnerEmployeeMemberByPage(@Param("page") PageBean<MemberInfo> page, @Param("mc") MemberCondition mc);

	/**
	 * 删除会员分配关系
	 * 
	 * @param staffID
	 * @return
	 */
	public int deleteStaffMemberByStaffID(int staffID);

	/**
	 * 查询会员，通过推荐人
	 * 
	 * @param recommendUserID
	 * @return
	 */
	public List<UserInfo> queryMemberByRecommendUser(int recommendUserID);
}
