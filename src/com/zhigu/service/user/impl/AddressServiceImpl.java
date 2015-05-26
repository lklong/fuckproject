package com.zhigu.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
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
	public List<Address> queryAddressByUserID(int userID) {
		return addressMapper.queryAddressByUserID(userID);
	}

	@Override
	public Address queryAddressByID(int userID, int addressID) {
		return addressMapper.queryAddressByID(userID, addressID);
	}

	@Override
	public MsgBean saveAddress(Address address) {
		int userID = SessionHelper.getSessionUser().getUserID();
		// 现有地址数
		List<Address> list = addressMapper.queryAddressByUserID(userID);
		if (list != null && list.size() >= 10) {
			return new MsgBean(Code.FAIL, "已添加10条地址，不能再新增！", MsgLevel.ERROR);
		}
		// 数据验证
		String msg = verify(address);
		if (!StringUtil.isEmpty(msg)) {
			return new MsgBean(Code.FAIL, msg, MsgLevel.ERROR);
		}

		// 设置用户
		address.setUserID(userID);
		// 保存
		addressMapper.saveAddress(address);
		// 是否设置默认
		if (address.getIsDefault() == 1) {
			addressMapper.updateDefaultAddress(address.getUserID(), address.getID());
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
		String msg = verify(address);
		// 验证信息
		if (!StringUtil.isEmpty(msg)) {
			return new MsgBean(Code.FAIL, msg, MsgLevel.ERROR);
		}
		int userID = SessionHelper.getSessionUser().getUserID();
		Address old = addressMapper.queryAddressByID(userID, address.getID());
		if (old == null) {
			return new MsgBean(Code.FAIL, "没找到该地址，不能修改！", MsgLevel.ERROR);
		}
		address.setUserID(userID);
		addressMapper.updateAddress(address);
		// 是否设置默认
		if (address.getIsDefault() == 1) {
			addressMapper.updateDefaultAddress(address.getUserID(), address.getID());
		}
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	@Override
	public void updateDefaultAddress(int userID, int addressID) {
		addressMapper.updateDefaultAddress(userID, addressID);
	}

	@Override
	public void deleteAddress(int userID, int addressID) {
		addressMapper.deleteAddress(userID, addressID);
	}

	@Override
	public Address queryDefaultAddress(int userID) {
		return addressMapper.queryDefaultAddress(userID);
	}

}
