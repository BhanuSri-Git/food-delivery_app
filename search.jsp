<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.food.Model.Restaurant, com.food.Model.Menu, com.food.Model.Cart, com.food.Model.User"%>
<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
List<Menu> menuItems = (List<Menu>) request.getAttribute("menuItems");
String query  = (String) request.getAttribute("query");  if (query  == null) query  = "";
String filter = (String) request.getAttribute("filter");  if (filter == null) filter = "";
String sort   = (String) request.getAttribute("sort");    if (sort   == null) sort   = "";
Cart cart = (Cart) session.getAttribute("cart");
int cartCount = cart != null ? cart.getTotalQuantity() : 0;
int totalResults = (restaurants != null ? restaurants.size() : 0) + (menuItems != null ? menuItems.size() : 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Search: <%=query%> | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
<style>
body{background:#101415;color:#e0e3e5;font-family:'Inter',sans-serif}
.glass{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);transition:all .3s}
.glass:hover{border-color:rgba(255,107,53,.4);transform:translateY(-3px)}
.pill{display:inline-flex;align-items:center;gap:4px;padding:6px 16px;border-radius:999px;font-size:12px;font-weight:600;cursor:pointer;transition:all .2s;border:1px solid rgba(255,255,255,.1);color:#e3bfb3;background:rgba(255,255,255,.04)}
.pill.active,.pill:hover{background:#ff6b35;color:#fff;border-color:#ff6b35}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen">
<!-- Navbar -->
<header class="sticky top-0 z-50 border-b border-white/5" style="background:rgba(16,20,21,.9);backdrop-filter:blur(20px)">
  <nav class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between gap-4">
    <a href="callRestaurantServlet" class="text-orange-400 font-bold text-lg" style="font-family:'Sora',sans-serif">FlavorNest</a>
    <form action="search" method="get" class="flex-1 max-w-xl relative">
      <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 text-xl">search</span>
      <input name="q" value="<%=query%>" type="text" placeholder="Search restaurants, dishes, cuisines..."
        class="w-full bg-white/5 border border-white/10 rounded-full py-2.5 pl-12 pr-5 text-white text-sm outline-none focus:border-orange-500 transition-all">
    </form>
    <div class="flex items-center gap-4">
      <a href="cart.jsp" class="relative text-gray-300"><span class="material-symbols-outlined">shopping_cart</span>
        <%if(cartCount>0){%><span class="absolute -top-1 -right-1 bg-orange-500 text-white text-[9px] w-4 h-4 rounded-full flex items-center justify-center font-bold"><%=cartCount%></span><%}%>
      </a>
      <a href="logoutServlet" class="text-red-400 text-sm">Logout</a>
    </div>
  </nav>
</header>

<main class="max-w-6xl mx-auto px-6 py-8">
  <!-- Filter Bar -->
  <div class="flex flex-wrap gap-3 mb-8">
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>" class="pill <%="".equals(filter)?"active":""%>">All</a>
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>&filter=veg" class="pill <%="veg".equals(filter)?"active":""%>">🥦 Veg</a>
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>&filter=rating" class="pill <%="rating".equals(filter)?"active":""%>">⭐ Top Rated</a>
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>&filter=fast" class="pill <%="fast".equals(filter)?"active":""%>">⚡ Fast Delivery</a>
    <span class="w-px h-6 bg-white/10 self-center mx-1"></span>
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>&sort=price_asc" class="pill <%="price_asc".equals(sort)?"active":""%>">Price ↑</a>
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>&sort=price_desc" class="pill <%="price_desc".equals(sort)?"active":""%>">Price ↓</a>
    <a href="search?q=<%=java.net.URLEncoder.encode(query,"UTF-8")%>&sort=rating" class="pill <%="rating".equals(sort)?"active":""%>">Rating ↓</a>
  </div>

  <h2 class="text-white font-semibold text-lg mb-1">
    <% if (!query.isEmpty()) { %>"<%=query%>"<% } else { %>All Results<% } %>
  </h2>
  <p class="text-gray-500 text-sm mb-8"><%=totalResults%> result<%=totalResults!=1?"s":""%> found</p>

  <!-- Restaurants Section -->
  <% if (restaurants != null && !restaurants.isEmpty()) { %>
  <h3 class="text-orange-400 font-bold text-sm uppercase tracking-widest mb-4">Restaurants</h3>
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5 mb-10">
    <% for (Restaurant r : restaurants) { %>
    <a href="MenuServlet?RestaurantID=<%=r.getRestaurantID()%>" class="glass rounded-2xl overflow-hidden block">
      <img src="<%=r.getImagePath()!=null?r.getImagePath():"https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&q=70"%>"
           class="w-full h-44 object-cover" alt="<%=r.getName()%>">
      <div class="p-4">
        <div class="flex justify-between items-start">
          <h4 class="text-white font-semibold truncate pr-2"><%=r.getName()%></h4>
          <span class="flex-shrink-0 bg-green-600 text-white text-[10px] font-bold px-2 py-0.5 rounded"><%=r.getRating()%> ★</span>
        </div>
        <p class="text-gray-400 text-xs mt-1 truncate"><%=r.getCuisineType()%></p>
        <p class="text-gray-500 text-xs truncate"><%=r.getAddress()%></p>
        <div class="flex justify-between items-center mt-3 pt-3 border-t border-white/5">
          <span class="text-gray-400 text-xs flex items-center gap-1"><span class="material-symbols-outlined text-sm">schedule</span> <%=r.getDeliveryTime()%> min</span>
          <span class="text-orange-400 text-xs font-semibold">View Menu →</span>
        </div>
      </div>
    </a>
    <% } %>
  </div>
  <% } %>

  <!-- Menu Items Section -->
  <% if (menuItems != null && !menuItems.isEmpty()) { %>
  <h3 class="text-orange-400 font-bold text-sm uppercase tracking-widest mb-4">Dishes</h3>
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
    <% for (Menu m : menuItems) { %>
    <div class="glass rounded-2xl overflow-hidden">
      <img src="<%=m.getImagePath()!=null?m.getImagePath():"https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&q=70"%>"
           class="w-full h-40 object-cover" alt="<%=m.getItemName()%>">
      <div class="p-4">
        <div class="flex justify-between items-start">
          <h4 class="text-white font-semibold truncate pr-2"><%=m.getItemName()%></h4>
          <span class="flex-shrink-0 bg-green-700/30 text-green-400 text-[10px] font-bold px-2 py-0.5 rounded"><%=m.getRating()%> ★</span>
        </div>
        <p class="text-gray-400 text-xs mt-1 truncate"><%=m.getDescription()%></p>
        <div class="flex justify-between items-center mt-3">
          <span class="text-orange-400 font-bold">₹<%=m.getPrice()%></span>
          <a href="MenuServlet?RestaurantID=<%=m.getRestaurantID()%>"
             class="bg-orange-500 hover:bg-orange-600 text-white text-xs font-semibold px-4 py-2 rounded-lg transition-all">Add +</a>
        </div>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>

  <!-- Empty state -->
  <% if (totalResults == 0) { %>
  <div class="text-center py-24">
    <div class="text-6xl mb-4">🔍</div>
    <h3 class="text-xl font-semibold text-white mb-2">No results found</h3>
    <p class="text-gray-400 mb-6">Try different keywords or browse all restaurants</p>
    <a href="callRestaurantServlet" class="bg-orange-500 text-white px-6 py-3 rounded-xl font-semibold">Browse Restaurants</a>
  </div>
  <% } %>
</main>
</body>
</html>
