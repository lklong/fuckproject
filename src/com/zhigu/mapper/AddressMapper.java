package com.zhigu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhigu.model.Address;

public interface AddressMapper {
	/**
	 * 根据userID查询收货地址信息
	 * 
	 * @param userID
	 */
	public List<Address> queryAddressByUserID(int userID);

	/**
	 * 根据ID查询收货地址信息
	 * 
	 * @param ID
	 */
	public Address queryAddressByID(@Param("userID") int userID, @Param("id") int addressID);

	/**
	 * 保存收货地址信息
	 * 
	 * @param spad
	 */
	public int saveAddress(Address address);

	/**
	 * 修改收货地址信息
	 * 
	 * @param spad
	 */
	public void updateAddress(Address address);

	/**
	 * 修改默认地址
	 * 
	 * @param spad
	 */
	public void updateDefaultAddress(@Param("userID") int userID, @Param("id") int addressID);

	/**
	 * 删除收货地址信息
	 * 
	 * @param spad
	 */
	public void deleteAddress(@Param("userID") int userID, @Param("id") int addressID);

	/**
	 * 默认收货地址
	 * 
	 * @param userID
	 * @return
	 */
	public Address queryDefaultAddress(int userID);

}
