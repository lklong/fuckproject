package com.zhigu.controllers.user;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zhigu.common.SessionHelper;
import com.zhigu.common.constant.Code;
import com.zhigu.common.constant.enumconst.MsgLevel;
import com.zhigu.model.Address;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.IAddressService;

/**
 * 收货地址
 * 
 * @author liyouzan 2014年7月28日11:37:34
 */
@Controller
@RequestMapping("/user/address")
public class AddressController {

	@Autowired
	private IAddressService addressService;

	@RequestMapping("userAllAddress")
	@ResponseBody
	public MsgBean userAllAddress() {
		return new MsgBean(Code.SUCCESS, "ok", MsgLevel.NORMAL).setData(addressService.queryAddressByUserID(SessionHelper.getSessionUser().getUserID()));
	}

	// 初始化跳转操作
	@RequestMapping("")
	public ModelAndView index(Integer addressId, ModelAndView mv) {
		// 查询并显示所有的地址信息
		List<Address> list = new ArrayList<Address>();
		list = addressService.queryAddressByUserID(SessionHelper.getSessionUser().getUserID());
		mv.setViewName("user/address/address");
		mv.addObject("list", list);
		return mv;
	}

	/**
	 * 获取默认地址
	 * 
	 * @return
	 */
	@RequestMapping("/getDefaultAddress")
	@ResponseBody
	public Address getDefaultAddress() {
		return addressService.queryDefaultAddress(SessionHelper.getSessionUser().getUserID());
	}

	@RequestMapping("/add")
	@ResponseBody
	public MsgBean add(Address address) {
		return addressService.saveAddress(address);
	}

	@RequestMapping(value = "/set", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView set(ModelAndView mv, Integer addressId) {
		if (addressId != null) {
			Address address = addressService.queryAddressByID(SessionHelper.getSessionUser().getUserID(), addressId);
			mv.addObject("address", address);
		}
		mv.setViewName("/user/address/set");
		return mv;
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
	 * 修改默认
	 * 
	 * @param addressId
	 * @return
	 */
	@RequestMapping("/default")
	@ResponseBody
	public MsgBean updateDefault(Integer addressId) {
		if (addressId == null) {
			return new MsgBean(Code.FAIL, "传递信息丢失", MsgLevel.ERROR);
		}
		addressService.updateDefaultAddress(SessionHelper.getSessionUser().getUserID(), addressId);
		return new MsgBean(Code.SUCCESS, "设置默认地址成功", MsgLevel.NORMAL);
	}

	/**
	 * 删除
	 * 
	 * @param addressId
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public MsgBean delete(Integer addressId) {
		if (addressId == null)
			return new MsgBean(Code.FAIL, "传递信息丢失", MsgLevel.ERROR);

		addressService.deleteAddress(SessionHelper.getSessionUser().getUserID(), addressId);

		return new MsgBean(Code.SUCCESS, "删除地址成功", MsgLevel.NORMAL);
	}

	/**
	 * 弹框新增、修改地址
	 * 
	 * @param addressId
	 * @param mv
	 * @return
	 */
	@RequestMapping("/dialog")
	public ModelAndView dialog(Integer addressId, ModelAndView mv) {
		mv.setViewName("/user/address/dialog");
		if (addressId == null)
			return mv;

		Address address = addressService.queryAddressByID(SessionHelper.getSessionUser().getUserID(), addressId);
		mv.addObject("address", address);
		return mv;
	}

}
