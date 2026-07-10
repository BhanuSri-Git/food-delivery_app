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

@WebServlet("/cartServlet")
public class cartServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = req.getParameter("action");

        if ("add".equals(action)) {

            int newRestaurantID =
                    Integer.parseInt(req.getParameter("RestaurantID"));

            Integer oldRestaurantID =
                    (Integer) session.getAttribute("RestaurantID");

            // Uncomment this if you want to clear the cart
            // when adding items from another restaurant.
            
            if (oldRestaurantID != null &&
                    oldRestaurantID != newRestaurantID) {

                cart.clear();
            }
            

            session.setAttribute("RestaurantID", newRestaurantID);

            addItemToCart(req, cart, session);

            session.setAttribute("cart", cart);

            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        else if ("update".equals(action)) {

            updateItemToCart(req, cart);

            session.setAttribute("cart", cart);

            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        else if ("delete".equals(action)) {

            deleteItemToCart(req, cart);

            session.setAttribute("cart", cart);

            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        else if ("clear".equals(action)) {

            cart.clear();

            session.removeAttribute("RestaurantID");
            session.removeAttribute("CurrentRestaurantID");

            session.setAttribute("cart", cart);

            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }
    }

    // ====================== ADD ======================

    private void addItemToCart(HttpServletRequest req,
                               Cart cart,
                               HttpSession session) {

        int menuID = Integer.parseInt(req.getParameter("MenuID"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        MenuDAOImpl menuDAO = new MenuDAOImpl();

        Menu menu = menuDAO.getMenu(menuID);
       

        System.out.println("Menu from DB : " + menu);

        if (menu != null) {

            CartItem cartItem = new CartItem(
                    menu.getMenuID(),
                    menu.getRestaurantID(),
                    menu.getItemName(),
                    menu.getPrice(),
                    quantity);

            cart.addItem(cartItem);

            session.setAttribute("RestaurantID",
                    menu.getRestaurantID());

            session.setAttribute("CurrentRestaurantID",
                    menu.getRestaurantID());
        }
    }

    // ====================== UPDATE ======================

    private void updateItemToCart(HttpServletRequest req,
                                  Cart cart) {

        int menuID = Integer.parseInt(req.getParameter("MenuID"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        cart.updateItem(menuID, quantity);
    }

    // ====================== DELETE ======================

    private void deleteItemToCart(HttpServletRequest req,
                                  Cart cart) {

        int menuID = Integer.parseInt(req.getParameter("MenuID"));

        cart.removeItem(menuID);

        if (cart.isEmpty()) {

            HttpSession session = req.getSession();

            session.removeAttribute("RestaurantID");
            session.removeAttribute("CurrentRestaurantID");
        }
    }
}