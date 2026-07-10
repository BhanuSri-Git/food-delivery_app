<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.Model.Cart, com.food.Model.User, com.food.Model.Restaurant, java.util.List"%>

<%
// Auth guard
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Cart cart = (Cart) session.getAttribute("cart");
int cartCount = 0;
if (cart != null) {
    cartCount = cart.getTotalQuantity();
}
%>
<!DOCTYPE html>

<html class="dark" lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>FlavorNest | Restaurants</title>
<script
	src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&amp;family=Inter:wght@400;500;600&amp;family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet" />
<script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              "colors": {
                      "inverse-primary": "#ab3600",
                      "on-tertiary": "#283044",
                      "secondary-container": "#8d3800",
                      "on-primary": "#5c1900",
                      "primary-fixed": "#ffdbcf",
                      "primary-fixed-dim": "#ffb59c",
                      "primary": "#ffb59c",
                      "on-primary-container": "#561700",
                      "primary-container": "#ff6b35",
                      "on-surface": "#e0e3e5",
                      "on-background": "#e0e3e5",
                      "outline-variant": "#5b4138",
                      "inverse-on-surface": "#2d3133",
                      "on-tertiary-container": "#242c40",
                      "on-secondary-fixed-variant": "#7a3000",
                      "on-tertiary-fixed": "#131b2e",
                      "on-secondary-container": "#ffb592",
                      "secondary-fixed": "#ffdbcc",
                      "surface-container": "#1d2022",
                      "secondary-fixed-dim": "#ffb693",
                      "on-error": "#690005",
                      "tertiary-fixed": "#dae2fd",
                      "on-secondary-fixed": "#351000",
                      "on-primary-fixed": "#390c00",
                      "on-primary-fixed-variant": "#832700",
                      "surface-dim": "#101415",
                      "surface-container-high": "#272a2c",
                      "outline": "#aa897f",
                      "surface": "#101415",
                      "on-tertiary-fixed-variant": "#3f465c",
                      "inverse-surface": "#e0e3e5",
                      "on-secondary": "#562000",
                      "background": "#101415",
                      "surface-container-lowest": "#0b0f10",
                      "tertiary-container": "#8c93ac",
                      "secondary": "#ffb693",
                      "tertiary-fixed-dim": "#bec6e0",
                      "surface-container-highest": "#323537",
                      "surface-container-low": "#191c1e",
                      "tertiary": "#bec6e0",
                      "surface-variant": "#323537",
                      "surface-tint": "#ffb59c",
                      "on-surface-variant": "#e3bfb3",
                      "on-error-container": "#ffdad6",
                      "surface-bright": "#363a3b",
                      "error-container": "#93000a",
                      "error": "#ffb4ab"
              },
              "borderRadius": {
                      "DEFAULT": "1rem",
                      "lg": "2rem",
                      "xl": "3rem",
                      "full": "9999px"
              },
              "spacing": {
                      "stack-md": "16px",
                      "glass-blur": "20px",
                      "container-max": "1440px",
                      "border-opacity": "0.1",
                      "margin-desktop": "80px",
                      "margin-mobile": "20px",
                      "stack-sm": "8px",
                      "stack-lg": "32px",
                      "gutter": "24px"
              },
              "fontFamily": {
                      "headline-lg": ["Sora"],
                      "headline-lg-mobile": ["Sora"],
                      "label-sm": ["Inter"],
                      "headline-md": ["Sora"],
                      "body-md": ["Inter"],
                      "display-xl": ["Sora"],
                      "body-lg": ["Inter"]
              },
              "fontSize": {
                      "headline-lg": ["40px", {"lineHeight": "1.2", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                      "headline-lg-mobile": ["32px", {"lineHeight": "1.2", "fontWeight": "600"}],
                      "label-sm": ["12px", {"lineHeight": "1", "letterSpacing": "0.05em", "fontWeight": "600"}],
                      "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}],
                      "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}],
                      "display-xl": ["64px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                      "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}]
              }
            },
          },
        }
    </script>
<style>
.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
}

