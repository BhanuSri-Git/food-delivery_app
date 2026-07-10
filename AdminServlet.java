package com.food.Servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

import com.food.DAOImpl.*;
import com.food.Model.*;
import com.tap.utility.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    // ── Auth helper ──────────────────────────────────────────────
    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession s = req.getSession(false);
        if (s == null) { resp.sendRedirect(req.getContextPath() + "/login.jsp"); return false; }
        User u = (User) s.getAttribute("loggedInUser");
        if (u == null || !"Admin".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/callRestaurantServlet"); return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req, resp)) return;

        String path = req.getPathInfo();
        if (path == null) path = "/dashboard";

        switch (path) {

            case "/dashboard": {
                // ---- Aggregate stats ----
                int totalUsers = 0, totalRestaurants = 0, totalMenus = 0,
                    totalOrders = 0, pending = 0, completed = 0;
                BigDecimal revenue = BigDecimal.ZERO;

                try (Connection con = DBConnection.getConnection()) {
                    totalUsers       = scalar(con, "SELECT COUNT(*) FROM user");
                    totalRestaurants = scalar(con, "SELECT COUNT(*) FROM restaurant");
                    totalMenus       = scalar(con, "SELECT COUNT(*) FROM menu WHERE DeletedAt IS NULL");
                    totalOrders      = scalar(con, "SELECT COUNT(*) FROM ordertable");
                    pending          = scalar(con, "SELECT COUNT(*) FROM ordertable WHERE Status IN('Placed','Preparing')");
                    completed        = scalar(con, "SELECT COUNT(*) FROM ordertable WHERE Status='Delivered'");
                    revenue          = scalarDecimal(con, "SELECT COALESCE(SUM(TotalAmount),0) FROM ordertable WHERE Status='Delivered'");
                } catch (SQLException e) { e.printStackTrace(); }

                req.setAttribute("totalUsers", totalUsers);
                req.setAttribute("totalRestaurants", totalRestaurants);
                req.setAttribute("totalMenus", totalMenus);
                req.setAttribute("totalOrders", totalOrders);
                req.setAttribute("pending", pending);
                req.setAttribute("completed", completed);
                req.setAttribute("revenue", revenue);
                forward(req, resp, "/WEB-INF/admin/dashboard.jsp");
                break;
            }

            case "/restaurants": {
                RestaurantDAOImpl dao = new RestaurantDAOImpl();
                List<Restaurant> list = dao.getAllRestaurants();
                // For admin, include inactive too
                List<Restaurant> all = new ArrayList2<>(list);
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement("SELECT * FROM restaurant WHERE IsActive=FALSE");
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) all.add(new Restaurant(
                        rs.getInt("RestaurantID"), rs.getString("Name"),
                        rs.getString("CuisineType"), rs.getInt("DeliveryTime"),
                        rs.getString("Address"), rs.getInt("AdminUserID"),
                        rs.getBigDecimal("Rating"), rs.getBoolean("IsActive"),
                        rs.getString("imagePath")));
                } catch (SQLException e) { e.printStackTrace(); }
                req.setAttribute("restaurants", all);
                forward(req, resp, "/WEB-INF/admin/manageRestaurants.jsp");
                break;
            }

            case "/menus": {
                MenuDAOImpl dao = new MenuDAOImpl();
                req.setAttribute("menus", dao.getAllMenus());
                RestaurantDAOImpl rdao = new RestaurantDAOImpl();
                req.setAttribute("restaurants", rdao.getAllRestaurants());
                forward(req, resp, "/WEB-INF/admin/manageMenu.jsp");
                break;
            }

            case "/orders": {
                OrderTableDAOImpl dao = new OrderTableDAOImpl();
                req.setAttribute("orders", dao.getAllOrderTables());
                forward(req, resp, "/WEB-INF/admin/manageOrders.jsp");
                break;
            }

            case "/users": {
                UserDAOImpl dao = new UserDAOImpl();
                req.setAttribute("users", dao.getAllUsers());
                forward(req, resp, "/WEB-INF/admin/manageUsers.jsp");
                break;
            }

            case "/offers": {
                OfferDAOImpl dao = new OfferDAOImpl();
                req.setAttribute("offers", dao.getAllOffers());
                forward(req, resp, "/WEB-INF/admin/manageOffers.jsp");
                break;
            }

            default:
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!isAdmin(req, resp)) return;

        String path   = req.getPathInfo();
        String action = req.getParameter("action");
        if (path == null) path = "";

        // ════ RESTAURANT CRUD ════
        if (path.startsWith("/restaurants")) {
            RestaurantDAOImpl dao = new RestaurantDAOImpl();
            if ("add".equals(action)) {
                Restaurant r = new Restaurant(
                    req.getParameter("name"),
                    req.getParameter("cuisineType"),
                    intP(req, "deliveryTime", 30),
                    req.getParameter("address"),
                    intP(req, "adminUserID", 1),
                    new BigDecimal(req.getParameter("rating") == null ? "4.0" : req.getParameter("rating")),
                    true,
                    req.getParameter("imagePath")
                );
                dao.addRestaurant(r);
            } else if ("edit".equals(action)) {
                Restaurant r = dao.getRestaurant(intP(req,"id",0));
                if (r != null) {
                    r.setName(req.getParameter("name"));
                    r.setCuisineType(req.getParameter("cuisineType"));
                    r.setDeliveryTime(intP(req,"deliveryTime",30));
                    r.setAddress(req.getParameter("address"));
                    r.setRating(new BigDecimal(req.getParameter("rating") == null ? "4.0" : req.getParameter("rating")));
                    String imgP = req.getParameter("imagePath");
                    if (imgP != null && !imgP.isBlank()) r.setImagePath(imgP);
                    dao.updateRestaurant(r);
                }
            } else if ("delete".equals(action)) {
                dao.deleteRestaurant(intP(req,"id",0));
            } else if ("toggle".equals(action)) {
                int id = intP(req,"id",0);
                Restaurant r = dao.getRestaurant(id);
                if (r != null) { r.setIsActive(!r.getIsActive()); dao.updateRestaurant(r); }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/restaurants");

        // ════ MENU CRUD ════
        } else if (path.startsWith("/menus")) {
            MenuDAOImpl dao = new MenuDAOImpl();
            if ("add".equals(action)) {
                Menu m = new Menu(
                    intP(req,"restaurantID",0),
                    req.getParameter("itemName"),
                    req.getParameter("description"),
                    new BigDecimal(req.getParameter("price") == null ? "0" : req.getParameter("price")),
                    true,
                    req.getParameter("category"),
                    Double.parseDouble(req.getParameter("rating") == null ? "4.0" : req.getParameter("rating")),
                    new Timestamp(System.currentTimeMillis()),
                    new Timestamp(System.currentTimeMillis()),
                    null,
                    req.getParameter("imagePath")
                );
                dao.addMenu(m);
            } else if ("edit".equals(action)) {
                Menu m = dao.getMenu(intP(req,"menuID",0));
                if (m != null) {
                    m.setItemName(req.getParameter("itemName"));
                    m.setDescription(req.getParameter("description"));
                    m.setPrice(new BigDecimal(req.getParameter("price") == null ? "0" : req.getParameter("price")));
                    m.setCategory(req.getParameter("category"));
                    m.setRating(Double.parseDouble(req.getParameter("rating") == null ? "4.0" : req.getParameter("rating")));
                    String imgP = req.getParameter("imagePath");
                    if (imgP != null && !imgP.isBlank()) m.setImagePath(imgP);
                    dao.updateMenu(m);
                }
            } else if ("delete".equals(action)) {
                dao.deleteMenu(intP(req,"menuID",0));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/menus");

        // ════ ORDER STATUS ════
        } else if (path.startsWith("/orders")) {
            if ("updateStatus".equals(action)) {
                int orderId = intP(req,"orderId",0);
                String status = req.getParameter("status");
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement("UPDATE ordertable SET Status=? WHERE OrderID=?")) {
                    ps.setString(1, status); ps.setInt(2, orderId); ps.executeUpdate();
                } catch (SQLException e) { e.printStackTrace(); }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/orders");

        // ════ USER MANAGEMENT ════
        } else if (path.startsWith("/users")) {
            UserDAOImpl dao = new UserDAOImpl();
            if ("delete".equals(action)) {
                dao.deleteUser(intP(req,"userId",0));
            } else if ("block".equals(action)) {
                // Toggle role to 'Blocked'/'Customer'
                User u = dao.getUser(intP(req,"userId",0));
                if (u != null) {
                    u.setRole("Blocked".equals(u.getRole()) ? "Customer" : "Blocked");
                    dao.updateUser(u);
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");

        // ════ OFFERS CRUD ════
        } else if (path.startsWith("/offers")) {
            OfferDAOImpl dao = new OfferDAOImpl();
            if ("add".equals(action)) {
                Offer o = new Offer(
                    req.getParameter("title"),
                    req.getParameter("description"),
                    req.getParameter("couponCode"),
                    intP(req,"discountPercent",0),
                    req.getParameter("offerType"),
                    true,
                    null,
                    req.getParameter("imagePath")
                );
                dao.addOffer(o);
            } else if ("delete".equals(action)) {
                dao.deleteOffer(intP(req,"offerId",0));
            } else if ("toggle".equals(action)) {
                Offer o = dao.getOffer(intP(req,"offerId",0));
                if (o != null) dao.toggleActive(o.getOfferID(), !o.getIsActive());
            }
            resp.sendRedirect(req.getContextPath() + "/admin/offers");

        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }

    // ── Helpers ──────────────────────────────────────────────────
    private void forward(HttpServletRequest req, HttpServletResponse resp, String jsp)
            throws ServletException, IOException {
        req.getRequestDispatcher(jsp).forward(req, resp);
    }

    private int scalar(Connection con, String sql) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private BigDecimal scalarDecimal(Connection con, String sql) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getBigDecimal(1) : BigDecimal.ZERO;
        }
    }

    private int intP(HttpServletRequest req, String name, int def) {
        try { return Integer.parseInt(req.getParameter(name)); }
        catch (Exception e) { return def; }
    }

    // Tiny helper because java.util.ArrayList already exists, just aliasing
    private static class ArrayList2<T> extends java.util.ArrayList<T> {
        public ArrayList2(java.util.Collection<? extends T> c) { super(c); }
    }
}