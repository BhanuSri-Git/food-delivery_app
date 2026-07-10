package com.food.Servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.food.DAOImpl.OrderItemDAOImpl;
import com.food.DAOImpl.OrderTableDAOImpl;
import com.food.Model.Cart;
import com.food.Model.CartItem;
import com.food.Model.OrderItem;
import com.food.Model.OrderTable;
import com.food.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Auth guard
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        // Can't checkout an empty cart
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        User loggedInUser  = (User) session.getAttribute("loggedInUser");
        Integer restaurantID = (Integer) session.getAttribute("RestaurantID");

        if (restaurantID == null) {
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        String paymentMethod = req.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD"; // Cash on delivery as default
        }

        // Capture delivery address from form
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String addressLine1 = req.getParameter("addressLine1");
        String addressLine2 = req.getParameter("addressLine2");
        String city = req.getParameter("city");
        String pincode = req.getParameter("pincode");
        
        // Validate delivery address
        if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            addressLine1 == null || addressLine1.trim().isEmpty() ||
            addressLine2 == null || addressLine2.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            pincode == null || pincode.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/checkout.jsp?error=incomplete_address");
            return;
        }

        // ---- Calculate totals (must match checkout.jsp) ----
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cart.getItems().values()) {
            subtotal = subtotal.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        BigDecimal deliveryFee = new BigDecimal("30.00");  // Fixed delivery fee as in checkout.jsp
        BigDecimal tax         = subtotal.multiply(new BigDecimal("0.05"));  // 5% tax
        BigDecimal discount    = new BigDecimal("5.00");   // Fixed discount
        BigDecimal total       = subtotal.add(deliveryFee).add(tax).subtract(discount);

        // ---- Create OrderTable entry ----
        OrderTable orderTable = new OrderTable(
                loggedInUser.getUserId(),
                restaurantID,
                total,
                "Placed",
                paymentMethod,
                fullName,
                phone,
                addressLine1,
                addressLine2,
                city,
                pincode
        );

        OrderTableDAOImpl orderTableDAO = new OrderTableDAOImpl();
        int newOrderID = orderTableDAO.addOrderTableAndGetID(orderTable);

        // If getGeneratedKeys() failed, try retrieving the last order for this user
        if (newOrderID <= 0) {
            List<OrderTable> userOrders = orderTableDAO.getOrdersByUserID(loggedInUser.getUserId());
            if (userOrders != null && !userOrders.isEmpty()) {
                newOrderID = userOrders.get(0).getOrderID();
                System.out.println("Retrieved last order ID: " + newOrderID);
            }
        }
        
        // If still no valid order ID, database insertion failed
        if (newOrderID <= 0) {
            System.err.println("Failed to create order for user: " + loggedInUser.getUserId());
            resp.sendRedirect(req.getContextPath() + "/checkout.jsp?error=order_failed");
            return;
        }
        
        System.out.println("Order created successfully with ID: " + newOrderID);

        // ---- Create OrderItem entries for each cart item ----
        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
        int itemsAdded = 0;

        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
            CartItem cartItem = entry.getValue();
            BigDecimal itemTotal = cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity()));

            OrderItem orderItem = new OrderItem(
                    newOrderID,
                    cartItem.getMenuID(),
                    cartItem.getQuantity(),
                    itemTotal
            );
            try {
                orderItemDAO.addOrderItem(orderItem);
                itemsAdded++;
                System.out.println("Added OrderItem: MenuID=" + cartItem.getMenuID() + ", Qty=" + cartItem.getQuantity());
            } catch (Exception e) {
                System.err.println("Failed to add OrderItem: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        if (itemsAdded == 0) {
            System.err.println("No order items were added for order: " + newOrderID);
            resp.sendRedirect(req.getContextPath() + "/checkout.jsp?error=items_failed");
            return;
        }
        
        System.out.println("Added " + itemsAdded + " items to order: " + newOrderID);

        // ---- Store order details in session BEFORE clearing cart ----
        // These attributes need to survive the redirect to orderSuccess.jsp
        session.setAttribute("lastOrderID", newOrderID);
        session.setAttribute("lastOrderTotal", total);
        session.setAttribute("lastOrderSubtotal", subtotal);
        session.setAttribute("lastOrderTax", tax);
        session.setAttribute("lastOrderDiscount", discount);
        session.setAttribute("lastOrderPaymentMethod", paymentMethod);
        session.setAttribute("lastRestaurantID", restaurantID);
        
        System.out.println("Session attributes set for order success page");

        // ---- Clear cart AFTER storing order details ----
        cart.clear();
        session.removeAttribute("RestaurantID");
        session.removeAttribute("CurrentRestaurantID");
        session.setAttribute("cart", cart);
        
        System.out.println("Cart cleared, redirecting to orderSuccess.jsp");

        resp.sendRedirect(req.getContextPath() + "/orderSuccess.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // If someone navigates to /checkoutServlet directly via GET, redirect to cart
        resp.sendRedirect(req.getContextPath() + "/cart.jsp");
    }
}