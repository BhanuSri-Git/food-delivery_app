package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.UserDAO;
import com.food.Model.User;
import com.tap.utility.DBConnection;

public class UserDAOImpl implements UserDAO {

    public static final String INSERT_QUERY =
        "INSERT INTO user(UserName, password, email, address, role, createDate, lastLoginDate) VALUES (?, ?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
        "SELECT * FROM user WHERE UserId = ?";

    public static final String UPDATE_QUERY =
        "UPDATE user SET UserName=?, password=?, email=?, address=?, role=?, lastLoginDate=? WHERE UserId=?";

    public static final String DELETE_QUERY =
        "DELETE FROM user WHERE UserId = ?";

    public static final String SELECT_ALL_QUERY =
        "SELECT * FROM user";

    // =================== ADD ===================
    @Override
    public int addUser(User user) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_QUERY)) {

            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getpassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getRole());
            stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            stmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));

            return stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // =================== GET BY ID ===================
    @Override
    public User getUser(int userId) {
        User user = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(SELECT_QUERY)) {

            stmt.setInt(1, userId);
            ResultSet res = stmt.executeQuery();

            if (res.next()) {
                int id           = res.getInt("UserId");
                String userName  = res.getString("UserName");
                String password  = res.getString("password");
                String email     = res.getString("email");
                String address   = res.getString("address");
                String role      = res.getString("role");
                Timestamp createDate    = res.getTimestamp("createDate");
                Timestamp lastLoginDate = res.getTimestamp("lastLoginDate");

                user = new User(id, userName, password, email, address, role, createDate, lastLoginDate);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // =================== UPDATE ===================
    @Override
    public void updateUser(User user) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(UPDATE_QUERY)) {

            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getpassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getRole());
            stmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(7, user.getUserId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== DELETE ===================
    @Override
    public void deleteUser(int userId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, userId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // =================== GET ALL ===================
    @Override
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY)) {

            while (res.next()) {
                int id           = res.getInt("UserId");
                String userName  = res.getString("UserName");
                String password  = res.getString("password");
                String email     = res.getString("email");
                String address   = res.getString("address");
                String role      = res.getString("role");
                Timestamp createDate    = res.getTimestamp("createDate");
                Timestamp lastLoginDate = res.getTimestamp("lastLoginDate");

                User user = new User(id, userName, password, email, address, role, createDate, lastLoginDate);
                list.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // =================== GET BY USERNAME ===================
    @Override
    public User getUserByUsername(String username) {
        User user = null;
        String sql = "SELECT * FROM user WHERE UserName = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserId"));
                user.setUserName(rs.getString("UserName"));
                user.setpassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
