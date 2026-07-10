package com.food.Servlet;

import java.io.IOException;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ReplaceCartServlet")
public class ReplaceCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Guard: session or pending attributes might be null
        if (session == null
                || session.getAttribute("pendingMenuID") == null
                || session.getAttribute("pendingQuantity") == null
                || session.getAttribute("pendingRestaurantID") == null) {
            // Nothing pending — just go to cart
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        // User confirmed → clear old cart and add the pending item
        cart.clear();

        int menuID       = Integer.parseInt(session.getAttribute("pendingMenuID").toString());
        int quantity     = Integer.parseInt(session.getAttribute("pendingQuantity").toString());
        int restaurantID = Integer.parseInt(session.getAttribute("pendingRestaurantID").toString());

        MenuDAOImpl dao = new MenuDAOImpl();
        Menu menu = dao.getMenu(menuID);

        if (menu != null) {
            CartItem item = new CartItem(
                    menu.getMenuID(),
                    menu.getRestaurantID(),
                    menu.getItemName(),
                    menu.getPrice(),
                    quantity);
            cart.addItem(item);
        }

        session.setAttribute("cart", cart);
        session.setAttribute("RestaurantID", restaurantID);
        session.setAttribute("CurrentRestaurantID", restaurantID);

        // Clean up pending attributes
        session.removeAttribute("pendingMenuID");
        session.removeAttribute("pendingQuantity");
        session.removeAttribute("pendingRestaurantID");

        resp.sendRedirect(req.getContextPath() + "/cart.jsp");
    }
}
