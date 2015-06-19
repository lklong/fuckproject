package com.zhigu.controllers.mobile.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Address;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAddressService;

/**
 * 用户收货地址
 * 
 * @author HeSiMin
 * @date 2014年11月18日
 *
 */
@RequestMapping("/mobile/user/address")
@Controller
public class MobileAddressController {
	@Autowired
	private IAddressService addressService;

	/**
	 * 查询收货地址
	 * 
	 * @return
	 */
	@RequestMapping("/queryAddress")
	@ResponseBody
	public MsgBean queryAddress() {
		return new MsgBean(Code.SUCCESS, "", MsgLevel.NORMAL).setData(addressService.queryAddressByUserID(SessionHelper.getSessionUser().getUserId()));
	}

	/**
	 * 添加收货地址
	 * 
	 * @return
	 */
	@RequestMapping("/addAddress")
	@ResponseBody
	public MsgBean addAddress(Address address) {
		return addressService.saveAddress(address);
	}

	/**
	 * 修改地址
	 * 
	 * @param address
	 * @return
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public MsgBean modify(Address address) {
		return addressService.updateAddress(address);
	}

	/**
	 * 删除
	 * 
	 * @param addressID
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public MsgBean delete(Integer addressID) {
		if (addressID == null)
			return new MsgBean(Code.FAIL, "参数错误！", MsgLevel.ERROR);
		return addressService.deleteAddress(SessionHelper.getSessionUser().getUserId(), addressID);

	}

	/**
	 * 修改默认
	 * 
	 * @param addressID
	 * @return
	 */
	@RequestMapping("/setDefault")
	@ResponseBody
	public MsgBean updateDefault(Integer addressID) {
		return addressService.updateDefaultAddress(SessionHelper.getSessionUser().getUserId(), addressID);
	}
}
