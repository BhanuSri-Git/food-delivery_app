package com.food.Model;

import java.math.BigDecimal;

public class OrderItem {
	private int OrderItemID;
	private int OrderID;
	private int MenuID;
	private int Quantity;
	private BigDecimal ItemTotal;
	public OrderItem() {

	}
	public OrderItem(int OrderItemID, int OrderID, int MenuID, int Quantity, BigDecimal ItemTotal) {
		super();
		this.OrderItemID = OrderItemID;
		this.OrderID = OrderID;
		this.MenuID = MenuID;
		this.Quantity = Quantity;
		this.ItemTotal = ItemTotal;
	}
	public OrderItem(int OrderID, int MenuID, int Quantity, BigDecimal ItemTotal) {
		super();
		this.OrderID = OrderID;
		this.MenuID = MenuID;
		this.Quantity = Quantity;
		this.ItemTotal = ItemTotal;
	}

	@Override
	public String toString() {
		return "OrderItem [OrderItemID=" + OrderItemID + ", OrderID=" + OrderID + ", MenuID=" + MenuID + ", Quantity="
				+ Quantity + ", ItemTotal=" + ItemTotal + "]";
	}
	public int getOrderItemID() {
		return OrderItemID;
	}
	public void setOrderItemID(int OrderItemID) {
		this.OrderItemID = OrderItemID;
	}
	public int getOrderID() {
		return OrderID;
	}
	public void setOrderID(int OrderID) {
		this.OrderID = OrderID;
	}
	public int getMenuID() {
		return MenuID;
	}
	public void setMenuID(int MenuID) {
		this.MenuID = MenuID;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int Quantity) {
		this.Quantity = Quantity;
	}
	public BigDecimal getItemTotal() {
		return ItemTotal;
	}
	public void setItemTotal(BigDecimal ItemTotal) {
		this.ItemTotal = ItemTotal;
	}


}