.glass-card {
	background: rgba(255, 255, 255, 0.05);
	backdrop-filter: blur(20px);
	border: 1px solid rgba(255, 255, 255, 0.1);
	transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.glass-card:hover {
	transform: translateY(-8px) scale(1.02);
	background: rgba(255, 255, 255, 0.08);
	border-color: #ff6b35;
	box-shadow: 0 20px 40px rgba(255, 107, 53, 0.15);
}

.primary-glow {
	background: linear-gradient(135deg, #ff6b35 0%, #ff8c5f 100%);
	box-shadow: 0 8px 32px rgba(255, 107, 53, 0.3);
}

.shimmer {
	position: relative;
	overflow: hidden;
}

.shimmer::after {
	content: '';
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1),
		transparent);
	transform: rotate(45deg);
	animation: shimmer 5s infinite;
}

@keyframes shimmer {
	0% { transform: translateX(-100%) rotate(45deg); }
	20% { transform: translateX(100%) rotate(45deg); }
	100% { transform: translateX(100%) rotate(45deg); }
}

.hide-scrollbar::-webkit-scrollbar {
	display: none;
}

.hide-scrollbar {
	-ms-overflow-style: none;
	scrollbar-width: none;
}

.restaurant-card {
	height: 420px;
	display: flex;
	flex-direction: column;
}

.restaurant-image-container {
	height: 220px;
	overflow: hidden;
	position: relative;
}

