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
@WebServlet("/callRegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("Signup servlet called");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email    = req.getParameter("email");
        String address  = req.getParameter("address");
        // FIX: Read role from form instead of hardcoding "Customer"
        String role = req.getParameter("role");
        if (role == null || role.trim().isEmpty()) {
            role = "Customer";  // Safe default
        }
        // Basic input validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/signup.jsp?error=empty");
            return;
        }
        System.out.println("Username: " + username + " | Role: " + role);
        // Check for duplicate username
        UserDAOImpl userDAO = new UserDAOImpl();
        User existing = userDAO.getUserByUsername(username.trim());
        if (existing != null) {
            resp.sendRedirect(req.getContextPath() + "/signup.jsp?error=taken");
            return;
        }
        // Hash password with BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
        User user = new User(username.trim(), hashedPassword, email.trim(),
                             address != null ? address.trim() : "", role.trim());
        int result = userDAO.addUser(user);
        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?registered=true");
        } else {
            resp.sendRedirect(req.getContextPath() + "/signup.jsp?error=failed");
        }
    }
}