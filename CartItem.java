package com.food.Model;

import java.math.BigDecimal;

public class CartItem {
	
	private int MenuID;
	private int RestaurantID;
	private String name;
	private BigDecimal Price;
	private int quantity;
	public CartItem() {
		
	}
	public BigDecimal getTotalPrice(){

	    return Price.multiply(
	        new BigDecimal(quantity)
	    );

	}
	public CartItem(int menuID, int restaurantID, String name, BigDecimal price, int quantity) {
	    this.MenuID = menuID;
	    this.RestaurantID = restaurantID;
	    this.name = name;
	    this.Price = price;
	    this.quantity = quantity;
	}
	public int getMenuID() {
		return MenuID;
	}
	public void setMenuID(int menuID) {
		this.MenuID = menuID;
	}
	public int getRestaurantID() {
		return RestaurantID;
	}
	public void setRestaurantID(int restaurantID) {
		this.RestaurantID = restaurantID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getPrice() {
		return Price;
	}
	public void setPrice(BigDecimal price) {
		this.Price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
	
	
	
	

}