.offer-ribbon {
	background: linear-gradient(90deg, #ff6b35 0%, #ff8c5f 100%);
	padding: 4px 12px;
	font-size: 10px;
	font-weight: 700;
	color: white;
	position: absolute;
	bottom: 12px;
	left: 0;
	border-radius: 0 4px 4px 0;
	z-index: 10;
}

/* Craving round icons */
#cravings-scroller { scroll-behavior: smooth; }
.js-craving { flex: 0 0 auto; }

/* Cuisine / craving filter pills */
.filter-pill.active {
	background: #ff6b35 !important;
	color: white !important;
	border-color: #ff6b35 !important;
	box-shadow: 0 8px 20px rgba(255, 107, 53, 0.25);
}
.restaurant-card.hidden-by-filter { display: none !important; }
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body
	class="bg-background text-on-background selection:bg-primary-container selection:text-white overflow-x-hidden font-body-md">
	<!-- Top Navigation Bar -->
	<header
		class="bg-surface/70 backdrop-blur-[20px] text-primary docked full-width top-0 sticky z-50 border-b border-white/5 shadow-lg">
		<nav
			class="flex justify-between items-center px-margin-mobile md:px-margin-desktop h-20 w-full max-w-container-max mx-auto gap-4">
			<div class="flex items-center gap-6">
				<div class="flex items-center gap-2 group cursor-pointer">
					<img alt="FlavorNest Logo" class="h-10 w-10 rounded-xl object-cover"
						src="<%=request.getContextPath()%>/assets/images/icon-192.png" />
					<span
						class="font-headline-md text-headline-md font-bold text-on-surface">FlavorNest</span>
				</div>
				<div class="hidden lg:flex items-center gap-6 ml-4">
					<a class="text-primary-container font-label-sm border-b-2 border-primary-container pb-1"
						href="callRestaurantServlet">Restaurants</a>
					<a class="text-on-surface hover:text-primary-container transition-colors font-label-sm"
						href="offers">Offers</a>
					<a class="text-on-surface hover:text-primary-container transition-colors font-label-sm"
						href="help.jsp">Help</a>
					<% if ("Admin".equalsIgnoreCase(loggedInUser.getRole())) { %>
					<a class="text-orange-400 hover:text-orange-300 transition-colors font-label-sm"
						href="admin/dashboard">Admin</a>
					<% } %>
				</div>
			</div>
			<div class="flex-1 max-w-md hidden md:block">
				<!-- Location + Search bar -->
				<div class="flex items-center gap-2">
					<button onclick="detectLocation()" title="Detect my location"
						class="flex-shrink-0 flex items-center gap-1 bg-surface-container border border-white/10 rounded-full py-2 px-3 text-primary-container text-xs hover:bg-surface-container-high transition-all">
						<span class="material-symbols-outlined text-sm">my_location</span>
						<span id="locationLabel" class="max-w-[80px] truncate">Detect</span>
					</button>
					<form action="search" method="get" class="relative flex-1 group">
						<span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary-container transition-colors">search</span>
						<input name="q"
							class="w-full bg-surface-container border border-white/10 rounded-full py-2.5 pl-12 pr-6 text-on-surface text-sm focus:ring-1 focus:ring-primary-container transition-all outline-none"
							placeholder="Search restaurants, dishes..." type="text" />
					</form>
				</div>
			</div>
			<div class="flex items-center gap-6">
				<div class="flex items-center gap-3">
					<a href="orderHistory" class="hidden md:block text-on-surface hover:text-primary-container font-label-sm transition-colors">My Orders</a>
					<a href="profile" class="hidden md:block text-on-surface hover:text-primary-container font-label-sm transition-colors">Profile</a>
					<span class="hidden md:block text-gray-500 text-sm">Hi, <span class="text-primary-container font-medium"><%=loggedInUser.getUserName()%></span></span>
					<a href="cart.jsp" class="relative text-on-surface hover:text-primary-container transition-all">
						<span class="material-symbols-outlined text-2xl">shopping_cart</span>
						<% if (cartCount > 0) { %>
						<span class="absolute -top-1 -right-1 bg-primary-container text-white text-[9px] font-bold w-4 h-4 rounded-full flex items-center justify-center"><%=cartCount%></span>
						<% } %>
					</a>
					<a href="logoutServlet" class="bg-red-500/10 border border-red-500/30 text-red-400 hover:bg-red-500/20 px-4 py-1.5 rounded-full font-label-sm transition-all text-sm">Logout</a>
				</div>
			</div><!-- end flex items-center gap-6 -->
		</nav>
	</header>
	<main class="relative">
		<!-- Hero Section -->
		<section
			class="relative min-h-[40vh] flex items-center px-margin-mobile md:px-margin-desktop py-stack-lg overflow-hidden">
			<div class="relative z-10 max-w-3xl">
				<span
					class="inline-block px-4 py-1.5 rounded-full bg-primary-container/20 text-primary-container font-label-sm mb-6 border border-primary-container/30">PREMIUM
					DINING</span>
				<h1
					class="font-display-xl text-display-xl text-on-surface mb-6 leading-none">
					Discover <span class="text-primary-container">Elite</span>
					Restaurants
				</h1>
				<p
					class="font-body-lg text-body-lg text-on-surface-variant mb-10 max-w-xl">Curated
					culinary experiences from the finest kitchens in Bangalore,
					delivered with lightning speed.</p>
			</div>
		</section>
		<!-- Search & Filters -->
		<section
			class="px-margin-mobile md:px-margin-desktop py-8 relative z-20">
			<div
				class="flex items-center gap-4 mb-12 overflow-x-auto hide-scrollbar pb-2">
				<button data-filter="All"
					class="filter-pill active flex-shrink-0 px-6 py-2 rounded-full bg-primary-container text-white font-label-sm shadow-lg shadow-primary-container/20">All</button>
				<a href="search?filter=veg"
					class="flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all flex items-center gap-1">
					<span class="w-3 h-3 rounded-full bg-green-500 inline-block"></span> Veg</a>
				<a href="search?filter=rating"
					class="flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-sm text-yellow-400">star</span> Top Rated</a>
				<a href="search?filter=fast"
					class="flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-sm text-blue-400">bolt</span> Fast Delivery</a>
				<a href="offers"
					class="flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-sm text-orange-400">local_offer</span> Offers</a>
				<div class="h-6 w-px bg-white/10 mx-2"></div>
				<button data-filter="Biryani"
					class="filter-pill flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all">Biryani</button>
				<button data-filter="South Indian"
					class="filter-pill flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all">South Indian</button>
				<button data-filter="Pizza"
					class="filter-pill flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all">Pizza</button>
				<button data-filter="Burgers"
					class="filter-pill flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all">Burgers</button>
				<button data-filter="Chinese"
					class="filter-pill flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all">Chinese</button>
				<button data-filter="Desserts"
					class="filter-pill flex-shrink-0 px-6 py-2 rounded-full glass-card text-on-surface-variant font-label-sm hover:border-primary-container transition-all">Desserts</button>
			</div>

			<!-- Cravings Row -->
			<div class="flex items-end justify-between mb-8">
				<div>
					<span class="text-primary-container text-xs font-bold uppercase tracking-widest">Pick a craving</span>
					<h2 class="font-headline-md text-headline-md text-on-surface mt-2">What are you in the mood for?</h2>
				</div>
				<div class="hidden sm:flex items-center gap-3">
					<button id="cravingsPrev" type="button" class="w-10 h-10 rounded-full glass-card text-on-surface flex items-center justify-center" aria-label="Scroll left">
						<span class="material-symbols-outlined text-lg">arrow_back</span>
					</button>
					<button id="cravingsNext" type="button" class="w-10 h-10 rounded-full glass-card text-on-surface flex items-center justify-center" aria-label="Scroll right">
						<span class="material-symbols-outlined text-lg">arrow_forward</span>
					</button>
				</div>
			</div>
			<div id="cravings-scroller" class="flex gap-6 overflow-x-auto hide-scrollbar pb-10">
				<%
				    // NOTE: verified, stable Unsplash photo IDs only. Every <img> below also has
				    // an onerror handler that swaps in a local inline-SVG fallback icon, so a
				    // craving circle is never left showing a broken-image glyph or raw alt text.
				    String[][] cravings = {
				        {"Biryani", "Biryani", "https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=300&q=80"},
				        {"Pizza", "Pizza", "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=300&q=80"},
				        {"Idli/Dosa", "South Indian", "https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=300&q=80"},
				        {"Burger", "Burgers", "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=300&q=80"},
				        {"Noodles", "Chinese", "https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=300&q=80"},
				        {"Dessert", "Desserts", "https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=300&q=80"}
				    };
				    for (String[] item : cravings) {
				%>
				<a href="#" data-filter="<%= item[1] %>" class="js-craving w-24 text-center group">
					<div class="w-20 h-20 mx-auto rounded-full overflow-hidden border-2 border-white/10 group-hover:border-primary-container transition-all bg-surface-container">
						<img src="<%= item[2] %>" alt="<%= item[0] %>" class="w-full h-full object-cover"
							onerror="this.onerror=null;this.src='data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 80 80%22><rect width=%2280%22 height=%2280%22 fill=%22%231d2022%22/><text x=%2250%25%22 y=%2255%25%22 font-size=%2232%22 text-anchor=%22middle%22 fill=%22%23ff6b35%22 font-family=%22sans-serif%22>%F0%9F%8D%BD</text></svg>';">
					</div>
					<p class="mt-2 text-xs font-semibold text-on-surface-variant group-hover:text-primary-container transition-colors"><%= item[0] %></p>
				</a>
				<% } %>
			</div>

			<!-- Grid Header -->
			<div class="flex justify-between items-end mb-10">
				<div>
					<h2 class="font-headline-lg text-headline-lg text-on-surface">Cuisines
						you love</h2>
					<p class="text-on-surface-variant font-body-md mt-2">Showing
						<span id="restaurantCount"><%
						    List<Restaurant> countList = (List<Restaurant>) request.getAttribute("allrestaurants");
						    out.print(countList != null ? countList.size() : 0);
						%></span> elite kitchens in Bangalore</p>
				</div>
				<div
					class="flex items-center gap-2 text-primary-container cursor-pointer font-label-sm group">
					View Maps <span
						class="material-symbols-outlined group-hover:translate-x-1 transition-transform">map</span>
				</div>
			</div>
			<!-- Uniform Restaurant Grid -->
			<div id="restaurantGrid"
				class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-gutter">
				<%
				List<Restaurant> allrestaurants = (List<Restaurant>) request.getAttribute("allrestaurants");
				for (Restaurant restaurant : allrestaurants) {
				%>

				<a href="MenuServlet?RestaurantID=<%=restaurant.getRestaurantID()%>"
					class="glass-card restaurant-card rounded-lg overflow-hidden group/item block"
					data-cuisine="<%=restaurant.getCuisineType()%>">
					<div class="restaurant-image-container">
						<img alt="<%=restaurant.getName()%>"
							class="w-full h-full object-cover transition-transform duration-700 group-hover/item:scale-110"
							src="<%=restaurant.getImagePath()%>" />
						<button
							class="absolute top-4 right-4 z-20 text-white/70 hover:text-primary-container transition-colors">
							<span class="material-symbols-outlined">favorite</span>
						</button>
					</div>
					<div class="p-5 flex-grow flex flex-col">
						<div class="flex justify-between items-start mb-2">
							<h3 class="font-headline-md text-on-surface truncate pr-2"><%=restaurant.getName()%></h3>
							<span
								class="flex-shrink-0 flex items-center gap-1 px-1.5 py-0.5 rounded bg-green-600 text-white text-[10px] font-bold"><%=restaurant.getRating()%>
								<span
								class="material-symbols-outlined text-[10px] fill-current">star</span></span>
						</div>
						<p class="text-on-surface-variant font-label-sm mb-1 truncate"><%=restaurant.getCuisineType()%></p>
						<p class="text-on-surface-variant/70 text-[12px] mb-4"><%=restaurant.getAddress()%></p>
						<div
							class="mt-auto flex justify-between items-center pt-4 border-t border-white/5">
							<span class="text-on-surface font-semibold">₹500 for two</span>
							<span
								class="text-on-surface-variant font-label-sm flex items-center gap-1"><span
								class="material-symbols-outlined text-sm">schedule</span> <%=restaurant.getDeliveryTime()%></span>
						</div>
					</div>
				</a>
				<%
				}
				%>
			</div><!-- end restaurant grid -->
			<p id="noResults" class="hidden text-center text-on-surface-variant py-16">No restaurants match this filter yet &mdash; try another one.</p>
		</section>
		<!-- Features Section -->
		<section
			class="bg-surface-container-low py-24 px-margin-mobile md:px-margin-desktop">
			<div class="text-center mb-16">
				<h2 class="font-headline-lg text-headline-lg text-on-surface mb-4">Why
					Choose FlavorNest?</h2>
				<p class="text-on-surface-variant max-w-2xl mx-auto">Experience
					the intersection of haute cuisine and high technology. We redefine
					how the city dines.</p>
			</div>
			<div
				class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-gutter">
				<div class="glass-card p-8 rounded-lg text-center group">
					<div
						class="w-16 h-16 bg-primary-container/10 text-primary-container rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
						<span class="material-symbols-outlined text-4xl">bolt</span>
					</div>
					<h4 class="font-headline-md text-headline-md text-on-surface mb-3">Lightning
						Delivery</h4>
					<p class="text-on-surface-variant font-body-md">Average
						delivery time under 30 minutes with real-time tracking.</p>
				</div>
				<div class="glass-card p-8 rounded-lg text-center group">
					<div
						class="w-16 h-16 bg-primary-container/10 text-primary-container rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
						<span class="material-symbols-outlined text-4xl">workspace_premium</span>
					</div>
					<h4 class="font-headline-md text-headline-md text-on-surface mb-3">Top
						Rated</h4>
					<p class="text-on-surface-variant font-body-md">Only the
						highest rated restaurants in Bangalore on our platform.</p>
				</div>
				<div class="glass-card p-8 rounded-lg text-center group">
					<div
						class="w-16 h-16 bg-primary-container/10 text-primary-container rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
						<span class="material-symbols-outlined text-4xl">loyalty</span>
					</div>
					<h4 class="font-headline-md text-headline-md text-on-surface mb-3">Daily
						Deals</h4>
					<p class="text-on-surface-variant font-body-md">Exclusive
						editorial offers and curated discounts daily.</p>
				</div>
				<div class="glass-card p-8 rounded-lg text-center group">
					<div
						class="w-16 h-16 bg-primary-container/10 text-primary-container rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
						<span class="material-symbols-outlined text-4xl">shield_lock</span>
					</div>
					<h4 class="font-headline-md text-headline-md text-on-surface mb-3">Secure
						Payments</h4>
					<p class="text-on-surface-variant font-body-md">Secure,
						frictionless transactions with end-to-end encryption.</p>
				</div>
			</div>
		</section>
	</main>
	<!-- Footer -->
	<footer
		class="bg-surface-container-lowest full-width py-stack-lg border-t border-white/5">
		<div
			class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop grid grid-cols-1 md:grid-cols-4 gap-gutter">
			<div class="col-span-1">
				<div class="flex items-center gap-2 mb-6">
					<img alt="FlavorNest Logo" class="h-8 w-8 rounded-lg object-cover"
						src="<%=request.getContextPath()%>/assets/images/icon-192.png" />
					<span
						class="font-headline-md text-headline-md text-primary-container font-bold">FlavorNest</span>
				</div>
				<p class="text-on-surface-variant font-body-md mb-8">Redefining
					urban dining with technology and curation. © 2026 FlavorNest.</p>
				<div class="flex gap-4">
					<a
						class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:text-primary-container transition-all"
						href="#"> <span class="material-symbols-outlined text-lg">public</span>
					</a> <a
						class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:text-primary-container transition-all"
						href="#"> <span class="material-symbols-outlined text-lg">chat</span>
					</a>
				</div>
			</div>
			<div class="col-span-1">
				<h5 class="text-on-surface font-headline-md mb-6">Company</h5>
				<ul class="space-y-4 font-body-md text-on-surface-variant">
					<li><a class="hover:text-primary-container transition-all"
						href="#">About Us</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Partner with Us</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Careers</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Blog</a></li>
				</ul>
			</div>
			<div class="col-span-1">
				<h5 class="text-on-surface font-headline-md mb-6">Legal</h5>
				<ul class="space-y-4 font-body-md text-on-surface-variant">
					<li><a class="hover:text-primary-container transition-all"
						href="#">Terms of Service</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Privacy Policy</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Locations</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Sitemap</a></li>
				</ul>
			</div>
			<div class="col-span-1">
				<h5 class="text-on-surface font-headline-md mb-6">Get the App</h5>
				<p class="text-on-surface-variant font-body-md mb-6">Experience
					the future of food on mobile.</p>
				<div class="space-y-3">
					<button
						class="w-full glass-card p-3 rounded-lg flex items-center gap-3 hover:border-primary-container transition-all">
						<span class="material-symbols-outlined text-2xl">smartphone</span>
						<div class="text-left">
							<div
								class="text-[10px] uppercase font-bold text-on-surface-variant">Available
								on</div>
							<div class="font-bold">App Store</div>
						</div>
					</button>
				</div>
			</div>
		</div>
	</footer>
	<!-- Mobile Navigation Bar -->
	<div
		class="md:hidden fixed bottom-6 left-1/2 -translate-x-1/2 w-[calc(100%-40px)] max-w-md glass-card rounded-full z-50 p-2 shadow-xl flex justify-around items-center border border-white/10">
		<a
			class="flex flex-col items-center justify-center bg-primary-container text-white rounded-full w-12 h-12"
			href="callRestaurantServlet"> <span class="material-symbols-outlined">explore</span>
		</a> <a
			class="flex flex-col items-center justify-center text-on-surface-variant p-2"
			href="callRestaurantServlet"> <span class="material-symbols-outlined">restaurant_menu</span>
		</a> <a
			class="flex flex-col items-center justify-center text-on-surface-variant p-2"
			href="offers"> <span class="material-symbols-outlined">local_offer</span>
		</a> <a
			class="flex flex-col items-center justify-center text-on-surface-variant p-2"
			href="profile"> <span class="material-symbols-outlined">person</span>
		</a>
	</div>
	<script>
    // Restaurant filtering — shared by cuisine chips + craving icons
    const filterPills = document.querySelectorAll('[data-filter]');
    const restaurantCards = document.querySelectorAll('#restaurantGrid .restaurant-card');
    const restaurantCountEl = document.getElementById('restaurantCount');
    const noResultsEl = document.getElementById('noResults');

    function applyFilter(filter) {
        filterPills.forEach(p => {
            if (p.tagName === 'BUTTON') {
                p.classList.toggle('active', p.getAttribute('data-filter') === filter);
            }
        });
        let visibleCount = 0;
        restaurantCards.forEach(card => {
            const show = (filter === 'All') || (card.getAttribute('data-cuisine') === filter);
            card.classList.toggle('hidden-by-filter', !show);
            if (show) visibleCount++;
        });
        if (restaurantCountEl) restaurantCountEl.textContent = visibleCount;
        if (noResultsEl) noResultsEl.classList.toggle('hidden', visibleCount > 0);
    }

    document.querySelectorAll('button.filter-pill[data-filter]').forEach(btn => {
        btn.addEventListener('click', () => applyFilter(btn.getAttribute('data-filter')));
    });

    document.querySelectorAll('.js-craving').forEach(item => {
        item.addEventListener('click', function (e) {
            e.preventDefault();
            applyFilter(this.getAttribute('data-filter'));
            document.getElementById('restaurantGrid').scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
    });

    // Cravings row scroll buttons
    const cravingsScroller = document.getElementById('cravings-scroller');
    const cravingsPrev = document.getElementById('cravingsPrev');
    const cravingsNext = document.getElementById('cravingsNext');
    if (cravingsScroller && cravingsPrev && cravingsNext) {
        const scrollAmount = 320;
        cravingsPrev.addEventListener('click', () => cravingsScroller.scrollBy({ left: -scrollAmount, behavior: 'smooth' }));
        cravingsNext.addEventListener('click', () => cravingsScroller.scrollBy({ left: scrollAmount, behavior: 'smooth' }));
    }

    // Intersection Observer for entrance animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('opacity-100', 'translate-y-0');
                entry.target.classList.remove('opacity-0', 'translate-y-10');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.glass-card').forEach(card => {
        card.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-700');
        observer.observe(card);
    });
</script>
</body>
</html>
