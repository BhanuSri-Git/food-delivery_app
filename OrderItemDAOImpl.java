package com.food.DAOImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrderItemDAO;
import com.food.Model.OrderItem;
import com.tap.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    public static final String INSERT_QUERY =
        "INSERT INTO orderItem(OrderID, MenuID, Quantity, ItemTotal) VALUES (?, ?, ?, ?)";

    public static final String SELECT_QUERY =
        "SELECT * FROM orderItem WHERE OrderItemID = ?";

    public static final String UPDATE_QUERY =
        "UPDATE orderItem SET OrderID=?, MenuID=?, Quantity=?, ItemTotal=? WHERE OrderItemID=?";

    public static final String DELETE_QUERY =
        "DELETE FROM orderItem WHERE OrderItemID = ?";

    public static final String SELECT_ALL_QUERY =
        "SELECT * FROM orderItem";

    public static final String SELECT_BY_ORDER_QUERY =
        "SELECT * FROM orderItem WHERE OrderID = ?";

    // =================== ADD ===================
    @Override
    public void addOrderItem(OrderItem orderItem) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(INSERT_QUERY)) {

            if (con == null) {
                throw new SQLException("Database connection failed");
            }

            stmt.setInt(1, orderItem.getOrderID());
            stmt.setInt(2, orderItem.getMenuID());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setBigDecimal(4, orderItem.getItemTotal());
            int rows = stmt.executeUpdate();
            System.out.println("OrderItem inserted: " + rows + " row(s)");

        } catch (SQLException e) {
            System.err.println("Failed to add OrderItem: OrderID=" + orderItem.getOrderID() + 
                             ", MenuID=" + orderItem.getMenuID() + " - Error: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database error inserting OrderItem", e);
        }
    }

    // =================== GET BY ID ===================
    @Override
    public OrderItem getOrderItem(int orderItemId) {
        OrderItem orderItem = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_QUERY)) {

            stmt.setInt(1, orderItemId);
            ResultSet res = stmt.executeQuery();

            if (res.next()) {
                int orderItemID  = res.getInt("OrderItemID");
                int orderID      = res.getInt("OrderID");
                int menuID       = res.getInt("MenuID");
                int quantity     = res.getInt("Quantity");
                // FIX: Was stored in variable named "address" and real ItemTotal was hardcoded to null
                BigDecimal itemTotal = res.getBigDecimal("ItemTotal");

                orderItem = new OrderItem(orderItemID, orderID, menuID, quantity, itemTotal);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItem;
    }

    // =================== UPDATE ===================
    @Override
    public void updateOrderItem(OrderItem orderItem) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY)) {

            stmt.setInt(1, orderItem.getOrderID());
            stmt.setInt(2, orderItem.getMenuID());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setBigDecimal(4, orderItem.getItemTotal());
            stmt.setInt(5, orderItem.getOrderItemID());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== DELETE ===================
    @Override
    public void deleteOrderItem(int orderItemId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, orderItemId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET ALL ===================
    @Override
    public List<OrderItem> getAllOrderItems() {
        List<OrderItem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY)) {

            while (res.next()) {
                int orderItemID  = res.getInt("OrderItemID");
                int orderID      = res.getInt("OrderID");
                int menuID       = res.getInt("MenuID");
                int quantity     = res.getInt("Quantity");
                BigDecimal itemTotal = res.getBigDecimal("ItemTotal");

                OrderItem orderItem = new OrderItem(orderItemID, orderID, menuID, quantity, itemTotal);
                list.add(orderItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =================== GET BY ORDER ===================
    public List<OrderItem> getOrderItemsByOrderID(int orderId) {
        List<OrderItem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_BY_ORDER_QUERY)) {

            stmt.setInt(1, orderId);
            ResultSet res = stmt.executeQuery();

            while (res.next()) {
                int orderItemID  = res.getInt("OrderItemID");
                int menuID       = res.getInt("MenuID");
                int quantity     = res.getInt("Quantity");
                BigDecimal itemTotal = res.getBigDecimal("ItemTotal");

                OrderItem orderItem = new OrderItem(orderItemID, orderId, menuID, quantity, itemTotal);
                list.add(orderItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
