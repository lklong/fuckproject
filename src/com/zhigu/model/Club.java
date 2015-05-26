package com.zhigu.model;

import java.util.ArrayList;
import java.util.List;

public class Club {
	private List<Order> orders = new ArrayList<Order>();

	// TODO cart private List<ShoppingCartItem> cartItems = new
	// ArrayList<ShoppingCartItem>();

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	// public List<ShoppingCartItem> getCartItems() {
	// return cartItems;
	// }
	//
	// public void setCartItems(List<ShoppingCartItem> cartItems) {
	// this.cartItems = cartItems;
	// }

}
