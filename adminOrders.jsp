<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.Model.OrderTable" %>
<%@ page import="com.food.Model.User" %>
<%@ page import="com.food.DAOImpl.OrderTableDAOImpl" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Simple auth check - in production, verify admin role
    // User loggedInUser = (User) session.getAttribute("loggedInUser");
    // if (loggedInUser == null) {
    //     response.sendRedirect(request.getContextPath() + "/login.html");
    //     return;
    // }

    OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
    List<OrderTable> allOrders = orderDAO.getAllOrderTables();
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Orders | FlavorNest</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body { background: #0b0f10; font-family: 'Inter', sans-serif; }
        .status-badge {
            font-size: 12px; font-weight: 600; padding: 6px 12px; border-radius: 20px;
        }
        .status-placed { background: #3b82f6; color: #fff; }
        .status-preparing { background: #f97316; color: #fff; }
        .status-out { background: #eab308; color: #000; }
        .status-delivered { background: #22c55e; color: #fff; }
        .status-cancelled { background: #ef4444; color: #fff; }
    </style>
</head>
<body class="text-white min-h-screen">
    <div class="max-w-7xl mx-auto px-6 py-8">
        <!-- Header -->
        <div class="mb-8">
            <h1 class="text-4xl font-bold mb-2" style="font-family:'Sora',sans-serif;">Admin - Order Management</h1>
            <p class="text-gray-400">Manage all incoming orders and update delivery status</p>
        </div>

        <!-- Success/Error Messages -->
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if (success != null) {
        %>
            <div class="mb-6 bg-green-500/20 border border-green-500 text-green-400 px-4 py-3 rounded-lg">
                Status updated successfully!
            </div>
        <% } if (error != null) { %>
            <div class="mb-6 bg-red-500/20 border border-red-500 text-red-400 px-4 py-3 rounded-lg">
                Error: <%= error %>
            </div>
        <% } %>

        <!-- Orders Table -->
        <div class="bg-white/5 border border-white/10 rounded-2xl overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="bg-white/10 border-b border-white/10">
                        <tr>
                            <th class="px-6 py-4 text-left">Order ID</th>
                            <th class="px-6 py-4 text-left">User ID</th>
                            <th class="px-6 py-4 text-left">Restaurant</th>
                            <th class="px-6 py-4 text-left">Amount</th>
                            <th class="px-6 py-4 text-left">Order Date</th>
                            <th class="px-6 py-4 text-left">Payment</th>
                            <th class="px-6 py-4 text-left">Status</th>
                            <th class="px-6 py-4 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (allOrders != null && !allOrders.isEmpty()) {
                            for (OrderTable order : allOrders) { %>
                        <tr class="border-b border-white/5 hover:bg-white/5 transition">
                            <td class="px-6 py-4 font-semibold">#<%= order.getOrderID() %></td>
                            <td class="px-6 py-4"><%= order.getUserID() %></td>
                            <td class="px-6 py-4">Restaurant <%= order.getRestaurantID() %></td>
                            <td class="px-6 py-4 text-green-400 font-bold">₹ <%= order.getTotalAmount() %></td>
                            <td class="px-6 py-4 text-gray-400"><%= order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "—" %></td>
                            <td class="px-6 py-4"><%= order.getPaymentMethod() %></td>
                            <td class="px-6 py-4">
                                <span class="status-badge status-<%= order.getStatus().toLowerCase().replace(" ", "-") %>">
                                    <%= order.getStatus() %>
                                </span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex gap-2 justify-center">
                                    <form action="adminOrderUpdate" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                        <input type="hidden" name="status" value="Preparing">
                                        <button type="submit" class="px-3 py-1 bg-orange-600 hover:bg-orange-700 rounded text-xs transition">Preparing</button>
                                    </form>
                                    <form action="adminOrderUpdate" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                        <input type="hidden" name="status" value="Out for Delivery">
                                        <button type="submit" class="px-3 py-1 bg-yellow-600 hover:bg-yellow-700 rounded text-xs transition">Out</button>
                                    </form>
                                    <form action="adminOrderUpdate" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                        <input type="hidden" name="status" value="Delivered">
                                        <button type="submit" class="px-3 py-1 bg-green-600 hover:bg-green-700 rounded text-xs transition">Deliver</button>
                                    </form>
                                    <form action="adminOrderUpdate" method="post" style="display:inline;">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderID() %>">
                                        <input type="hidden" name="status" value="Cancelled">
                                        <button type="submit" class="px-3 py-1 bg-red-600 hover:bg-red-700 rounded text-xs transition">Cancel</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="8" class="px-6 py-8 text-center text-gray-400">No orders found</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Footer -->
        <div class="mt-8 text-center text-gray-600 text-sm">
            <p>Total Orders: <%= allOrders != null ? allOrders.size() : 0 %></p>
        </div>
    </div>
</body>
</html>
