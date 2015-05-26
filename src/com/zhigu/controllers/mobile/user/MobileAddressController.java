package com.zhigu.controllers.mobile.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.common.utils.ServiceMsg;
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
	public List<Address> queryAddress() {
		// 收货地址
		return addressService.queryAddressByUserID(SessionHelper.getSessionUser().getUserID());
	}

	/**
	 * 添加收货地址
	 * 
	 * @return
	 */
	@RequestMapping("/addAddress")
	@ResponseBody
	public MsgBean addAddress(Address address) {
		addressService.saveAddress(address);
		return ServiceMsg.getMsgBean();
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
		addressService.updateAddress(address);
		return ServiceMsg.getMsgBean();
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
		if (addressID == null) {
			return new MsgBean(Code.FAIL, "参数错误！", MsgLevel.ERROR);
		}
		addressService.deleteAddress(SessionHelper.getSessionUser().getUserID(), addressID);
		return new MsgBean(Code.SUCCESS, "删除成功！", MsgLevel.NORMAL);
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
		addressService.updateDefaultAddress(SessionHelper.getSessionUser().getUserID(), addressID);
		return new MsgBean(Code.SUCCESS, "设置默认地址成功！", MsgLevel.NORMAL);
	}
}
