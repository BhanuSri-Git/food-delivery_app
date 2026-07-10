package com.food.Servlet;

import java.io.IOException;

import com.food.DAOImpl.OrderTableDAOImpl;
import com.food.Model.OrderTable;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminOrderUpdate")
public class AdminOrderUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdStr = req.getParameter("orderId");
        String status = req.getParameter("status");

        if (orderIdStr == null || status == null || orderIdStr.trim().isEmpty() || status.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/adminOrders.jsp?error=invalid_params");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/adminOrders.jsp?error=invalid_order_id");
            return;
        }

        OrderTableDAOImpl dao = new OrderTableDAOImpl();
        OrderTable orderTable = dao.getOrderTable(orderId);

        if (orderTable == null) {
            resp.sendRedirect(req.getContextPath() + "/adminOrders.jsp?error=order_not_found");
            return;
        }

        // Update status
        orderTable.setStatus(status.trim());
        dao.updateOrderTable(orderTable);

        resp.sendRedirect(req.getContextPath() + "/adminOrders.jsp?success=status_updated");
    }
}
