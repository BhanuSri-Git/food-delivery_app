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

import com.food.DAO.MenuDAO;
import com.food.Model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    public static final String INSERT_QUERY =
        "INSERT INTO Menu(RestaurantID, ItemName, Description, Price, IsAvailable, Category, Rating, CreatedAt, UpdatedAt, imagePath) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
        "SELECT * FROM menu WHERE MenuID = ?";

    public static final String UPDATE_QUERY =
        "UPDATE menu SET RestaurantID=?, ItemName=?, Description=?, Price=?, IsAvailable=?, Category=?, Rating=?, UpdatedAt=?, imagePath=? " +
        "WHERE MenuID=?";

    public static final String DELETE_QUERY =
        "DELETE FROM menu WHERE MenuID = ?";

    public static final String SELECT_ALL_QUERY =
        "SELECT * FROM menu";

    public static final String SELECT_BY_RESTAURANT_QUERY =
        "SELECT * FROM menu WHERE RestaurantID = ?";

    // =================== ADD ===================
    @Override
    public void addMenu(Menu menu) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(INSERT_QUERY)) {

            stmt.setInt(1, menu.getRestaurantID());
            stmt.setString(2, menu.getItemName());
            stmt.setString(3, menu.getDescription());
            stmt.setBigDecimal(4, menu.getPrice());
            stmt.setBoolean(5, menu.getIsAvailable());
            stmt.setString(6, menu.getCategory());
            stmt.setDouble(7, menu.getRating());
            stmt.setTimestamp(8, new Timestamp(System.currentTimeMillis())); // CreatedAt
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis())); // UpdatedAt
            // FIX: DeletedAt column removed from INSERT — NULL by default for active items
            stmt.setString(10, menu.getImagePath());

            int rows = stmt.executeUpdate();
            System.out.println("Menu inserted: " + rows + " row(s)");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET BY ID ===================
    @Override
    public Menu getMenu(int menuId) {
        Menu menu = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_QUERY)) {

            stmt.setInt(1, menuId);
            ResultSet res = stmt.executeQuery();

            if (res.next()) {
                // FIX: Use full constructor that includes MenuID so getMenuID() returns correct value
                int menuID      = res.getInt("MenuID");
                int restaurantID = res.getInt("RestaurantID");
                String itemName  = res.getString("ItemName");
                String description = res.getString("Description");
                BigDecimal price = res.getBigDecimal("Price");
                boolean isAvailable = res.getBoolean("IsAvailable");
                String category  = res.getString("Category");
                double rating    = res.getDouble("Rating");
                Timestamp createdAt  = res.getTimestamp("CreatedAt");
                Timestamp updatedAt  = res.getTimestamp("UpdatedAt");
                Timestamp deletedAt  = res.getTimestamp("DeletedAt");
                String imagePath = res.getString("imagePath");

                menu = new Menu(menuID, restaurantID, itemName, description, price,
                        isAvailable, category, rating, createdAt, updatedAt, deletedAt, imagePath);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menu;
    }

    // =================== UPDATE ===================
    @Override
    public void updateMenu(Menu menu) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY)) {

            stmt.setInt(1, menu.getRestaurantID());
            stmt.setString(2, menu.getItemName());
            stmt.setString(3, menu.getDescription());
            stmt.setBigDecimal(4, menu.getPrice());
            stmt.setBoolean(5, menu.getIsAvailable());
            stmt.setString(6, menu.getCategory());
            stmt.setDouble(7, menu.getRating());
            stmt.setTimestamp(8, new Timestamp(System.currentTimeMillis())); // UpdatedAt
            stmt.setString(9, menu.getImagePath());
            stmt.setInt(10, menu.getMenuID());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== DELETE ===================
    @Override
    public void deleteMenu(int menuId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, menuId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET ALL ===================
    @Override
    public List<Menu> getAllMenus() {
        List<Menu> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY)) {

            while (res.next()) {
                int menuId       = res.getInt("MenuID");
                int restaurantID = res.getInt("RestaurantID");
                String itemName  = res.getString("ItemName");
                String description = res.getString("Description");
                BigDecimal price = res.getBigDecimal("Price");
                boolean isAvailable = res.getBoolean("IsAvailable");
                String category  = res.getString("Category");
                double rating    = res.getDouble("Rating");
                Timestamp createdAt  = res.getTimestamp("CreatedAt");
                Timestamp updatedAt  = res.getTimestamp("UpdatedAt");
                Timestamp deletedAt  = res.getTimestamp("DeletedAt");
                String imagePath = res.getString("imagePath");

                Menu menu = new Menu(menuId, restaurantID, itemName, description, price,
                        isAvailable, category, rating, createdAt, updatedAt, deletedAt, imagePath);
                list.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =================== GET BY RESTAURANT ===================
    @Override
    public List<Menu> getAllMenusByRestaurant(int restaurantId) {
        List<Menu> menuList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(SELECT_BY_RESTAURANT_QUERY)) {

            pstmt.setInt(1, restaurantId);
            ResultSet res = pstmt.executeQuery();

            while (res.next()) {
                int menuId       = res.getInt("MenuID");
                String itemName  = res.getString("ItemName");
                String description = res.getString("Description");
                BigDecimal price = res.getBigDecimal("Price");
                boolean isAvailable = res.getBoolean("IsAvailable");
                String category  = res.getString("Category");
                double rating    = res.getDouble("Rating");
                Timestamp createdAt  = res.getTimestamp("CreatedAt");
                Timestamp updatedAt  = res.getTimestamp("UpdatedAt");
                Timestamp deletedAt  = res.getTimestamp("DeletedAt");
                String imagePath = res.getString("imagePath");

                Menu menu = new Menu(menuId, restaurantId, itemName, description, price,
                        isAvailable, category, rating, createdAt, updatedAt, deletedAt, imagePath);
                menuList.add(menu);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }
}
