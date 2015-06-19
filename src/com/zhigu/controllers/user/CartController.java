package com.zhigu.controllers.user;

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
import com.zhigu.model.ShoppingCart;
import com.zhigu.model.dto.MsgBean;
import com.zhigu.service.user.ICartService;

@Controller
@RequestMapping("/user/cart")
public class CartController {
	@Autowired
	private ICartService cartService;

	/**
	 * 查看购物车
	 * 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView myCart(ModelAndView mv) {
		mv.setViewName("/user/order/mycart");
		List<ShoppingCart> shoppingCartList = cartService.queryShoppingCart(SessionHelper.getSessionUser().getUserId(), null);
		mv.addObject("shoppingCartList", shoppingCartList);
		return mv;
	}

	@RequestMapping("/add")
	@ResponseBody
	public MsgBean add(Integer skuId, Integer quantity) {
		return cartService.addShoppingCartItem(skuId, quantity);
	}

	/**
	 * 修改购物车商品选中状态
	 * 
	 * @param ids
	 * @param isChecked
	 * @return
	 */
	@RequestMapping("/checked")
	@ResponseBody
	public MsgBean checked(String[] idAndIsChecked) {
		if (idAndIsChecked != null && idAndIsChecked.length > 0) {
			for (String t : idAndIsChecked) {
				String[] idAndChecked = t.split(":");
				cartService.updateCartChecked(Integer.parseInt(idAndChecked[0]), "1".equals(idAndChecked[1]));
			}
		}
		return new MsgBean(Code.SUCCESS, "修改成功", MsgLevel.NORMAL);
	}

	/**
	 * 修改购物车中的商品数量
	 * 
	 * @param id
	 * @param quantity
	 * @return
	 */
	@RequestMapping("/updateGoodsQuantity")
	@ResponseBody
	public MsgBean cartUpdateGoodsQuantity(int id, int quantity) {
		return cartService.updateCartGoodsQuantity(id, quantity);
	}

	/**
	 * 删除购物车中的商品
	 * 
	 * @param items
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public MsgBean delete(Integer[] items) {
		return cartService.deleteShoppingCart(items);
	}
}
