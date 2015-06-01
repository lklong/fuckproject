package com.zhigu.service.user;

import java.util.List;

import com.zhigu.model.Address;
import com.zhigu.model.dto.MsgBean;

/**
 * 收货地址信息
 * 
 * @author liyouzan 2014年7月28日14:50:56
 */

public interface IAddressService {
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
	public Address queryAddressByID(int userID, int addressID);

	/**
	 * 默认地址
	 * 
	 * @param userID
	 * @return
	 */
	public Address queryDefaultAddress(int userID);

	/**
	 * 保存收货地址信息
	 * 
	 * @param spad
	 */
	public MsgBean saveAddress(Address address);

	/**
	 * 修改收货地址信息
	 * 
	 * @param spad
	 */
	public MsgBean updateAddress(Address address);

	/**
	 * 修改默认地址
	 * 
	 */
	public MsgBean updateDefaultAddress(int userID, int addressID);

	/**
	 * 删除收货地址信息
	 * 
	 * @param spad
	 */
	public MsgBean deleteAddress(int userID, int addressID);

}
