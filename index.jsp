<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.food.DAOImpl.RestaurantDAOImpl, com.food.Model.Restaurant, java.util.List"%>
<%--
    index.jsp — Public landing page for FlavorNest.
--%>
<%
RestaurantDAOImpl restaurantDAOImpl = new RestaurantDAOImpl();
List<Restaurant> allrestaurants = restaurantDAOImpl.getAllRestaurants();
int totalRestaurantCount = allrestaurants.size();
List<Restaurant> homeRestaurants = allrestaurants.size() > 4 ? allrestaurants.subList(0, 4) : allrestaurants;
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>FlavorNest | Home</title>

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
html {
	scroll-behavior: smooth;
}

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

.ticket-edge {
	position: relative;
}

.ticket-edge::after {
	content: '';
	position: absolute;
	left: 0;
	right: 0;
	bottom: -1px;
	height: 10px;
	background-image: radial-gradient(circle at 10px 0, transparent 9px, #101415 9.5px);
	background-size: 20px 10px;
	background-repeat: repeat-x;
}

.coupon {
	position: relative;
	border: 1.5px dashed rgba(224, 227, 229, 0.25);
}

.coupon::before, .coupon::after {
	content: '';
	position: absolute;
	width: 22px;
	height: 22px;
	background: #101415;
	border-radius: 50%;
	top: 50%;
	transform: translateY(-50%);
}

.coupon::before {
	left: -11px;
}

.coupon::after {
	right: -11px;
}

.steam {
	animation: steam 3.5s ease-in-out infinite;
	transform-origin: bottom center;
}

@keyframes steam {
	0%, 100% { transform: translateY(0) scaleY(1); opacity: .55; }
	50% { transform: translateY(-10px) scaleY(1.15); opacity: .9; }
}

@keyframes fadeUp {
	from { opacity: 0; transform: translateY(24px); }
	to { opacity: 1; transform: translateY(0); }
}

/* FIX: reveal elements are now visible by default (opacity:1).
   The fade-up animation still plays automatically on page load,
   so it no longer depends on JavaScript/IntersectionObserver to
   become visible. This guarantees the page is never blank even
   if a script error occurs. */
.reveal {
	opacity: 1;
	animation: fadeUp .7s cubic-bezier(.2, .7, .2, 1) both;
}

.tiffin-frame {
	border-radius: 1.5rem 1.5rem 3rem 3rem;
	overflow: hidden;
}

::selection {
	background: #ff6b35;
	color: #101415;
}

#cravings-scroller {
	scroll-behavior: smooth;
	scrollbar-width: none;
}

#cravings-scroller::-webkit-scrollbar {
	display: none;
}

.craving-item {
	flex: 0 0 auto;
	width: 108px;
	text-align: center;
}

.craving-ring {
	width: 92px;
	height: 92px;
	border-radius: 9999px;
	overflow: hidden;
	border: 2px solid rgba(255, 255, 255, 0.10);
	transition: border-color .3s ease, transform .3s ease, box-shadow .3s
		ease;
	background: #1d2022;
}

.craving-item:hover .craving-ring {
	border-color: #ff6b35;
	transform: translateY(-4px) scale(1.05);
	box-shadow: 0 12px 26px rgba(255, 107, 53, 0.25);
}

