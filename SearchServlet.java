package com.food.Servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.food.Model.Menu;
import com.food.Model.Restaurant;
import com.food.Model.User;
import com.tap.utility.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String query    = req.getParameter("q");
        String filter   = req.getParameter("filter");   // veg|nonveg|rating|fast|offers
        String sort     = req.getParameter("sort");     // price_asc|price_desc|rating

        if (query == null) query = "";
        query = query.trim();

        List<Restaurant> restaurants = new ArrayList<>();
        List<Menu>       menuItems   = new ArrayList<>();

        String likeQ = "%" + query + "%";

        // ---- Search restaurants ----
        String rSql = "SELECT * FROM restaurant WHERE IsActive=TRUE AND (Name LIKE ? OR CuisineType LIKE ? OR Address LIKE ?)";
        if ("fast".equals(filter))   rSql += " AND DeliveryTime <= 25";
        if ("rating".equals(filter)) rSql += " AND Rating >= 4.0";
        rSql += " ORDER BY Rating DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(rSql)) {
            ps.setString(1, likeQ); ps.setString(2, likeQ); ps.setString(3, likeQ);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                restaurants.add(new Restaurant(
                    rs.getInt("RestaurantID"), rs.getString("Name"),
                    rs.getString("CuisineType"), rs.getInt("DeliveryTime"),
                    rs.getString("Address"), rs.getInt("AdminUserID"),
                    rs.getBigDecimal("Rating"), rs.getBoolean("IsActive"),
                    rs.getString("imagePath")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }

        // ---- Search menu items ----
        String mSql = "SELECT * FROM menu WHERE DeletedAt IS NULL AND (ItemName LIKE ? OR Description LIKE ? OR Category LIKE ?)";
        if ("veg".equals(filter))    mSql += " AND Category NOT LIKE '%chicken%' AND Category NOT LIKE '%mutton%' AND Category NOT LIKE '%fish%'";
        if ("price_asc".equals(sort))  mSql += " ORDER BY Price ASC";
        else if ("price_desc".equals(sort)) mSql += " ORDER BY Price DESC";
        else mSql += " ORDER BY Rating DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(mSql)) {
            ps.setString(1, likeQ); ps.setString(2, likeQ); ps.setString(3, likeQ);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                menuItems.add(new Menu(
                    rs.getInt("MenuID"), rs.getInt("RestaurantID"),
                    rs.getString("ItemName"), rs.getString("Description"),
                    rs.getBigDecimal("Price"), rs.getBoolean("IsAvailable"),
                    rs.getString("Category"), rs.getDouble("Rating"),
                    rs.getTimestamp("CreatedAt"), rs.getTimestamp("UpdatedAt"),
                    rs.getTimestamp("DeletedAt"), rs.getString("imagePath")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }

        req.setAttribute("restaurants", restaurants);
        req.setAttribute("menuItems",   menuItems);
        req.setAttribute("query",       query);
        req.setAttribute("filter",      filter);
        req.setAttribute("sort",        sort);

        RequestDispatcher rd = req.getRequestDispatcher("/search.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}