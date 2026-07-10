package com.food.Servlet;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.OrderTableDAOImpl;
import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.OrderTable;
import com.food.Model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

/**
 * ProfileServlet
 * ----------------------------------------------------------------------
 * Shows the logged-in user's own profile only. Session is checked first;
 * if nobody's logged in, straight redirect to login — no profile page is
 * ever rendered without a valid session.
 *
 * Matches your actual com.food.Model.User fields: userId, userName,
 * password, email, address, role, createDate, lastLoginDate.
 * No getUserById() call — your session already holds the full User
 * object from login, so no extra DB round-trip is needed here.
 * ----------------------------------------------------------------------
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Session check — never trust the URL alone.
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Pull the logged-in user straight from session (set at login).
        User user = (User) session.getAttribute("loggedInUser");

        // 3. Fetch this user's own orders only (filtered by user ID).
        OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
        List<OrderTable> orders = orderDAO.getOrdersByUserID(user.getUserId());

        req.setAttribute("orders", orders);
        req.setAttribute("profileUser", user);

        // 4. Forward (not redirect) so /profile stays the URL and the
        //    request attributes survive.
        // FIX: Changed from "/profile.jsp" to "/Profile.jsp" to match actual file name (case-sensitive)
        RequestDispatcher rd = req.getRequestDispatcher("/Profile.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        String action = req.getParameter("action");
        UserDAOImpl userDAO = new UserDAOImpl();

        if ("updateProfile".equals(action)) {
            // Edit Profile modal (email + address) posts here.
            String email = req.getParameter("email");
            String address = req.getParameter("address");
            if (email != null && !email.trim().isEmpty()) user.setEmail(email.trim());
            if (address != null && !address.trim().isEmpty()) user.setAddress(address.trim());

            userDAO.updateUser(user);
            session.setAttribute("loggedInUser", user); // keep session in sync with DB
            resp.sendRedirect(req.getContextPath() + "/profile?success=updated");

        } else if ("changePassword".equals(action)) {
            String currentPw = req.getParameter("currentPassword");
            String newPw = req.getParameter("newPassword");

            if (currentPw != null && newPw != null
                    && BCrypt.checkpw(currentPw, user.getpassword())) {
                String hashed = BCrypt.hashpw(newPw, BCrypt.gensalt(12));
                user.setpassword(hashed);
                userDAO.updateUser(user);
                session.setAttribute("loggedInUser", user);
                resp.sendRedirect(req.getContextPath() + "/profile?success=password");
            } else {
                resp.sendRedirect(req.getContextPath() + "/profile?error=wrongpw");
            }

        } else {
            resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }
}