.craving-scroll-btn {
	width: 40px;
	height: 40px;
	border-radius: 9999px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.filter-pill {
	color: #e3bfb3;
}

.filter-pill:hover {
	border-color: #ff6b35;
	color: #e0e3e5;
}

.filter-pill.active {
	background: #ff6b35;
	border-color: #ff6b35;
	color: white;
	box-shadow: 0 8px 20px rgba(255, 107, 53, 0.25);
}

.restaurant-card.hidden-by-filter {
	display: none;
}

@media (prefers-reduced-motion: reduce) {
	.steam, .reveal {
		animation: none !important;
		opacity: 1 !important;
	}
}
</style>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body
	class="bg-background text-on-background selection:bg-primary-container selection:text-white overflow-x-hidden font-body-md">

	<!-- ============ NAVBAR ============ -->
	<header id="navbar"
		class="bg-surface/70 backdrop-blur-[20px] sticky top-0 z-50 border-b border-white/5 shadow-lg">
		<nav
			class="flex justify-between items-center px-margin-mobile md:px-margin-desktop h-20 w-full max-w-container-max mx-auto gap-4">

			<div class="flex items-center gap-6">
				<a href="index.jsp" class="flex items-center gap-2.5"> <img
					src="<%=request.getContextPath()%>/assets/images/icon-192.png"
					alt="FlavorNest logo" class="w-10 h-10 rounded-lg object-cover" />
					<span
					class="font-headline-md text-headline-md font-bold text-on-surface">FlavorNest</span>
				</a>
				<div class="hidden lg:flex items-center gap-6 ml-4">
					<a
						class="text-primary-container font-label-sm border-b-2 border-primary-container pb-1"
						href="#home">Home</a> <a
						class="text-on-surface hover:text-primary-container transition-colors font-label-sm"
						href="#cravings">Cravings</a> <a
						class="text-on-surface hover:text-primary-container transition-colors font-label-sm"
						href="callRestaurantServlet">Restaurants</a> <a
						class="text-on-surface hover:text-primary-container transition-colors font-label-sm"
						href="#offers">Offers</a> <a
						class="text-on-surface hover:text-primary-container transition-colors font-label-sm"
						href="#help">Help</a>
				</div>
			</div>

			<div class="hidden lg:flex items-center gap-3">
				<a href="login.jsp"
					class="px-5 py-2.5 rounded-full text-sm font-semibold text-on-surface border border-white/15 hover:border-primary-container hover:text-primary-container transition-all">Sign
					In</a> <a href="signup.jsp"
					class="px-5 py-2.5 rounded-full text-sm font-semibold text-white primary-glow hover:brightness-110 transition-all">Sign
					Up</a>
			</div>

			<button id="mobileToggle" class="lg:hidden text-on-surface">
				<span id="iconMenu" class="material-symbols-outlined text-3xl">menu</span>
				<span id="iconClose"
					class="material-symbols-outlined text-3xl hidden">close</span>
			</button>
		</nav>

		<div id="mobileMenu"
			class="hidden lg:hidden border-t border-white/5 px-6 py-6 space-y-4 bg-surface">
			<a href="#home"
				class="block text-on-surface hover:text-primary-container text-sm font-medium">Home</a>
			<a href="#cravings"
				class="block text-on-surface hover:text-primary-container text-sm font-medium">Cravings</a>
			<a href="callRestaurantServlet"
				class="block text-on-surface hover:text-primary-container text-sm font-medium">Restaurants</a>
			<a href="#offers"
				class="block text-on-surface hover:text-primary-container text-sm font-medium">Offers</a>
			<a href="#help"
				class="block text-on-surface hover:text-primary-container text-sm font-medium">Help</a>
			<div class="flex gap-3 pt-3">
				<a href="login.jsp"
					class="flex-1 text-center px-4 py-2.5 rounded-full text-sm font-semibold border border-white/15">Sign
					In</a> <a href="signup.jsp"
					class="flex-1 text-center px-4 py-2.5 rounded-full text-sm font-semibold text-white primary-glow">Sign
					Up</a>
			</div>
		</div>
	</header>

	<main class="relative">

		<!-- ============ HERO ============ -->
		<section id="home"
			class="relative px-margin-mobile md:px-margin-desktop pt-16 pb-20 overflow-hidden">
			<div
				class="max-w-container-max mx-auto grid lg:grid-cols-2 gap-16 items-center">

				<div class="reveal">
					<span
						class="inline-block px-4 py-1.5 rounded-full bg-primary-container/15 text-primary-container font-label-sm mb-6 border border-primary-container/30">30-MINUTE
						KITCHENS, CITY-WIDE</span>
					<h1
						class="font-display-xl text-headline-lg-mobile md:text-display-xl text-on-surface mb-6 leading-[1.05]">
						Your city's kitchens,<br>plated in <span
							class="text-primary-container">minutes.</span>
					</h1>
					<p
						class="font-body-lg text-body-lg text-on-surface-variant mb-9 max-w-lg">
						From corner-shop dosas to candlelit pasta, FlavorNest lines up
						Bangalore's best kitchens and gets your order moving — tracked,
						ticketed, and on its way.</p>

					<!-- Search bar — the "ticket" motif -->
					<form action="search" method="get" class="mb-8">
						<div
							class="ticket-edge glass-card rounded-t-2xl p-2 flex flex-col sm:flex-row gap-2 max-w-xl">
							<div class="flex items-center gap-3 flex-1 px-4 py-3">
								<span class="material-symbols-outlined text-primary-container">search</span>
								<input type="text" name="q"
									placeholder="Search a dish, cuisine, or restaurant..."
									class="bg-transparent outline-none text-sm w-full text-on-surface placeholder-on-surface-variant/60">
							</div>
							<button type="submit"
								class="px-6 py-3 rounded-xl text-sm font-semibold text-white primary-glow hover:brightness-110 transition-all whitespace-nowrap">
								Find Food</button>
						</div>
					</form>

					<div class="flex flex-wrap gap-4">
						<a href="callRestaurantServlet"
							class="px-7 py-3.5 rounded-full text-sm font-semibold text-white primary-glow hover:brightness-110 transition-all">Order
							Now</a> <a href="callRestaurantServlet"
							class="px-7 py-3.5 rounded-full text-sm font-semibold border border-white/15 text-on-surface hover:border-primary-container hover:text-primary-container transition-all">Explore
							Restaurants</a>
					</div>
				</div>

				<div class="relative reveal" style="animation-delay: .15s;">
					<div class="grid grid-cols-5 gap-4">
						<div class="col-span-3 tiffin-frame h-72 -rotate-2 glass-card">
							<img
								src="https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=800&q=80"
								alt="Biryani" class="w-full h-full object-cover">
						</div>
						<div class="col-span-2 tiffin-frame h-72 rotate-3 mt-8 glass-card">
							<img
								src="https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=600&q=80"
								alt="Dosa" class="w-full h-full object-cover">
						</div>
						<div class="col-span-2 tiffin-frame h-56 rotate-2 glass-card">
							<img
								src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=600&q=80"
								alt="Pizza" class="w-full h-full object-cover">
						</div>
						<div
							class="col-span-3 tiffin-frame h-56 -rotate-1 -mt-6 glass-card">
							<img
								src="https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=800&q=80"
								alt="Thali" class="w-full h-full object-cover">
						</div>
					</div>

					<div
						class="absolute -left-6 top-6 glass-card rounded-2xl px-4 py-3 flex items-center gap-2 shadow-xl">
						<span class="material-symbols-outlined text-yellow-400">star</span>
						<div>
							<p class="font-mono text-sm font-semibold text-on-surface">4.8</p>
							<p
								class="text-[10px] text-on-surface-variant uppercase tracking-wide">Avg.
								Rating</p>
						</div>
					</div>
					<div
						class="absolute -right-4 bottom-10 glass-card rounded-2xl px-4 py-3 flex items-center gap-2 shadow-xl">
						<span
							class="steam inline-block material-symbols-outlined text-primary-container">bolt</span>
						<div>
							<p class="font-mono text-sm font-semibold text-on-surface">22
								min</p>
							<p
								class="text-[10px] text-on-surface-variant uppercase tracking-wide">Avg.
								Delivery</p>
						</div>
					</div>
				</div>

			</div>
		</section>

		<!-- ============ CRAVINGS / FOOD CATEGORIES ============ -->
		<section id="cravings"
			class="px-margin-mobile md:px-margin-desktop pb-4">
			<div class="max-w-container-max mx-auto">
				<div class="flex items-end justify-between mb-8 reveal">
					<div>
						<span
							class="text-primary-container text-xs font-bold uppercase tracking-widest">Pick
							a craving</span>
						<h2 class="font-headline-lg text-headline-lg text-on-surface mt-2">Fresh
							flavors, just a click away</h2>
					</div>
					<div class="hidden sm:flex items-center gap-3">
						<button id="cravingsPrev" type="button"
							class="craving-scroll-btn glass-card text-on-surface"
							aria-label="Scroll left">
							<span class="material-symbols-outlined text-lg">arrow_back</span>
						</button>
						<button id="cravingsNext" type="button"
							class="craving-scroll-btn glass-card text-on-surface"
							aria-label="Scroll right">
							<span class="material-symbols-outlined text-lg">arrow_forward</span>
						</button>
					</div>
				</div>

				<div id="cravings-scroller"
					class="flex gap-6 overflow-x-auto pb-4 reveal"
					style="animation-delay: .05s;">
					<%
					String[][] cravings = {
							{"Desserts", "Desserts",
							"https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=300&q=80"},
							{"Chinese", "Chinese",
							"https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=300&q=80"},
							{"Cake", "Desserts",
							"https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=300&q=80"},
							{"Burger", "Burgers",
							"https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=300&q=80"},
							{"Salad", "Salad",
							"https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=300&q=80"},
							{"Rolls", "Rolls",
							"https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=300&q=80"},
							{"Pizza", "Pizza",
							"https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=300&q=80"},
							{"Noodles", "Chinese",
							"https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=300&q=80"},
							{"Coffee", "Coffee",
							"https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=300&q=80"},
							{"Pasta", "Pasta", "https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=300&q=80"},
							{"Idli", "South Indian",
							"https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?auto=format&fit=crop&w=300&q=80"},
							{"Biryani", "Biryani",
							"https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=300&q=80"},
							{"Paratha", "South Indian",
							"https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=300&q=80"},
							{"Tea", "Tea", "https://images.unsplash.com/photo-1571934811356-5cc061b6821f?auto=format&fit=crop&w=300&q=80"}};
					for (String[] item : cravings) {
					%>
					<a
						href="search?q=<%=java.net.URLEncoder.encode(item[1], "UTF-8")%>"
						data-filter="<%=item[1]%>" class="craving-item group js-craving">
						<div class="craving-ring mx-auto">
							<img src="<%=item[2]%>" alt="<%=item[0]%>"
								class="w-full h-full object-cover js-craving-img"
								onerror="this.onerror=null;this.src='data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 92 92%22><rect width=%2292%22 height=%2292%22 fill=%22%231d2022%22/><text x=%2250%25%22 y=%2255%25%22 font-size=%2236%22 text-anchor=%22middle%22 fill=%22%23ff6b35%22 font-family=%22sans-serif%22>%F0%9F%8D%BD</text></svg>';">
						</div>
						<p
							class="mt-3 text-sm font-semibold text-on-surface group-hover:text-primary-container transition-colors"><%=item[0]%></p>
					</a>
					<%
					}
					%>
				</div>
			</div>
		</section>

		<!-- ============ POPULAR RESTAURANTS (Home preview — 4 only) ============ -->
		<section id="restaurants"
			class="px-margin-mobile md:px-margin-desktop py-8">
			<div class="max-w-container-max mx-auto">

				<span
					class="reveal inline-block px-4 py-1.5 rounded-full bg-primary-container/15 text-primary-container font-label-sm mb-6 border border-primary-container/30">PREMIUM
					DINING</span>
				<h2
					class="reveal font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface mb-4 leading-tight"
					style="animation-delay: .05s;">
					Popular <span class="text-primary-container">Restaurants</span>
				</h2>
				<p
					class="reveal font-body-lg text-body-lg text-on-surface-variant max-w-xl mb-10"
					style="animation-delay: .1s;">A quick taste of the finest
					kitchens in Bangalore &mdash; view the full list any time.</p>

				<div class="reveal flex justify-between items-end mb-10"
					style="animation-delay: .15s;">
					<p class="text-on-surface-variant font-body-md">
						Showing <span id="restaurantCount"><%=homeRestaurants.size()%></span>
						of
						<%=totalRestaurantCount%>
						elite kitchens in Bangalore
					</p>
					<a href="callRestaurantServlet"
						class="hidden sm:flex items-center gap-2 text-primary-container font-label-sm hover:underline">View
						all <span class="material-symbols-outlined text-sm">arrow_forward</span>
					</a>
				</div>

				<!-- Restaurant grid — home preview only (first 4), same live data as restaurant.jsp -->
				<div id="restaurantGrid"
					class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-gutter">
					<%
					int i = 0;
					for (Restaurant restaurant : homeRestaurants) {
					%>
					<a
						href="MenuServlet?RestaurantID=<%=restaurant.getRestaurantID()%>"
						class="restaurant-card block glass-card rounded-lg overflow-hidden reveal group/item"
						style="animation-delay:<%=i * 0.06%>s;"
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
									class="flex-shrink-0 flex items-center gap-1 px-1.5 py-0.5 rounded bg-green-600 text-white text-[10px] font-bold">
									<%=restaurant.getRating()%> <span
									class="material-symbols-outlined text-[10px] fill-current">star</span>
								</span>
							</div>
							<p class="text-on-surface-variant font-label-sm mb-1 truncate"><%=restaurant.getCuisineType()%></p>
							<p class="text-on-surface-variant/70 text-[12px] mb-4"><%=restaurant.getAddress()%></p>
							<div
								class="mt-auto flex justify-between items-center pt-4 border-t border-white/5">
								<span class="text-on-surface font-semibold">₹500 for two</span>
								<span
									class="text-on-surface-variant font-label-sm flex items-center gap-1">
									<span class="material-symbols-outlined text-sm">schedule</span>
									<%=restaurant.getDeliveryTime()%> min
								</span>
							</div>
						</div>
					</a>
					<%
					i++;
					}
					%>
				</div>

				<!-- View All Restaurants button -->
				<div class="reveal flex justify-center mt-12"
					style="animation-delay: .2s;">
					<a href="callRestaurantServlet"
						class="inline-flex items-center gap-2 px-8 py-3.5 rounded-full text-sm font-semibold text-white primary-glow hover:brightness-110 hover:scale-[1.02] transition-all">
						View All Restaurants <span
						class="material-symbols-outlined text-lg">arrow_forward</span>
					</a>
				</div>

				<p id="noResults"
					class="hidden text-center text-on-surface-variant py-16">No
					restaurants match this filter yet &mdash; try another one.</p>
			</div>
		</section>

		<!-- ============ WHY CHOOSE US ============ -->
		<section
			class="bg-surface-container-low py-24 px-margin-mobile md:px-margin-desktop">
			<div class="text-center mb-16 reveal">
				<h2 class="font-headline-lg text-headline-lg text-on-surface mb-4">Why
					Choose FlavorNest?</h2>
				<p class="text-on-surface-variant max-w-2xl mx-auto">Experience
					the intersection of haute cuisine and high technology. We redefine
					how the city dines.</p>
			</div>
			<div
				class="max-w-container-max mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-gutter">
				<%
				String[][] features = {
						{"bolt", "Lightning Delivery",
						"Kitchens near you start cooking the moment you tap order — no queued-up surprises."},
						{"workspace_premium", "Live Tracking",
						"Watch every order move from placed to plated to your doorstep, in real time."},
						{"loyalty", "Fair Pricing", "No inflated menu prices. What the restaurant charges is what you pay."},
						{"shield_lock", "Verified Kitchens",
						"Every partner is inspected for hygiene before it ever reaches your feed."}};
				for (int f = 0; f < features.length; f++) {
				%>
				<div class="glass-card p-8 rounded-lg text-center group reveal"
					style="animation-delay:<%=f * 0.08%>s;">
					<div
						class="w-16 h-16 bg-primary-container/10 text-primary-container rounded-full flex items-center justify-center mx-auto mb-6 group-hover:scale-110 transition-transform duration-300">
						<span class="material-symbols-outlined text-4xl"><%=features[f][0]%></span>
					</div>
					<h4 class="font-headline-md text-headline-md text-on-surface mb-3"><%=features[f][1]%></h4>
					<p class="text-on-surface-variant font-body-md"><%=features[f][2]%></p>
				</div>
				<%
				}
				%>
			</div>
		</section>

		<!-- ============ OFFERS ============ -->
		<section id="offers"
			class="py-20 px-margin-mobile md:px-margin-desktop bg-surface">
			<div class="max-w-container-max mx-auto">
				<div class="mb-10 reveal">
					<span
						class="text-primary-container text-xs font-bold uppercase tracking-widest">Today's
						coupons</span>
					<h2 class="font-headline-lg text-headline-lg text-on-surface mt-2">Offers
						worth ordering for</h2>
				</div>
				<div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-gutter">
					<%
					String[][] offers = {{"FLAT50", "50% OFF", "On your first order, up to &#8377;150"},
							{"FREESHIP", "Free Delivery", "On orders above &#8377;299, all week"},
							{"COMBO20", "20% OFF", "On combo meals from partner kitchens"}};
					for (int o = 0; o < offers.length; o++) {
					%>
					<div class="coupon rounded-2xl p-8 reveal glass-card"
						style="animation-delay:<%=o * 0.08%>s;">
						<p
							class="font-mono text-xs text-primary-container tracking-widest mb-3">
							CODE:
							<%=offers[o][0]%></p>
						<h3 class="font-headline-md text-headline-md text-on-surface mb-2"><%=offers[o][1]%></h3>
						<p class="text-on-surface-variant text-sm"><%=offers[o][2]%></p>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</section>

		<!-- ============ TESTIMONIALS ============ -->
		<section class="py-20 px-margin-mobile md:px-margin-desktop">
			<div class="max-w-container-max mx-auto">
				<div class="text-center max-w-2xl mx-auto mb-14 reveal">
					<span
						class="text-primary-container text-xs font-bold uppercase tracking-widest">From
						the neighborhood</span>
					<h2 class="font-headline-lg text-headline-lg text-on-surface mt-2">What
						people are saying</h2>
				</div>
				<div class="grid md:grid-cols-3 gap-gutter">
					<%
					String[][] testimonials = {
							{"Priya S.", "College Student", "The live tracking is what got me — I know exactly when to head downstairs."},
							{"Arjun M.", "Software Engineer",
							"Ordered from four different places this month. Never once had a cold delivery."},
							{"Meera K.", "Working Parent", "Fair pricing that actually matches the restaurant menu. Rare these days."}};
					for (int t = 0; t < testimonials.length; t++) {
					%>
					<div class="glass-card rounded-2xl p-7 reveal"
						style="animation-delay:<%=t * 0.08%>s;">
						<span
							class="text-primary-container text-3xl font-headline-md block mb-3">&#8220;</span>
						<p class="text-on-surface text-sm leading-relaxed mb-5"><%=testimonials[t][2]%></p>
						<div class="flex items-center gap-3">
							<div
								class="w-10 h-10 rounded-full flex items-center justify-center font-headline-md font-semibold text-white primary-glow"><%=testimonials[t][0].substring(0, 1)%></div>
							<div>
								<p class="text-sm font-semibold text-on-surface"><%=testimonials[t][0]%></p>
								<p class="text-xs text-on-surface-variant"><%=testimonials[t][1]%></p>
							</div>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
		</section>

		<!-- ============ STATISTICS ============ -->
		<section
			class="py-16 px-margin-mobile md:px-margin-desktop bg-surface-container-low border-t border-b border-white/5">
			<div
				class="max-w-container-max mx-auto grid grid-cols-2 lg:grid-cols-4 gap-8 text-center">
				<div class="reveal">
					<p
						class="font-mono text-4xl font-semibold text-primary-container counter"
						data-target="1200">0</p>
					<p
						class="text-on-surface-variant text-xs uppercase tracking-widest mt-2">Partner
						Restaurants</p>
				</div>
				<div class="reveal" style="animation-delay: .08s;">
					<p
						class="font-mono text-4xl font-semibold text-primary-container counter"
						data-target="85000">0</p>
					<p
						class="text-on-surface-variant text-xs uppercase tracking-widest mt-2">Happy
						Users</p>
				</div>
				<div class="reveal" style="animation-delay: .16s;">
					<p
						class="font-mono text-4xl font-semibold text-primary-container counter"
						data-target="450000">0</p>
					<p
						class="text-on-surface-variant text-xs uppercase tracking-widest mt-2">Orders
						Delivered</p>
				</div>
				<div class="reveal" style="animation-delay: .24s;">
					<p
						class="font-mono text-4xl font-semibold text-primary-container counter"
						data-target="18">0</p>
					<p
						class="text-on-surface-variant text-xs uppercase tracking-widest mt-2">Cities
						Served</p>
				</div>
			</div>
		</section>

		<!-- ============ DOWNLOAD APP ============ -->
		<section class="py-20 px-margin-mobile md:px-margin-desktop">
			<div
				class="max-w-container-max mx-auto glass-card rounded-3xl p-10 md:p-14 grid md:grid-cols-2 gap-10 items-center reveal">
				<div>
					<span
						class="text-primary-container text-xs font-bold uppercase tracking-widest">Take
						it with you</span>
					<h2
						class="font-headline-lg text-headline-lg text-on-surface mt-2 mb-4">Order
						faster from the FlavorNest app</h2>
					<p class="text-on-surface-variant mb-7 leading-relaxed max-w-md">Track
						your ticket from kitchen to doorstep, save your favorite orders,
						and get app-only offers before anyone else.</p>
					<div class="flex flex-wrap gap-4">
						<button
							class="glass-card p-3 rounded-lg flex items-center gap-3 hover:border-primary-container transition-all">
							<span class="material-symbols-outlined text-2xl">smartphone</span>
							<div class="text-left">
								<div
									class="text-[10px] uppercase font-bold text-on-surface-variant">Available
									on</div>
								<div class="font-bold text-on-surface">App Store</div>
							</div>
						</button>
						<button
							class="glass-card p-3 rounded-lg flex items-center gap-3 hover:border-primary-container transition-all">
							<span class="material-symbols-outlined text-2xl">play_arrow</span>
							<div class="text-left">
								<div
									class="text-[10px] uppercase font-bold text-on-surface-variant">Get
									it on</div>
								<div class="font-bold text-on-surface">Google Play</div>
							</div>
						</button>
					</div>
				</div>
				<div class="flex justify-center">
					<div
						class="w-40 h-40 rounded-2xl bg-on-surface flex items-center justify-center">
						<span class="text-background text-xs font-mono text-center px-4">[
							QR CODE<br>PLACEHOLDER ]
						</span>
					</div>
				</div>
			</div>
		</section>
	</main>

	<!-- ============ FOOTER ============ -->
	<footer id="help"
		class="bg-surface-container-lowest py-stack-lg border-t border-white/5">
		<div
			class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop grid grid-cols-1 md:grid-cols-4 gap-gutter mb-12">
			<div class="col-span-1">
				<div class="flex items-center gap-2 mb-6">
					<img src="<%=request.getContextPath()%>/assets/images/icon-192.png"
						alt="FlavorNest logo" class="w-9 h-9 rounded-lg object-cover" />
					<span
						class="font-headline-md text-headline-md text-primary-container font-bold">FlavorNest</span>
				</div>
				<p class="text-on-surface-variant font-body-md mb-8">Curated
					kitchens, honest pricing, and a ticket you can actually track.
					&copy; 2026 FlavorNest.</p>
				<div class="flex gap-4">
					<a
						class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:text-primary-container transition-all"
						href="#"><span class="material-symbols-outlined text-lg">public</span></a>
					<a
						class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:text-primary-container transition-all"
						href="#"><span class="material-symbols-outlined text-lg">chat</span></a>
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
						href="#">Press</a></li>
				</ul>
			</div>
			<div class="col-span-1">
				<h5 class="text-on-surface font-headline-md mb-6">Help</h5>
				<ul class="space-y-4 font-body-md text-on-surface-variant">
					<li><a class="hover:text-primary-container transition-all"
						href="#">FAQs</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Order Support</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Terms of Service</a></li>
					<li><a class="hover:text-primary-container transition-all"
						href="#">Privacy Policy</a></li>
				</ul>
			</div>
			<div class="col-span-1">
				<h5 class="text-on-surface font-headline-md mb-6">Contact</h5>
				<ul class="space-y-4 font-body-md text-on-surface-variant">
					<li>support@flavornest.app</li>
					<li>+91 80-4567-1234</li>
					<li>Bangalore, India</li>
				</ul>
			</div>
		</div>
		<div
			class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop border-t border-white/10 pt-6 flex flex-col sm:flex-row items-center justify-between gap-3">
			<p class="text-on-surface-variant text-xs">&copy; 2026
				FlavorNest. All rights reserved.</p>
			<p class="text-on-surface-variant text-xs">Made for hungry
				cities, one ticket at a time.</p>
		</div>
	</footer>

	<script>
		// Mobile nav toggle
		try {
			const mobileToggle = document.getElementById('mobileToggle');
			const mobileMenu = document.getElementById('mobileMenu');
			const iconMenu = document.getElementById('iconMenu');
			const iconClose = document.getElementById('iconClose');
			if (mobileToggle && mobileMenu && iconMenu && iconClose) {
				mobileToggle.addEventListener('click', function () {
					mobileMenu.classList.toggle('hidden');
					iconMenu.classList.toggle('hidden');
					iconClose.classList.toggle('hidden');
				});
			}
		} catch (e) { console.error('mobile nav init failed', e); }

		// Stat counters (reveal elements are visible by default now,
		// this just animates the numbers counting up when scrolled into view)
		try {
			const counters = document.querySelectorAll('.counter');
			const counterIo = new IntersectionObserver((entries) => {
				entries.forEach(entry => {
					if (entry.isIntersecting) {
						const el = entry.target;
						const target = parseInt(el.getAttribute('data-target'), 10);
						const duration = 1400;
						const start = performance.now();
						function tick(now) {
							const progress = Math.min((now - start) / duration, 1);
							const value = Math.floor(progress * target);
							el.textContent = value.toLocaleString('en-IN');
							if (progress < 1) requestAnimationFrame(tick);
							else el.textContent = target.toLocaleString('en-IN') + '+';
						}
						requestAnimationFrame(tick);
						counterIo.unobserve(el);
					}
				});
			}, { threshold: 0.4 });
			counters.forEach(el => counterIo.observe(el));
		} catch (e) { console.error('counter init failed', e); }

		// Cravings row scroll buttons
		try {
			const cravingsScroller = document.getElementById('cravings-scroller');
			const cravingsPrev = document.getElementById('cravingsPrev');
			const cravingsNext = document.getElementById('cravingsNext');
			if (cravingsScroller && cravingsPrev && cravingsNext) {
				const scrollAmount = 320;
				cravingsPrev.addEventListener('click', () => cravingsScroller.scrollBy({ left: -scrollAmount, behavior: 'smooth' }));
				cravingsNext.addEventListener('click', () => cravingsScroller.scrollBy({ left: scrollAmount, behavior: 'smooth' }));
			}
		} catch (e) { console.error('cravings scroller init failed', e); }
	</script>
</body>
</html>
