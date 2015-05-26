package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Admin;
import com.zhigu.model.PageBean;

public interface AdminMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Admin record);

	int insertSelective(Admin record);

	Admin selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Admin record);

	int updateByPrimaryKey(Admin record);

	Admin selectByName(String name);

	List<Admin> selectAll();

	List<Admin> selectByPage(PageBean page);

	/**
	 * 修改管理员密码
	 * 
	 * @param pwd
	 * @param id
	 * @return
	 */
	int updateAdminPwdByID(@Param("pwd") String pwd, @Param("id") Integer id, @Param("salt") String salt);

}