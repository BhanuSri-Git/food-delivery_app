package com.food.Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.food.DAOImpl.OrderTableDAOImpl;
import com.food.Model.OrderTable;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/orderStatus")
public class OrderStatusSSEServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdParam = req.getParameter("orderId");
        if (orderIdParam == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "orderId required");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "invalid orderId");
            return;
        }

        resp.setContentType("text/event-stream");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-cache");

        PrintWriter out = resp.getWriter();

        OrderTableDAOImpl dao = new OrderTableDAOImpl();
        String lastStatus = "";

        // Simple polling loop — keep connection open and push status when it changes
        try {
            for (int i = 0; i < 300; i++) { // limit to ~15 minutes (300 * 3s)
                OrderTable ot = dao.getOrderTable(orderId);
                String status = (ot != null && ot.getStatus() != null) ? ot.getStatus() : "Unknown";

                if (!status.equals(lastStatus)) {
                    lastStatus = status;
                    String data = "{\"status\":\"" + status + "\"}";
                    out.write("data: " + data + "\n\n");
                    out.flush();
                }

                // If delivered or cancelled, close stream after notifying
                if ("Delivered".equalsIgnoreCase(status) || "Cancelled".equalsIgnoreCase(status)) {
                    break;
                }

                try {
                    Thread.sleep(3000); // 3 seconds
                } catch (InterruptedException e) {
                    break;
                }
                if (out.checkError()) break;
            }
        } finally {
            out.close();
        }
    }
}
