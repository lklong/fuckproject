package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Address;

public interface AddressMapper {
	int deleteByPrimaryKey(Integer id);

	int insert(Address record);

	int insertSelective(Address record);

	Address selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Address record);

	int updateByPrimaryKey(Address record);

	List<Address> selectByUserId(Integer userId);

	/**
	 * 默认收货地址
	 * 
	 * @param userID
	 * @return
	 */
	public Address selectDefaultAddress(int userId);

	public Address selectAddressByUserIdAndId(@Param("userId") int userId, @Param("id") int addressId);
}