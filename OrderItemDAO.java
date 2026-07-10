package com.food.DAO;

import java.util.List;

import com.food.Model.OrderItem;



public interface OrderItemDAO {
	void addOrderItem(OrderItem orderItem);
	OrderItem getOrderItem(int OrderItemId);
	void updateOrderItem(OrderItem orderItem);
	void deleteOrderItem(int orderItemId);
	List<OrderItem> getAllOrderItems();

}