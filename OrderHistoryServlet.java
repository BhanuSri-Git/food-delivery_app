package com.food.Servlet;
import java.io.IOException;
import java.util.List;
import com.food.DAOImpl.OrderTableDAOImpl;
import com.food.Model.OrderTable;
import com.food.Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // Auth guard
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("loggedInUser");
        OrderTableDAOImpl orderTableDAO = new OrderTableDAOImpl();
        List<OrderTable> orders = orderTableDAO.getOrdersByUserID(user.getUserId());
        req.setAttribute("orders", orders);
        RequestDispatcher rd = req.getRequestDispatcher("orderHistory.jsp");
        rd.forward(req, resp);
    }
}