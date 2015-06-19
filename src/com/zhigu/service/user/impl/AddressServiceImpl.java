package com.zhigu.service.user.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.SystemConstants;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.exception.ServiceException;
import com.zhigu.common.utils.StringUtil;
import com.zhigu.common.utils.VerifyUtil;
import com.zhigu.mapper.AddressMapper;
import com.zhigu.model.Address;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAddressService;

@Service
public class AddressServiceImpl implements IAddressService {
	@Autowired
	private AddressMapper addressMapper;

	@Override
	public List<Address> queryAddressByUserID(int userId) {
		return addressMapper.selectByUserId(userId);
	}

	@Override
	public Address queryAddressByID(int userId, int addressId) {
		Address addr = addressMapper.selectByPrimaryKey(addressId);
		if (addr != null && addr.getUserId() != userId) {
			addr = null;
		}
		return addr;
	}

	@Override
	public MsgBean saveAddress(Address address) {
		int userId = SessionHelper.getSessionUser().getUserId();
		// 现有地址数
		List<Address> list = addressMapper.selectByUserId(userId);
		if (list != null && list.size() >= 10) {
			return new MsgBean(Code.FAIL, "已添加10条地址，不能再新增！", MsgLevel.ERROR);
		}
		// 数据验证
		String msg = verify(address);
		if (!StringUtil.isEmpty(msg)) {
			return new MsgBean(Code.FAIL, msg, MsgLevel.ERROR);
		}

		// 设置用户
		address.setUserId(userId);
		// 保存
		address.setId(null);
		address.setAddTime(new Date());

		// 判断该地址是否是默认地址，如果是的话
		// 就查询该用户有没有默认地址，
		// 如果有的话就修改以前的默认地址为false
		if (address.getDefaultFlag()) {
			Address defAddress = addressMapper.selectDefaultAddress(userId);
			if (defAddress != null) {
				defAddress.setDefaultFlag(false);
				addressMapper.updateByPrimaryKeySelective(defAddress);
			}
		}

		int row = addressMapper.insert(address);
		if (row != 1) {
			throw new ServiceException(SystemConstants.DB_UPDATE_FAILED_MSG);
		}

		return new MsgBean(Code.SUCCESS, "地址添加成功", MsgLevel.NORMAL);
	}

	// 验证信息
	private String verify(Address address) {
		// 验证姓名
		if (StringUtil.isEmpty(address.getName())) {
			return "姓名不能为空！";
		}
		if (address.getName().length() > 32) {
			return "姓名不能超过32个字！";
		}
		// 验证城区
		if (StringUtil.isEmpty(address.getProvince(), address.getCity(), address.getDistrict(), address.getStreet()) || address.getStreet().length() > 126) {
			return "请填写完整的收货地址！";
		}
		// // 验证邮编
		// if (!StringUtil.isEmpty(address.getPostcode()) &&
		// !VerifyUtil.isNumber(address.getPostcode())) {
		// return "请输入正确的邮政编码！";
		// }
		// 验证号码
		if (!VerifyUtil.phoneVerify(address.getPhone())) {
			return "请填写正确的手机号码！";
		}
		return null;
	}

	@Override
	public MsgBean updateAddress(Address address) {
		int userId = SessionHelper.getSessionUser().getUserId();
		Address oldAddress = this.queryAddressByID(userId, address.getId());
		if (oldAddress == null) {
			return new MsgBean(Code.FAIL, "没找到该地址，不能修改！", MsgLevel.ERROR);
		}
		oldAddress.setUserId(userId);
		oldAddress.setCity(address.getCity());
		oldAddress.setDefaultFlag(address.getDefaultFlag());
		oldAddress.setDistrict(address.getDistrict());
		oldAddress.setName(address.getName());
		oldAddress.setPhone(address.getPhone());
		oldAddress.setPostcode(address.getPostcode());
		oldAddress.setProvince(address.getProvince());
		oldAddress.setStreet(address.getStreet());
		oldAddress.setDefaultFlag(address.getDefaultFlag());
		// 验证信息
		String msg = verify(oldAddress);
		if (!StringUtil.isEmpty(msg)) {
			return new MsgBean(Code.FAIL, msg, MsgLevel.ERROR);
		}
		// 原有默认地址
		if (address.getDefaultFlag()) {
			Address defAddress = addressMapper.selectDefaultAddress(userId);
			if (defAddress != null && defAddress.getId().intValue() != address.getId()) {
				defAddress.setDefaultFlag(false);
				addressMapper.updateByPrimaryKeySelective(defAddress);
			}
		}
		addressMapper.updateByPrimaryKey(oldAddress);
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean updateDefaultAddress(int userId, int addressId) {
		Address addr = addressMapper.selectByPrimaryKey(addressId);
		if (addr == null || addr.getUserId() != userId) {
			return new MsgBean(Code.FAIL, "无效地址", MsgLevel.ERROR);
		}
		// 取消原有默认收货地址
		Address defAddress = addressMapper.selectDefaultAddress(userId);
		if (defAddress != null && defAddress.getId().intValue() != addr.getId()) {
			defAddress.setDefaultFlag(false);
			addressMapper.updateByPrimaryKeySelective(defAddress);
		}
		// 设置新默认收货地址
		addr.setDefaultFlag(true);
		addressMapper.updateByPrimaryKey(addr);
		return new MsgBean(Code.SUCCESS, "默认地址设置成功", MsgLevel.NORMAL);
	}

	@Override
	public MsgBean deleteAddress(int userId, int addressId) {
		Address addr = addressMapper.selectAddressByUserIdAndId(userId, addressId);
		if (addr == null) {
			return new MsgBean(Code.FAIL, "无效地址", MsgLevel.ERROR);
		}
		addressMapper.deleteByPrimaryKey(addressId);
		return new MsgBean(Code.SUCCESS, "删除成功", MsgLevel.NORMAL);
	}

	@Override
	public Address queryDefaultAddress(int userId) {
		return addressMapper.selectDefaultAddress(userId);
	}

}
