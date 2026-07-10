<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.food.Model.OrderTable, com.food.Model.User"%>
<%@ page import="com.food.Model.Cart"%>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<OrderTable> orders = (List<OrderTable>) request.getAttribute("orders");
    Cart cart = (Cart) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.getTotalQuantity() : 0;
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
<style>
    body { background: #101415; font-family: 'Inter', sans-serif; color: #e0e3e5; }
    .glass-card {
        background: rgba(255,255,255,0.04);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255,255,255,0.08);
        transition: all 0.3s ease;
    }
    .glass-card:hover { border-color: rgba(255,95,31,0.3); transform: translateY(-2px); }
    .status-placed    { background: rgba(251,191,36,0.15); color: #fbbf24; border: 1px solid rgba(251,191,36,0.3); }
    .status-preparing { background: rgba(255,95,31,0.15); color: #ff5f1f; border: 1px solid rgba(255,95,31,0.3); }
    .status-delivered { background: rgba(34,197,94,0.15); color: #22c55e; border: 1px solid rgba(34,197,94,0.3); }
    .status-cancelled { background: rgba(239,68,68,0.15); color: #ef4444; border: 1px solid rgba(239,68,68,0.3); }
    @keyframes fadeUp { from{opacity:0;transform:translateY(20px)} to{opacity:1;transform:translateY(0)} }
    .order-card { animation: fadeUp 0.5s ease forwards; opacity: 0; }
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen">

    <!-- Navbar -->
    <header class="sticky top-0 z-50 border-b border-white/5" style="background:rgba(16,20,21,0.8); backdrop-filter:blur(20px);">
        <nav class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
            <div class="flex items-center gap-4">
                <a href="callRestaurantServlet" class="text-orange-400 hover:text-orange-300 transition-colors text-sm flex items-center gap-1">
                    <span class="material-symbols-outlined text-base">arrow_back</span> Restaurants
                </a>
                <span class="text-white font-bold text-lg" style="font-family:'Sora',sans-serif;">FlavorNest</span>
            </div>
            <div class="flex items-center gap-5">
                <a href="cart.jsp" class="relative text-gray-300 hover:text-white transition-colors">
                    <span class="material-symbols-outlined">shopping_cart</span>
                    <% if (cartCount > 0) { %>
                    <span class="absolute -top-1 -right-1 bg-orange-500 text-white text-[9px] font-bold w-4 h-4 rounded-full flex items-center justify-center"><%= cartCount %></span>
                    <% } %>
                </a>
                <span class="text-gray-500 text-sm">Hello, <%= loggedInUser.getUserName() %></span>
                <a href="logoutServlet" class="text-gray-400 hover:text-red-400 transition-colors text-sm">Logout</a>
            </div>
        </nav>
    </header>

    <main class="max-w-4xl mx-auto px-6 py-10">

        <!-- Page Header -->
        <div class="mb-10">
            <span class="text-orange-500 text-xs font-bold uppercase tracking-widest">Account</span>
            <h1 class="text-3xl font-bold text-white mt-1" style="font-family:'Sora',sans-serif;">My Orders</h1>
            <p class="text-gray-500 mt-2">Your complete order history with FlavorNest</p>
        </div>

        <!-- Orders List -->
        <% if (orders == null || orders.isEmpty()) { %>

        <!-- Empty State -->
        <div class="glass-card rounded-2xl p-16 text-center">
            <div class="text-7xl mb-6">&#127869;</div>
            <h2 class="text-2xl font-semibold text-white mb-3" style="font-family:'Sora',sans-serif;">No orders yet</h2>
            <p class="text-gray-400 mb-8">Looks like you haven't placed any orders. Let's fix that!</p>
            <a href="callRestaurantServlet"
               class="inline-flex items-center gap-2 text-white font-semibold py-3 px-8 rounded-xl"
               style="background:linear-gradient(135deg,#ff5f1f,#ff8c5a); box-shadow:0 8px 25px rgba(255,95,31,0.3);">
                <span class="material-symbols-outlined text-sm">restaurant</span>
                Explore Restaurants
            </a>
        </div>

        <% } else { %>

        <div class="space-y-5">
        <% int delay = 0; for (OrderTable order : orders) {
            String statusClass = "status-placed";
            String statusIcon  = "\u23F3";
            String status = order.getStatus() != null ? order.getStatus() : "Placed";
            if ("Preparing".equalsIgnoreCase(status)) { statusClass = "status-preparing"; statusIcon = "\uD83C\uDF73"; }
            else if ("Delivered".equalsIgnoreCase(status)) { statusClass = "status-delivered"; statusIcon = "\u2705"; }
            else if ("Cancelled".equalsIgnoreCase(status)) { statusClass = "status-cancelled"; statusIcon = "\u274C"; }
            String orderDateStr = order.getOrderDate() != null ? order.getOrderDate().toString().substring(0, 16) : "\u2014";
            delay += 100;
        %>

            <div class="order-card glass-card rounded-2xl overflow-hidden" style="animation-delay:<%= delay %>ms">

                <!-- Card Header -->
                <div class="flex items-center justify-between px-6 py-4 border-b border-white/5">
                    <div class="flex items-center gap-4">
                        <div class="w-11 h-11 rounded-xl flex items-center justify-center text-xl"
                             style="background:rgba(255,95,31,0.15);">
                            &#129534;
                        </div>
                        <div>
                            <p class="text-white font-bold">Order #FN-<%= order.getOrderID() %></p>
                            <p class="text-gray-500 text-xs mt-0.5"><%= orderDateStr %></p>
                        </div>
                    </div>
                    <span class="<%= statusClass %> text-xs font-bold px-3 py-1.5 rounded-full">
                        <%= statusIcon %> <%= status %>
                    </span>
                </div>

                <!-- Card Body -->
                <div class="px-6 py-4 space-y-4">

                    <!-- Amount, Payment and Actions -->
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                        <div class="flex gap-8">
                            <div>
                                <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Total Amount</p>
                                <p class="text-orange-400 text-xl font-bold">
                                    &#8377; <%= order.getTotalAmount() != null ? order.getTotalAmount() : "\u2014" %>
                                </p>
                            </div>
                            <div>
                                <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Payment</p>
                                <p class="text-white font-medium text-sm">
                                    <%= order.getPaymentMethod() != null ? order.getPaymentMethod() : "\u2014" %>
                                </p>
                            </div>
                        </div>

                        <!-- Reorder / Details Buttons -->
                        <div class="flex gap-2">
                            <a href="orderDetails.jsp?orderId=<%= order.getOrderID() %>"
                               class="inline-flex items-center gap-2 border border-blue-500/40 text-blue-400 hover:bg-blue-500/10 font-semibold text-sm py-2.5 px-5 rounded-xl transition-all">
                                <span class="material-symbols-outlined text-sm">info</span>
                                View Details
                            </a>
                            <a href="MenuServlet?RestaurantID=<%= order.getRestaurantID() %>"
                               class="inline-flex items-center gap-2 border border-orange-500/40 text-orange-400 hover:bg-orange-500/10 font-semibold text-sm py-2.5 px-5 rounded-xl transition-all">
                                <span class="material-symbols-outlined text-sm">replay</span>
                                Reorder
                            </a>
                        </div>
                    </div>

                    <!-- Delivery Address (if available) -->
                    <% if (order.getFullName() != null && !order.getFullName().isEmpty()) { %>
                    <div class="border-t border-white/5 pt-4">
                        <div class="flex gap-3">
                            <span class="material-symbols-outlined text-orange-400 flex-shrink-0">location_on</span>
                            <div class="flex-grow text-sm">
                                <p class="text-gray-500 text-xs uppercase tracking-wider mb-1">Delivery Address</p>
                                <p class="text-white font-medium"><%= order.getFullName() %></p>
                                <p class="text-gray-400 text-xs mt-0.5">
                                    <%= order.getAddressLine1() != null ? order.getAddressLine1() : "" %>
                                    <% if (order.getAddressLine2() != null && !order.getAddressLine2().isEmpty()) { %>
                                        , <%= order.getAddressLine2() %>
                                    <% } %>
                                </p>
                                <p class="text-gray-400 text-xs">
                                    <%= order.getCity() != null ? order.getCity() : "" %> - <%= order.getPincode() != null ? order.getPincode() : "" %>
                                </p>
                                <% if (order.getPhone() != null && !order.getPhone().isEmpty()) { %>
                                <p class="text-gray-500 text-xs mt-1">&#128222; <%= order.getPhone() %></p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } %>

                </div>

                <!-- Progress Bar for active orders -->
                <% if ("Placed".equalsIgnoreCase(status) || "Preparing".equalsIgnoreCase(status)) { %>
                <div class="px-6 pb-4">
                    <div class="flex items-center justify-between text-[10px] text-gray-500 mb-1.5">
                        <span class="text-green-400 font-medium">&#10003; Placed</span>
                        <span class="<%= "Preparing".equalsIgnoreCase(status) ? "text-orange-400 font-medium" : "" %>">&#127871; Preparing</span>
                        <span>&#128652; On the way</span>
                        <span>&#127968; Delivered</span>
                    </div>
                    <div class="w-full bg-white/5 rounded-full h-1.5">
                        <div class="h-1.5 rounded-full"
                             style="width:<%= "Preparing".equalsIgnoreCase(status) ? "50%" : "25%" %>; background:linear-gradient(90deg,#22c55e,#ff5f1f);">
                        </div>
                    </div>
                </div>
                <% } %>

            </div>

        <% } %>
        </div>

        <!-- Summary footer -->
        <div class="mt-8 glass-card rounded-xl px-6 py-4 flex items-center justify-between">
            <span class="text-gray-400 text-sm">Total orders placed: <span class="text-white font-bold"><%= orders.size() %></span></span>
            <a href="callRestaurantServlet"
               class="text-orange-400 hover:text-orange-300 text-sm font-medium transition-colors flex items-center gap-1">
                Order more <span class="material-symbols-outlined text-sm">arrow_forward</span>
            </a>
        </div>

        <% } %>

    </main>

</body>
</html>
