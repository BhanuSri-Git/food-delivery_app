<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.food.Model.Menu"%>
<%@ page import="com.food.Model.Restaurant"%>
<%@ page import="com.food.Model.User"%>
<%@ page import="com.food.Model.Cart"%>

<%
// Auth guard
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
Cart cart = (Cart) session.getAttribute("cart");
int cartCount = (cart != null) ? cart.getTotalQuantity() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= restaurant != null ? restaurant.getName() : "Restaurant" %> | FlavorNest</title>

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
    body { background: #101415; font-family: 'Inter', sans-serif; color: #e0e3e5; }

    .glass-card {
        background: rgba(255,255,255,0.04);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255,255,255,0.08);
        transition: all 0.3s ease;
    }
    .glass-card:hover {
        border-color: rgba(255,95,31,0.3);
        transform: translateY(-4px);
    }

    .rating-badge {
        background: rgba(34,197,94,0.15);
        color: #22c55e;
        border: 1px solid rgba(34,197,94,0.3);
    }

    .add-btn {
        background: linear-gradient(135deg, #ff5f1f, #ff8c5a);
        box-shadow: 0 4px 15px rgba(255,95,31,0.25);
        transition: all 0.2s ease;
    }
    .add-btn:hover {
        box-shadow: 0 6px 20px rgba(255,95,31,0.4);
        transform: translateY(-1px);
    }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .menu-card { animation: fadeUp 0.5s ease forwards; opacity: 0; }
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen">

    <!-- Navbar -->
    <header class="sticky top-0 z-50 border-b border-white/5" style="background:rgba(16,20,21,0.85); backdrop-filter:blur(20px);">
        <nav class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
            <div class="flex items-center gap-4">
                <a href="callRestaurantServlet" class="text-orange-400 hover:text-orange-300 transition-colors text-sm flex items-center gap-1">
                    <span>&#8592;</span> Back
                </a>
                <span class="text-white font-bold text-lg" style="font-family:'Sora',sans-serif;">FlavorNest</span>
            </div>
            <div class="flex items-center gap-6">
                <a href="orderHistory" class="text-gray-300 hover:text-white text-sm transition-colors">My Orders</a>
                <a href="cart.jsp" class="relative text-gray-300 hover:text-white transition-colors">
                    <span class="text-xl">&#128722;</span>
                    <% if (cartCount > 0) { %>
                    <span class="absolute -top-1.5 -right-2 bg-orange-500 text-white text-[10px] font-bold w-4 h-4 rounded-full flex items-center justify-center"><%= cartCount %></span>
                    <% } %>
                </a>
                <a href="logoutServlet" class="text-gray-400 hover:text-red-400 text-sm transition-colors">Logout</a>
            </div>
        </nav>
    </header>

    <!-- Restaurant Hero -->
    <% if (restaurant != null) { %>
    <div class="border-b border-white/5" style="background: linear-gradient(135deg, rgba(255,95,31,0.12), rgba(16,20,21,0));">
        <div class="max-w-6xl mx-auto px-6 py-10">
            <span class="text-orange-500 text-xs font-bold uppercase tracking-widest">Menu</span>
            <h1 class="text-4xl font-bold text-white mt-2 mb-3" style="font-family:'Sora',sans-serif;">
                <%= restaurant.getName() %>
            </h1>
            <div class="flex flex-wrap items-center gap-3 text-gray-400 text-sm">
                <span><%= restaurant.getCuisineType() %></span>
                <span class="text-gray-600">&bull;</span>
                <span class="flex items-center gap-1">&#9201; <%= restaurant.getDeliveryTime() %> mins</span>
                <span class="text-gray-600">&bull;</span>
                <span class="rating-badge text-xs font-bold px-3 py-1 rounded-full flex items-center gap-1">
                    &#11088; <%= restaurant.getRating() %>
                </span>
            </div>
        </div>
    </div>
    <% } %>

    <!-- Menu Grid -->
    <main class="max-w-6xl mx-auto px-6 py-10">

        <%
        List<Menu> allMenusByRestaurant = (List<Menu>) request.getAttribute("allMenusByRestaurant");
        %>

        <% if (allMenusByRestaurant == null || allMenusByRestaurant.isEmpty()) { %>

        <div class="glass-card rounded-2xl p-16 text-center">
            <div class="text-6xl mb-6">&#127860;</div>
            <h2 class="text-xl font-semibold text-white mb-2" style="font-family:'Sora',sans-serif;">No items available</h2>
            <p class="text-gray-400">This restaurant hasn't added any menu items yet.</p>
        </div>

        <% } else { %>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

            <% int delay = 0;
               for (Menu menu : allMenusByRestaurant) {
                delay += 60;
            %>

            <div class="menu-card glass-card rounded-2xl overflow-hidden" style="animation-delay:<%= delay %>ms">

                <img src="<%= menu.getImagePath() %>" alt="<%= menu.getItemName() %>"
                     class="w-full h-52 object-cover">

                <div class="p-5">
                    <div class="flex items-start justify-between gap-3 mb-2">
                        <h2 class="text-lg font-bold text-white" style="font-family:'Sora',sans-serif;">
                            <%= menu.getItemName() %>
                        </h2>
                        <span class="rating-badge text-xs font-bold px-2.5 py-1 rounded-lg flex-shrink-0 flex items-center gap-1">
                            &#9733; <%= menu.getRating() %>
                        </span>
                    </div>

                    <p class="text-gray-400 text-sm mb-5"><%= menu.getDescription() %></p>

                    <div class="flex items-center justify-between">
                        <span class="text-orange-400 text-2xl font-bold">&#8377;<%= menu.getPrice() %></span>

                        <form action="${pageContext.request.contextPath}/cartServlet" method="post">
                            <input type="hidden" name="MenuID" value="<%= menu.getMenuID() %>">
                            <input type="hidden" name="RestaurantID" value="<%= menu.getRestaurantID() %>">
                            <input type="hidden" name="quantity" value="1">
                            <input type="hidden" name="action" value="add">

                            <button type="submit"
                                class="add-btn text-white font-semibold text-sm py-2.5 px-6 rounded-xl">
                                Add to Cart
                            </button>
                        </form>
                    </div>
                </div>

            </div>

            <% } %>

        </div>

        <% } %>

    </main>

</body>
</html>
