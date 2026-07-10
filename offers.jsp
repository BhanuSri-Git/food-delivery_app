<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.food.Model.Offer, com.food.Model.User, com.food.Model.Cart"%>
<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
List<Offer> offers = (List<Offer>) request.getAttribute("offers");
Cart cart = (Cart) session.getAttribute("cart");
int cartCount = cart != null ? cart.getTotalQuantity() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Offers | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
<style>
body{background:#101415;color:#e0e3e5;font-family:'Inter',sans-serif}
.glass{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);transition:all .3s}
.glass:hover{border-color:rgba(255,107,53,.4);transform:translateY(-4px);box-shadow:0 12px 30px rgba(255,107,53,.15)}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
.card-anim{animation:fadeUp .5s ease forwards;opacity:0}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen">
<!-- Navbar -->
<header class="sticky top-0 z-50 border-b border-white/5" style="background:rgba(16,20,21,.9);backdrop-filter:blur(20px)">
  <nav class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
    <div class="flex items-center gap-6">
      <a href="callRestaurantServlet" class="text-orange-400 font-bold text-xl" style="font-family:'Sora',sans-serif">FlavorNest</a>
      <div class="hidden md:flex gap-5 text-sm">
        <a href="callRestaurantServlet" class="text-gray-400 hover:text-white transition-colors">Restaurants</a>
        <a href="offers" class="text-orange-400 border-b border-orange-400 pb-0.5">Offers</a>
        <a href="help.jsp" class="text-gray-400 hover:text-white transition-colors">Help</a>
      </div>
    </div>
    <div class="flex items-center gap-4">
      <a href="cart.jsp" class="relative text-gray-300"><span class="material-symbols-outlined">shopping_cart</span>
        <%if(cartCount>0){%><span class="absolute -top-1 -right-1 bg-orange-500 text-white text-[9px] w-4 h-4 rounded-full flex items-center justify-center font-bold"><%=cartCount%></span><%}%>
      </a>
      <a href="profile" class="text-gray-400 hover:text-white text-sm transition-colors"><%=loggedInUser.getUserName()%></a>
      <a href="logoutServlet" class="text-red-400 text-sm">Logout</a>
    </div>
  </nav>
</header>

<!-- Hero -->
<section class="relative overflow-hidden py-16 px-6" style="background:linear-gradient(135deg,#1a0a00,#2d1200)">
  <div class="max-w-4xl mx-auto text-center relative z-10">
    <span class="inline-block bg-orange-500/20 text-orange-400 text-xs font-bold px-4 py-2 rounded-full mb-4 uppercase tracking-wider">🎉 Exclusive Deals</span>
    <h1 class="text-4xl md:text-5xl font-black text-white mb-4" style="font-family:'Sora',sans-serif">Today's Best Offers</h1>
    <p class="text-gray-400 text-lg max-w-xl mx-auto">Save big on your favourite meals. Limited time deals you don't want to miss.</p>
  </div>
  <div class="absolute inset-0 opacity-20" style="background:radial-gradient(circle at 20% 50%,#ff6b35 0%,transparent 60%)"></div>
</section>

