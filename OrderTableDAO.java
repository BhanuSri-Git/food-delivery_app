package com.food.DAO;

import java.util.List;

import com.food.Model.OrderTable;

public interface OrderTableDAO {
	void addOrderTable(OrderTable orderTable);
	OrderTable getOrderTable(int OrderTableId);
	void updateOrderTable(OrderTable orderTable);
	void deleteOrderTable(int OrderTableId);
	List<OrderTable> getAllOrderTables();

}
