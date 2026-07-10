package com.food.Servlet;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.OfferDAOImpl;
import com.food.Model.Offer;
import com.food.Model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/offers")
public class OffersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        OfferDAOImpl dao = new OfferDAOImpl();
        List<Offer> offers = dao.getAllActiveOffers();
        req.setAttribute("offers", offers);

        RequestDispatcher rd = req.getRequestDispatcher("/offers.jsp");
        rd.forward(req, resp);
    }
}