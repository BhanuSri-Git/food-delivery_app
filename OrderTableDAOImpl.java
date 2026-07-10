package com.food.DAOImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrderTableDAO;
import com.food.Model.OrderTable;
import com.tap.utility.DBConnection;

public class OrderTableDAOImpl implements OrderTableDAO {

    public static final String INSERT_QUERY =
        "INSERT INTO ordertable(UserID, RestaurantID, OrderDate, TotalAmount, Status, PaymentMethod, fullName, phone, addressLine1, addressLine2, city, pincode) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
        "SELECT * FROM ordertable WHERE OrderID = ?";

    public static final String UPDATE_QUERY =
        "UPDATE ordertable SET UserID=?, RestaurantID=?, OrderDate=?, TotalAmount=?, Status=?, PaymentMethod=?, fullName=?, phone=?, addressLine1=?, addressLine2=?, city=?, pincode=? " +
        "WHERE OrderID=?";

    public static final String DELETE_QUERY =
        "DELETE FROM ordertable WHERE OrderID = ?";

    public static final String SELECT_ALL_QUERY =
        "SELECT * FROM ordertable";

    public static final String SELECT_BY_USER_QUERY =
        "SELECT * FROM ordertable WHERE UserID = ? ORDER BY OrderDate DESC";

    // =================== ADD (returns generated OrderID) ===================
    @Override
    public void addOrderTable(OrderTable orderTable) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(INSERT_QUERY)) {

            stmt.setInt(1, orderTable.getUserID());
            stmt.setInt(2, orderTable.getRestaurantID());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setBigDecimal(4, orderTable.getTotalAmount());
            stmt.setString(5, orderTable.getStatus());
            stmt.setString(6, orderTable.getPaymentMethod());
            stmt.setString(7, orderTable.getFullName());
            stmt.setString(8, orderTable.getPhone());
            stmt.setString(9, orderTable.getAddressLine1());
            stmt.setString(10, orderTable.getAddressLine2());
            stmt.setString(11, orderTable.getCity());
            stmt.setString(12, orderTable.getPincode());
            int rows = stmt.executeUpdate();
            System.out.println("OrderTable inserted: " + rows + " row(s)");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Inserts an order and returns the generated OrderID (primary key).
     * Used by CheckoutServlet to link OrderItems to the new Order.
     * 
     * @param orderTable The OrderTable object to insert
     * @return The generated OrderID, or -1 if insertion failed
     */
    public int addOrderTableAndGetID(OrderTable orderTable) {
        int generatedID = -1;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS)) {

            if (con == null) {
                System.err.println("Database connection failed");
                return -1;
            }

            stmt.setInt(1, orderTable.getUserID());
            stmt.setInt(2, orderTable.getRestaurantID());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setBigDecimal(4, orderTable.getTotalAmount());
            stmt.setString(5, orderTable.getStatus());
            stmt.setString(6, orderTable.getPaymentMethod());
            stmt.setString(7, orderTable.getFullName());
            stmt.setString(8, orderTable.getPhone());
            stmt.setString(9, orderTable.getAddressLine1());
            stmt.setString(10, orderTable.getAddressLine2());
            stmt.setString(11, orderTable.getCity());
            stmt.setString(12, orderTable.getPincode());
            
            int rowsAffected = stmt.executeUpdate();
            System.out.println("OrderTable insert: " + rowsAffected + " row(s) affected");

            if (rowsAffected > 0) {
                // Try to get the generated keys
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys != null && generatedKeys.next()) {
                        generatedID = generatedKeys.getInt(1);
                        System.out.println("Generated OrderID: " + generatedID);
                    } else {
                        System.err.println("Warning: No generated keys returned. Attempting fallback query.");
                        // Fallback: query the most recent order for this user
                        generatedID = getMostRecentOrderIDForUser(con, orderTable.getUserID());
                    }
                } catch (SQLException e) {
                    System.err.println("Error retrieving generated keys: " + e.getMessage());
                    // Fallback to getting the last order
                    generatedID = getMostRecentOrderIDForUser(con, orderTable.getUserID());
                }
            }

        } catch (SQLException e) {
            System.err.println("Failed to add OrderTable: " + e.getMessage());
            e.printStackTrace();
        }
        
        return generatedID;
    }

    /**
     * Helper method: Get the most recent OrderID for a user (fallback for getGeneratedKeys failure)
     */
    private int getMostRecentOrderIDForUser(Connection con, int userID) {
        String query = "SELECT OrderID FROM ordertable WHERE UserID = ? ORDER BY OrderDate DESC LIMIT 1";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userID);
            try (ResultSet res = stmt.executeQuery()) {
                if (res.next()) {
                    int orderID = res.getInt("OrderID");
                    System.out.println("Fallback: Retrieved most recent OrderID for user " + userID + ": " + orderID);
                    return orderID;
                }
            }
        } catch (SQLException e) {
            System.err.println("Fallback query failed: " + e.getMessage());
        }
        return -1;
    }

    // =================== GET BY ID ===================
    @Override
    public OrderTable getOrderTable(int orderTableId) {
        OrderTable orderTable = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_QUERY)) {

            stmt.setInt(1, orderTableId);
            ResultSet res = stmt.executeQuery();

            if (res.next()) {
                int orderID      = res.getInt("OrderID");
                int userID       = res.getInt("UserID");
                int restaurantID = res.getInt("RestaurantID");
                Timestamp orderDate  = res.getTimestamp("OrderDate");
                BigDecimal totalAmount = res.getBigDecimal("TotalAmount");
                String status        = res.getString("Status");
                String paymentMethod = res.getString("PaymentMethod");
                String fullName = res.getString("fullName");
                String phone = res.getString("phone");
                String addressLine1 = res.getString("addressLine1");
                String addressLine2 = res.getString("addressLine2");
                String city = res.getString("city");
                String pincode = res.getString("pincode");

                orderTable = new OrderTable(orderID, userID, restaurantID, orderDate, totalAmount, status, paymentMethod);
                orderTable.setFullName(fullName);
                orderTable.setPhone(phone);
                orderTable.setAddressLine1(addressLine1);
                orderTable.setAddressLine2(addressLine2);
                orderTable.setCity(city);
                orderTable.setPincode(pincode);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderTable;
    }

    // =================== UPDATE ===================
    @Override
    public void updateOrderTable(OrderTable orderTable) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY)) {

            stmt.setInt(1, orderTable.getUserID());
            stmt.setInt(2, orderTable.getRestaurantID());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.setBigDecimal(4, orderTable.getTotalAmount());
            stmt.setString(5, orderTable.getStatus());
            stmt.setString(6, orderTable.getPaymentMethod());
            stmt.setString(7, orderTable.getFullName());
            stmt.setString(8, orderTable.getPhone());
            stmt.setString(9, orderTable.getAddressLine1());
            stmt.setString(10, orderTable.getAddressLine2());
            stmt.setString(11, orderTable.getCity());
            stmt.setString(12, orderTable.getPincode());
            stmt.setInt(13, orderTable.getOrderID());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== DELETE ===================
    @Override
    public void deleteOrderTable(int orderTableId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, orderTableId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET ALL ===================
    @Override
    public List<OrderTable> getAllOrderTables() {
        List<OrderTable> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY)) {

            while (res.next()) {
                int orderID      = res.getInt("OrderID");
                int userID       = res.getInt("UserID");
                int restaurantID = res.getInt("RestaurantID");
                Timestamp orderDate  = res.getTimestamp("OrderDate");
                BigDecimal totalAmount = res.getBigDecimal("TotalAmount");
                String status        = res.getString("Status");
                String paymentMethod = res.getString("PaymentMethod");
                String fullName = res.getString("fullName");
                String phone = res.getString("phone");
                String addressLine1 = res.getString("addressLine1");
                String addressLine2 = res.getString("addressLine2");
                String city = res.getString("city");
                String pincode = res.getString("pincode");

                OrderTable orderTable = new OrderTable(orderID, userID, restaurantID, orderDate, totalAmount, status, paymentMethod);
                orderTable.setFullName(fullName);
                orderTable.setPhone(phone);
                orderTable.setAddressLine1(addressLine1);
                orderTable.setAddressLine2(addressLine2);
                orderTable.setCity(city);
                orderTable.setPincode(pincode);
                list.add(orderTable);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =================== GET BY USER (for Order History) ===================
    public List<OrderTable> getOrdersByUserID(int userId) {
        List<OrderTable> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_BY_USER_QUERY)) {

            stmt.setInt(1, userId);
            ResultSet res = stmt.executeQuery();

            while (res.next()) {
                int orderID      = res.getInt("OrderID");
                int restaurantID = res.getInt("RestaurantID");
                Timestamp orderDate  = res.getTimestamp("OrderDate");
                BigDecimal totalAmount = res.getBigDecimal("TotalAmount");
                String status        = res.getString("Status");
                String paymentMethod = res.getString("PaymentMethod");
                String fullName = res.getString("fullName");
                String phone = res.getString("phone");
                String addressLine1 = res.getString("addressLine1");
                String addressLine2 = res.getString("addressLine2");
                String city = res.getString("city");
                String pincode = res.getString("pincode");

                OrderTable orderTable = new OrderTable(orderID, userId, restaurantID, orderDate, totalAmount, status, paymentMethod);
                orderTable.setFullName(fullName);
                orderTable.setPhone(phone);
                orderTable.setAddressLine1(addressLine1);
                orderTable.setAddressLine2(addressLine2);
                orderTable.setCity(city);
                orderTable.setPincode(pincode);
                list.add(orderTable);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
