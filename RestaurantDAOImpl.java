package com.food.DAOImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.RestaurantDAO;
import com.food.Model.Restaurant;
import com.tap.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    public static final String INSERT_QUERY =
        "INSERT INTO restaurant(Name, CuisineType, DeliveryTime, Address, AdminUserID, Rating, IsActive, imagePath) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
        "SELECT * FROM restaurant WHERE RestaurantID = ?";

    public static final String UPDATE_QUERY =
        "UPDATE restaurant SET Name=?, CuisineType=?, DeliveryTime=?, Address=?, AdminUserID=?, Rating=?, IsActive=?, imagePath=? " +
        "WHERE RestaurantID=?";

    public static final String DELETE_QUERY =
        "DELETE FROM restaurant WHERE RestaurantID = ?";

    public static final String SELECT_ALL_QUERY =
        "SELECT * FROM restaurant WHERE IsActive = TRUE";

    // =================== ADD ===================
    @Override
    public void addRestaurant(Restaurant restaurant) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(INSERT_QUERY)) {

            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getCuisineType());
            stmt.setInt(3, restaurant.getDeliveryTime());
            stmt.setString(4, restaurant.getAddress());
            stmt.setInt(5, restaurant.getAdminUserID());
            stmt.setBigDecimal(6, restaurant.getRating());
            stmt.setBoolean(7, restaurant.getIsActive());
            stmt.setString(8, restaurant.getImagePath());
            int rows = stmt.executeUpdate();
            System.out.println("Restaurant inserted: " + rows + " row(s)");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET BY ID ===================
    @Override
    public Restaurant getRestaurant(int restaurantId) {
        Restaurant restaurant = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_QUERY)) {

            stmt.setInt(1, restaurantId);
            ResultSet res = stmt.executeQuery();

            if (res.next()) {
                int id           = res.getInt("RestaurantID");
                String name      = res.getString("Name");
                String cuisine   = res.getString("CuisineType");
                int deliveryTime = res.getInt("DeliveryTime");
                String address   = res.getString("Address");
                int adminUserID  = res.getInt("AdminUserID");
                BigDecimal rating = res.getBigDecimal("Rating");
                boolean isActive  = res.getBoolean("IsActive");
                String imagePath  = res.getString("imagePath");

                restaurant = new Restaurant(id, name, cuisine, deliveryTime, address, adminUserID, rating, isActive, imagePath);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurant;
    }

    // =================== UPDATE ===================
    @Override
    public void updateRestaurant(Restaurant restaurant) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY)) {

            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getCuisineType());
            stmt.setInt(3, restaurant.getDeliveryTime());
            stmt.setString(4, restaurant.getAddress());
            stmt.setInt(5, restaurant.getAdminUserID());
            stmt.setBigDecimal(6, restaurant.getRating());
            stmt.setBoolean(7, restaurant.getIsActive());
            stmt.setString(8, restaurant.getImagePath());
            stmt.setInt(9, restaurant.getRestaurantID());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== DELETE ===================
    @Override
    public void deleteRestaurant(int restaurantId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, restaurantId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET ALL (active only) ===================
    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurantList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY)) {

            while (res.next()) {
                int id           = res.getInt("RestaurantID");
                String name      = res.getString("Name");
                String cuisine   = res.getString("CuisineType");
                int deliveryTime = res.getInt("DeliveryTime");
                String address   = res.getString("Address");
                int adminUserID  = res.getInt("AdminUserID");
                BigDecimal rating = res.getBigDecimal("Rating");
                boolean isActive  = res.getBoolean("IsActive");
                String imagePath  = res.getString("imagePath");

                restaurantList.add(new Restaurant(id, name, cuisine, deliveryTime, address, adminUserID, rating, isActive, imagePath));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurantList;
    }
}
