package com.food.Servlet;
import java.io.IOException;
import java.util.List;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.Model.Restaurant;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/callRestaurantServlet")
public class RestaurantServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Auth guard — redirect to login if not logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
        List<Restaurant> allrestaurants = restaurantDAOImpl.getAllRestaurants();
        req.setAttribute("allrestaurants", allrestaurants);
        RequestDispatcher rd = req.getRequestDispatcher("restaurant.jsp");
        rd.forward(req, resp);
    }
}