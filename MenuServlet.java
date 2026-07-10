package com.food.Servlet;
import java.io.IOException;
import java.util.List;
import com.food.DAOImpl.MenuDAOImpl;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Menu;
import com.food.Model.Restaurant;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Auth guard — redirect to login if not logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        // FIX: Parameter name was "RestaurantId" before — now matches "RestaurantID" sent by restaurant.jsp
        String id = req.getParameter("RestaurantID");
        if (id == null || id.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/callRestaurantServlet");
            return;
        }
        int restaurantID;
        try {
            restaurantID = Integer.parseInt(id.trim());
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/callRestaurantServlet");
            return;
        }
        // Store in session so "Add More Items" button on cart works
        req.getSession().setAttribute("CurrentRestaurantID", restaurantID);
        // Fetch menu items for this restaurant
        MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
        List<Menu> allMenusByRestaurant = menuDAOImpl.getAllMenusByRestaurant(restaurantID);
        req.setAttribute("allMenusByRestaurant", allMenusByRestaurant);
        // Fetch restaurant details for the header
        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
        Restaurant restaurant = restaurantDAOImpl.getRestaurant(restaurantID);
        req.setAttribute("restaurant", restaurant);
        RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
        rd.forward(req, resp);
    }
}