<!-- Category Tabs -->
<div class="max-w-6xl mx-auto px-6 py-6">
  <div class="flex gap-3 overflow-x-auto pb-2 mb-8 hide-scrollbar" style="-ms-overflow-style:none;scrollbar-width:none">
    <% String[] types = {"ALL","FLAT","COMBO","FREE_DELIVERY","BANK","FESTIVAL"}; String[] labels = {"All","Flat Discounts","Combo Offers","Free Delivery","Bank Offers","Festival"};
    for (int i=0;i<types.length;i++) { %>
    <button onclick="filterOffers('<%=types[i]%>')"
      class="offer-tab flex-shrink-0 px-5 py-2 rounded-full text-sm font-semibold border transition-all"
      style="background:rgba(255,255,255,.05);border-color:rgba(255,255,255,.1);color:#e3bfb3"
      data-type="<%=types[i]%>"><%=labels[i]%></button>
    <% } %>
  </div>

  <!-- Offer Cards -->
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6" id="offersGrid">
    <%
    // Fallback demo offers if DB is empty
    // Array layout per row: { type, title, description, couponCode, discountPercent, imageUrl }
    //                          [0]   [1]    [2]          [3]          [4]              [5]
    boolean hasOffers = offers != null && !offers.isEmpty();
    if (!hasOffers) {
      String[][] demo = {
        {"FLAT","50% OFF up to ₹100","Use code FLAVOR50 on your first order","FLAVOR50","50","https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=400&q=70"},
        {"FREE_DELIVERY","Free Delivery","No minimum order value. Free delivery all day!","FREEDEL","0","https://images.unsplash.com/photo-1526367790999-0150786686a2?auto=format&fit=crop&w=400&q=70"},
        {"COMBO","Buy 1 Get 1 Free","On selected combo meals every Tuesday","COMBO1","100","https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=400&q=70"},
        {"BANK","HDFC Bank Offer","20% off up to ₹150 on HDFC Credit Cards","HDFC20","20","https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=400&q=70"},
        {"FESTIVAL","Diwali Special","Flat ₹200 off on orders above ₹599","DIWALI200","30","https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=400&q=70"},
        {"FLAT","New User Deal","60% off up to ₹120 for new users","NEW60","60","https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=70"}
      };
      for (int i=0;i<demo.length;i++) {
        String[] d = demo[i]; String delay = (i*100)+"ms";
    %>
    <div class="glass rounded-2xl overflow-hidden offer-card card-anim" style="animation-delay:<%=delay%>" data-type="<%=d[0]%>">
      <div class="relative">
        <img src="<%=d[5]%>" class="w-full h-40 object-cover"
          onerror="this.onerror=null;this.style.display='none';this.nextElementSibling.style.display='flex';"
          alt="<%=d[1]%>">
        <div class="w-full h-40 items-center justify-center hidden" style="background:linear-gradient(135deg,#1f0a00,#3d1600)">
          <span class="text-5xl">🎁</span>
        </div>
        <span class="absolute top-3 left-3 text-white text-xs font-black px-3 py-1 rounded-full"
          style="background:linear-gradient(135deg,#ff5f1f,#ff8c5a)"><%=d[3]%></span>
        <% if (!"FREE_DELIVERY".equals(d[0])) { %>
        <span class="absolute top-3 right-3 bg-black/60 text-green-400 text-xs font-bold px-2 py-1 rounded-full">
          UP TO <%=d[4]%>% OFF
        </span>
        <% } else { %>
        <span class="absolute top-3 right-3 bg-black/60 text-green-400 text-xs font-bold px-2 py-1 rounded-full">
          FREE
        </span>
        <% } %>
      </div>
      <div class="p-5">
        <h3 class="text-white font-bold text-lg mb-1"><%=d[1]%></h3>
        <p class="text-gray-400 text-sm mb-4"><%=d[2]%></p>
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-2 bg-white/5 border border-dashed border-orange-500/50 px-3 py-1.5 rounded-lg">
            <span class="material-symbols-outlined text-orange-400 text-sm">confirmation_number</span>
            <span class="text-orange-400 font-bold text-sm tracking-wider"><%=d[3]%></span>
          </div>
          <button onclick="copyCode('<%=d[3]%>',this)"
            class="bg-orange-500 hover:bg-orange-600 text-white text-xs font-semibold px-4 py-2 rounded-lg transition-all">
            Copy Code
          </button>
        </div>
      </div>
    </div>
    <% } %>
    <% } else {
      int i=0; for (Offer o : offers) { String delay=(i*100)+"ms"; i++; %>
    <div class="glass rounded-2xl overflow-hidden offer-card card-anim" style="animation-delay:<%=delay%>" data-type="<%=o.getOfferType()%>">
      <div class="relative">
        <% if (o.getImagePath()!=null && !o.getImagePath().isEmpty()) { %>
        <img src="<%=o.getImagePath()%>" class="w-full h-40 object-cover"
          onerror="this.onerror=null;this.style.display='none';this.nextElementSibling.style.display='flex';"
          alt="<%=o.getTitle()%>">
        <div class="w-full h-40 items-center justify-center hidden" style="background:linear-gradient(135deg,#1f0a00,#3d1600)">
          <span class="text-5xl">🎁</span>
        </div>
        <% } else { %>
        <div class="w-full h-40 flex items-center justify-center" style="background:linear-gradient(135deg,#1f0a00,#3d1600)">
          <span class="text-5xl">🎁</span>
        </div>
        <% } %>
        <span class="absolute top-3 left-3 text-white text-xs font-black px-3 py-1 rounded-full"
          style="background:linear-gradient(135deg,#ff5f1f,#ff8c5a)"><%=o.getDiscountPercent()>0?o.getDiscountPercent()+"%OFF":"DEAL"%></span>
      </div>
      <div class="p-5">
        <h3 class="text-white font-bold text-lg mb-1"><%=o.getTitle()%></h3>
        <p class="text-gray-400 text-sm mb-4"><%=o.getDescription()%></p>
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-2 bg-white/5 border border-dashed border-orange-500/50 px-3 py-1.5 rounded-lg">
            <span class="material-symbols-outlined text-orange-400 text-sm">confirmation_number</span>
            <span class="text-orange-400 font-bold text-sm tracking-wider"><%=o.getCouponCode()%></span>
          </div>
          <button onclick="copyCode('<%=o.getCouponCode()%>',this)"
            class="bg-orange-500 hover:bg-orange-600 text-white text-xs font-semibold px-4 py-2 rounded-lg transition-all">
            Copy Code
          </button>
        </div>
      </div>
    </div>
    <% } } %>
  </div>
</div>

<script>
function copyCode(code, btn) {
  navigator.clipboard.writeText(code).then(() => {
    btn.innerText = '✓ Copied!';
    btn.style.background = '#22c55e';
    setTimeout(() => { btn.innerText = 'Copy Code'; btn.style.background = ''; }, 2000);
  });
}
function filterOffers(type) {
  document.querySelectorAll('.offer-tab').forEach(t => {
    t.style.background = 'rgba(255,255,255,.05)'; t.style.borderColor = 'rgba(255,255,255,.1)'; t.style.color = '#e3bfb3';
    if (t.dataset.type === type) { t.style.background = '#ff6b35'; t.style.borderColor = '#ff6b35'; t.style.color = '#fff'; }
  });
  document.querySelectorAll('.offer-card').forEach(c => {
    c.style.display = (type === 'ALL' || c.dataset.type === type) ? 'block' : 'none';
  });
}
filterOffers('ALL');
</script>
</body>
</html>
