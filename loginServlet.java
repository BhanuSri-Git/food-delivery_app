package com.food.Servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/callloginServlet")
public class loginServlet extends HttpServlet {

    // FIX: Was doGet — password was exposed in the URL. Changed to doPost.
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Basic input validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=empty");
            return;
        }

        UserDAOImpl userDAOImpl = new UserDAOImpl();
        User user = userDAOImpl.getUserByUsername(username.trim());

        if (user != null && BCrypt.checkpw(password, user.getpassword())) {

            // Session fixation protection: invalidate old session, create new one
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

            resp.sendRedirect(req.getContextPath() + "/callRestaurantServlet");

        } else {
            // FIX: Pass error message so login.jsp can show feedback
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=invalid");
        }
    }

    // Support GET for when someone navigates to the login URL directly
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}