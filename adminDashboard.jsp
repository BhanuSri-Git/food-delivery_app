<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.food.Model.OrderTable" %>
<%@ page import="com.food.DAOImpl.OrderTableDAOImpl" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
    List<OrderTable> allOrders = orderDAO.getAllOrderTables();
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, hh:mm a");
    SimpleDateFormat dateOnly = new SimpleDateFormat("yyyy-MM-dd");
    Date today = new Date();
    String todayStr = dateOnly.format(today);

    // Calculate statistics
    int totalOrdersToday = 0;
    int pendingOrders = 0;
    int preparingOrders = 0;
    int deliveredOrders = 0;
    BigDecimal revenueToday = BigDecimal.ZERO;
    List<OrderTable> recentOrders = new java.util.ArrayList<>();

    for (OrderTable order : allOrders) {
        String orderDateStr = order.getOrderDate() != null ? dateOnly.format(order.getOrderDate()) : "";
        
        if (orderDateStr.equals(todayStr)) {
            totalOrdersToday++;
            if (order.getTotalAmount() != null) {
                revenueToday = revenueToday.add(order.getTotalAmount());
            }
        }

        String status = order.getStatus() != null ? order.getStatus().toLowerCase() : "";
        if (status.contains("placed") || status.isEmpty()) {
            pendingOrders++;
        } else if (status.contains("preparing")) {
            preparingOrders++;
        } else if (status.contains("delivered")) {
            deliveredOrders++;
        }

        // Add to recent if it's from today
        if (orderDateStr.equals(todayStr)) {
            recentOrders.add(order);
        }
    }

    // Keep only the 5 most recent
    if (recentOrders.size() > 5) {
        recentOrders = recentOrders.subList(0, 5);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Dashboard | FlavorNest</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body { background: #0b0f10; font-family: 'Inter', sans-serif; }
        .stat-card { 
            background: linear-gradient(135deg, rgba(255,95,31,0.1) 0%, rgba(255,140,90,0.05) 100%);
            border: 1px solid rgba(255,95,31,0.2);
        }
        .stat-card:hover {
            border-color: rgba(255,95,31,0.4);
            transform: translateY(-2px);
            transition: all 0.3s ease;
        }
        .status-badge {
            font-size: 12px; font-weight: 600; padding: 6px 12px; border-radius: 20px;
        }
        .status-placed { background: #3b82f6; color: #fff; }
        .status-preparing { background: #f97316; color: #fff; }
        .status-delivery { background: #eab308; color: #000; }
        .status-delivered { background: #22c55e; color: #fff; }
    </style>
</head>
<body class="text-white min-h-screen">
    <div class="max-w-7xl mx-auto px-6 py-8">
        <!-- Header -->
        <div class="mb-10">
            <h1 class="text-4xl font-bold mb-2" style="font-family:'Sora',sans-serif;">Restaurant Dashboard</h1>
            <p class="text-gray-400">Real-time order management and business analytics</p>
        </div>

        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <!-- Total Orders Today -->
            <div class="stat-card rounded-2xl p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wide">Orders Today</p>
                        <p class="text-3xl font-bold mt-2"><%= totalOrdersToday %></p>
                    </div>
                    <div class="text-5xl opacity-20">📦</div>
                </div>
                <p class="text-green-400 text-xs mt-3">+<%= totalOrdersToday > 0 ? totalOrdersToday : 0 %> this week</p>
            </div>

            <!-- Revenue Today -->
            <div class="stat-card rounded-2xl p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wide">Revenue Today</p>
                        <p class="text-3xl font-bold mt-2">₹ <%= revenueToday %></p>
                    </div>
                    <div class="text-5xl opacity-20">💰</div>
                </div>
                <p class="text-green-400 text-xs mt-3">Average order value</p>
            </div>

            <!-- Pending Orders -->
            <div class="stat-card rounded-2xl p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wide">Pending</p>
                        <p class="text-3xl font-bold mt-2"><%= pendingOrders %></p>
                    </div>
                    <div class="text-5xl opacity-20">⏳</div>
                </div>
                <p class="text-yellow-400 text-xs mt-3">Awaiting confirmation</p>
            </div>

            <!-- Preparing Orders -->
            <div class="stat-card rounded-2xl p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wide">Preparing</p>
                        <p class="text-3xl font-bold mt-2"><%= preparingOrders %></p>
                    </div>
                    <div class="text-5xl opacity-20">🍳</div>
                </div>
                <p class="text-orange-400 text-xs mt-3">In the kitchen</p>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="mb-8">
            <div class="flex gap-3 flex-wrap">
                <a href="adminOrders.jsp" class="px-4 py-2 bg-orange-600 hover:bg-orange-700 rounded-lg text-sm font-semibold transition">
                    📋 Manage Orders
                </a>
                <a href="#" class="px-4 py-2 bg-white/10 hover:bg-white/15 border border-white/10 rounded-lg text-sm font-semibold transition">
                    📊 View Analytics
                </a>
                <a href="#" class="px-4 py-2 bg-white/10 hover:bg-white/15 border border-white/10 rounded-lg text-sm font-semibold transition">
                    ⚙️ Settings
                </a>
            </div>
        </div>

        <!-- Recent Orders Table -->
        <div class="bg-white/5 border border-white/10 rounded-2xl overflow-hidden">
            <div class="p-6 border-b border-white/10">
                <h2 class="text-lg font-semibold">Today's Orders</h2>
            </div>
            
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="bg-white/5 border-b border-white/10">
                        <tr>
                            <th class="px-6 py-3 text-left">Order ID</th>
                            <th class="px-6 py-3 text-left">Customer</th>
                            <th class="px-6 py-3 text-left">Delivery Address</th>
                            <th class="px-6 py-3 text-left">Amount</th>
                            <th class="px-6 py-3 text-left">Status</th>
                            <th class="px-6 py-3 text-left">Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (recentOrders.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="px-6 py-8 text-center text-gray-400">No orders yet today</td>
                        </tr>
                        <% } else {
                            for (OrderTable order : recentOrders) { %>
                        <tr class="border-b border-white/5 hover:bg-white/5 transition">
                            <td class="px-6 py-4 font-semibold">#FN-<%= order.getOrderID() %></td>
                            <td class="px-6 py-4"><%= order.getFullName() != null ? order.getFullName() : "Customer " + order.getUserID() %></td>
                            <td class="px-6 py-4 text-sm text-gray-400">
                                <% if (order.getAddressLine1() != null) { %>
                                    <%= order.getAddressLine1().substring(0, Math.min(order.getAddressLine1().length(), 30)) %>...
                                <% } else { %>
                                    —
                                <% } %>
                            </td>
                            <td class="px-6 py-4 text-green-400 font-semibold">₹ <%= order.getTotalAmount() %></td>
                            <td class="px-6 py-4">
                                <span class="status-badge status-<%= order.getStatus().toLowerCase().replace(" ", "-") %>">
                                    <%= order.getStatus() %>
                                </span>
                            </td>
                            <td class="px-6 py-4 text-gray-400">
                                <%= order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "—" %>
                            </td>
                        </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- All Orders Summary -->
        <div class="mt-8 bg-white/5 border border-white/10 rounded-2xl p-6">
            <h2 class="text-lg font-semibold mb-4">All Time Statistics</h2>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="text-center">
                    <p class="text-2xl font-bold text-orange-400"><%= allOrders.size() %></p>
                    <p class="text-gray-400 text-sm mt-1">Total Orders</p>
                </div>
                <div class="text-center">
                    <p class="text-2xl font-bold text-green-400"><%= deliveredOrders %></p>
                    <p class="text-gray-400 text-sm mt-1">Delivered</p>
                </div>
                <div class="text-center">
                    <p class="text-2xl font-bold text-yellow-400"><%= preparingOrders %></p>
                    <p class="text-gray-400 text-sm mt-1">Preparing</p>
                </div>
                <div class="text-center">
                    <p class="text-2xl font-bold text-blue-400">
                        <%
                            BigDecimal totalRevenue = BigDecimal.ZERO;
                            for (OrderTable o : allOrders) {
                                if (o.getTotalAmount() != null) {
                                    totalRevenue = totalRevenue.add(o.getTotalAmount());
                                }
                            }
                        %>
                        ₹ <%= totalRevenue %>
                    </p>
                    <p class="text-gray-400 text-sm mt-1">Total Revenue</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Auto-refresh dashboard every 30 seconds
        setTimeout(function() {
            location.reload();
        }, 30000);
    </script>
</body>
</html>
