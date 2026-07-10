<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.food.Model.Cart"%>
<%@ page import="com.food.Model.CartItem"%>
<%@ page import="com.food.Model.User"%>
<%@ page import="java.math.BigDecimal"%>

<%
// Auth guard
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>




<!DOCTYPE html>

<html class="dark" lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>FlavorNest | Cart</title>
<script
	src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&amp;family=Inter:wght@400;600;700&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet" />
<script id="tailwind-config">
    tailwind.config = {
      darkMode: "class",
      theme: {
        extend: {
          "colors": {
                  "secondary-fixed": "#ffdbcc",
                  "surface-container": "#1d2022",
                  "on-secondary-fixed-variant": "#7a3000",
                  "surface-container-low": "#191c1e",
                  "primary-fixed": "#ffdbcf",
                  "on-surface-variant": "#e3bfb3",
                  "surface-tint": "#ffb59c",
                  "outline": "#aa897f",
                  "on-surface": "#e0e3e5",
                  "primary-container": "#ff5f1f",
                  "on-tertiary-fixed-variant": "#3f465c",
                  "on-tertiary-container": "#242c40",
                  "on-error": "#690005",
                  "secondary-container": "#8d3800",
                  "error": "#ffb4ab",
                  "tertiary": "#bec6e0",
                  "surface-dim": "#101415",
                  "on-primary-container": "#561700",
                  "inverse-surface": "#e0e3e5",
                  "surface-container-highest": "#323537",
                  "on-tertiary": "#283044",
                  "on-error-container": "#ffdad6",
                  "inverse-primary": "#ab3600",
                  "outline-variant": "#5b4138",
                  "surface-bright": "#363a3b",
                  "secondary": "#ffb693",
                  "primary-fixed-dim": "#ffb59c",
                  "on-secondary-fixed": "#351000",
                  "on-background": "#e0e3e5",
                  "on-secondary-container": "#ffb592",
                  "on-tertiary-fixed": "#131b2e",
                  "surface-variant": "#323537",
                  "tertiary-container": "#8c93ac",
                  "surface-container-lowest": "#0b0f10",
                  "on-primary": "#5c1900",
                  "background": "#101415",
                  "tertiary-fixed-dim": "#bec6e0",
                  "inverse-on-surface": "#2d3133",
                  "error-container": "#93000a",
                  "on-primary-fixed-variant": "#832700",
                  "surface": "#101415",
                  "on-primary-fixed": "#390c00",
                  "surface-container-high": "#272a2c",
                  "primary": "#ffb59c",
                  "on-secondary": "#562000",
                  "secondary-fixed-dim": "#ffb693",
                  "tertiary-fixed": "#dae2fd"
          },
          "borderRadius": {
                  "DEFAULT": "1rem",
                  "lg": "2rem",
                  "xl": "3rem",
                  "full": "9999px"
          },
          "spacing": {
                  "gutter": "24px",
                  "margin-mobile": "20px",
                  "border-opacity": "0.1",
                  "stack-md": "16px",
                  "margin-desktop": "80px",
                  "stack-lg": "32px",
                  "container-max": "1440px",
                  "stack-sm": "8px",
                  "glass-blur": "20px"
          },
          "fontFamily": {
                  "headline-lg": ["Sora"],
                  "body-md": ["Inter"],
                  "label-sm": ["Inter"],
                  "headline-md": ["Sora"],
                  "headline-lg-mobile": ["Sora"],
                  "body-lg": ["Inter"],
                  "display-xl": ["Sora"]
          },
          "fontSize": {
                  "headline-lg": ["40px", {"lineHeight": "1.2", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                  "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}],
                  "label-sm": ["12px", {"lineHeight": "1", "letterSpacing": "0.05em", "fontWeight": "600"}],
                  "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}],
                  "headline-lg-mobile": ["32px", {"lineHeight": "1.2", "fontWeight": "600"}],
                  "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}],
                  "display-xl": ["64px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700"}]
          }
        },
      },
    }
  </script>
<style>
body {
	background-color: #101415;
	color: #e0e3e5;
	-webkit-font-smoothing: antialiased;
}

.glass-card {
	background: rgba(29, 32, 34, 0.6);
	backdrop-filter: blur(20px);
	-webkit-backdrop-filter: blur(20px);
	border: 1px solid rgba(255, 255, 255, 0.08);
}

.primary-glow {
	background: linear-gradient(135deg, #ff5f1f 0%, #ff8c5a 100%);
	box-shadow: 0 10px 25px -5px rgba(255, 95, 31, 0.4);
}

.shimmer-btn {
	position: relative;
	overflow: hidden;
}

.shimmer-btn::after {
	content: '';
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1),
		transparent);
	transform: rotate(45deg);
	animation: shimmer 4s infinite;
}

@
keyframes shimmer { 0% {
	transform: translateX(-100%) rotate(45deg);
}

100
%
{
transform
:
translateX(
100%
)
rotate(
45deg
);
}
}
.ambient-glow {
	position: absolute;
	width: 400px;
	height: 400px;
	background: radial-gradient(circle, rgba(255, 95, 31, 0.08) 0%,
		transparent 70%);
	pointer-events: none;
	z-index: 0;
}

.custom-scrollbar::-webkit-scrollbar {
	width: 4px;
}

.custom-scrollbar::-webkit-scrollbar-track {
	background: transparent;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
	background: rgba(255, 255, 255, 0.1);
	border-radius: 10px;
}
</style>
<style>
body {
	min-height: max(884px, 100dvh);
}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen flex flex-col font-body-md overflow-x-hidden">
	<div class="ambient-glow top-[-100px] left-[-100px]"></div>
	<div class="ambient-glow bottom-[100px] right-[-100px]"></div>
	<!-- TopAppBar mapping -->
	<header
		class="fixed top-0 w-full z-50 bg-surface/60 dark:bg-surface-container/60 backdrop-blur-glass-blur border-b border-white/10 dark:border-white/5 shadow-[0_20px_40px_rgba(255,95,31,0.05)] h-16 flex items-center justify-between px-margin-mobile md:px-margin-desktop">
		<div class="flex items-center gap-4">
			<a href="callRestaurantServlet"
				style="color: #ffb59c; text-decoration: none; font-size: 13px;">&#8592;
				Restaurants</a>
			<h1
				class="font-display-xl text-headline-md tracking-tighter text-primary dark:text-primary-container">FlavorNest</h1>
		</div>
		<div class="flex items-center gap-6">
			<a href="orderHistory"
				class="hidden md:flex font-label-sm text-label-sm text-on-surface-variant hover:text-primary transition-colors">My
				Orders</a> <a href="logoutServlet"
				class="hidden md:flex font-label-sm text-label-sm text-on-surface-variant hover:text-error transition-colors">Logout</a>
			<button
				class="material-symbols-outlined text-primary hover:opacity-80 transition-opacity active:scale-95 transition-transform"
				data-icon="shopping_cart">shopping_cart</button>
		</div>
	</header>
	<main
		class="flex-grow pt-24 pb-32 px-margin-mobile md:px-margin-desktop max-w-container-max mx-auto w-full relative z-10">
		<!-- Header Title Section -->
		<div class="flex items-end justify-between mb-stack-lg">
			<div>
				<span
					class="font-label-sm text-label-sm text-primary uppercase tracking-[0.2em] mb-2 block">Checkout
					Session</span>
				<h2
					class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Your
					Feast</h2>
			</div>
			<form action="cartServlet" method="post">

				<input type="hidden" name="action" value="clear">

				<button type="submit"
					class="font-label-sm text-label-sm text-on-surface-variant hover:text-error transition-colors flex items-center gap-2 mb-2 group">

					<span
						class="material-symbols-outlined text-[18px] group-hover:rotate-12 transition-transform">
						delete_sweep </span> Clear All

				</button>

			</form>
		</div>
		<div class="grid grid-cols-1 lg:grid-cols-12 gap-stack-lg items-start">
			<!-- Cart Items List -->
			<section class="lg:col-span-7 space-y-stack-md">

				<%
				Cart cart = (Cart) session.getAttribute("cart");

				BigDecimal subtotal = BigDecimal.ZERO;
				BigDecimal tax = BigDecimal.ZERO;
				BigDecimal discount = new BigDecimal("5.00");
				BigDecimal total = BigDecimal.ZERO;

				if (cart != null && !cart.getItems().isEmpty()) {

					for (CartItem item : cart.getItems().values()) {

						BigDecimal itemTotal = item.getPrice().multiply(new BigDecimal(item.getQuantity()));

						subtotal = subtotal.add(itemTotal);
						int currentQty = item.getQuantity();
						int decreaseQty = Math.max(1, currentQty - 1);
						int increaseQty = currentQty + 1;
				%>



				<div
					class="glass-card rounded-lg p-6 flex justify-between items-center group hover:border-primary/20 transition-all duration-300">


					<div class="flex-grow pr-4">


						<div class="flex items-center gap-2 mb-1">

							<span class="w-2 h-2 rounded-full bg-error"></span>


							<h3 class="font-headline-md text-[18px] text-on-surface">

								<%=item.getName()%>

							</h3>

						</div>



						<p class="text-on-surface-variant text-body-md text-sm mb-4">

							Freshly prepared restaurant special dish</p>



						<div class="flex items-center gap-6">


							<span class="font-headline-md text-primary text-xl"> ₹ <%=item.getPrice()%>

							</span>

							<div class="flex items-center gap-3">

								<!-- Decrease -->

								<form action="cartServlet" method="post">

									<input type="hidden" name="action" value="update"> <input
										type="hidden" name="MenuID" value="<%=item.getMenuID()%>">

									<input type="hidden" name="quantity" value="<%=decreaseQty%>">

									<button type="submit"
										class="w-8 h-8 rounded-full bg-red-500 text-white text-lg">
										-</button>

								</form>


								<!-- Quantity -->

								<span class="text-white font-bold text-lg"> <%=currentQty%>
								</span>


								<!-- Increase -->

								<form action="cartServlet" method="post">

									<input type="hidden" name="action" value="update"> <input
										type="hidden" name="MenuID" value="<%=item.getMenuID()%>">

									<input type="hidden" name="quantity" value="<%=increaseQty%>">

									<button type="submit"
										class="w-8 h-8 rounded-full bg-green-500 text-white text-lg">
										+</button>

								</form>

							</div>

						</div>


					</div>



					<form action="cartServlet" method="post">


						<input type="hidden" name="action" value="delete"> <input
							type="hidden" name="MenuID" value="<%=item.getMenuID()%>">


						<button class="text-error">

							<span class="material-symbols-outlined"> delete </span>

						</button>


					</form>



				</div>



				<%
				}
				tax = subtotal.multiply(new BigDecimal("0.05"));

				total = subtotal.add(tax).subtract(discount);
				}

				else {
				%>


				<div class="glass-card rounded-lg p-10 text-center">

					<h3 class="text-xl text-white">Your Cart is Empty</h3>
					<p>Please add some food items from the menu.</p>
					<a class="checkout-btn" href="callRestaurantServlet">Browse
						Restaurants</a>

				</div>


				<%
				}
				%>
				<%
				Integer currentRestaurantID = (Integer) session.getAttribute("CurrentRestaurantID");
				%>

				<%
				if (currentRestaurantID != null) {
				%>

				<div class="mt-6 text-center">

					<a
						href="<%=request.getContextPath()%>/MenuServlet?RestaurantID=<%=currentRestaurantID%>"
						class="inline-flex items-center gap-2 bg-orange-500 hover:bg-orange-600 text-white font-semibold px-6 py-3 rounded-lg transition-all">

						<span class="material-symbols-outlined">add</span> Add More Items

					</a>

				</div>

				<%
				}
				%>


			</section>
			<!-- Billing Section -->
			<aside class="lg:col-span-5 sticky top-24">
				<div class="glass-card rounded-lg overflow-hidden shadow-2xl">
					<div class="p-6 border-b border-white/5">
						<h3
							class="font-headline-md text-on-surface flex items-center gap-2">
							<span class="material-symbols-outlined text-primary">receipt_long</span>
							Order Summary
						</h3>
					</div>
					<div class="p-6 space-y-4">
						<div class="flex justify-between text-body-md">
							<span class="text-on-surface-variant">Subtotal</span> <span
								class="text-on-surface font-semibold">₹ <%=subtotal%></span>
						</div>
						<div class="flex justify-between text-body-md items-center">
							<div class="flex items-center gap-2">
								<span class="text-on-surface-variant">Elite Delivery Fee</span>
								<span
									class="bg-primary/20 text-primary text-[10px] font-black px-2 py-0.5 rounded-full uppercase tracking-tighter">Elite</span>
							</div>
							<span class="text-primary font-bold">FREE</span>
						</div>
						<div class="flex justify-between text-body-md">
							<span class="text-on-surface-variant">Taxes &amp;
								Processing</span> <span class="text-on-surface">₹ <%=tax%></span>
						</div>
						<div class="flex justify-between text-body-md">
							<span class="text-on-surface-variant">Platform Discount</span> <span
								class="text-secondary-fixed">₹ <%=discount%></span>
						</div>
						<div
							class="pt-4 mt-4 border-t border-white/5 flex justify-between items-end">
							<div>
								<p
									class="text-[10px] text-on-surface-variant uppercase font-bold tracking-widest mb-1">Estimated
									Total</p>
								<p
									class="font-display-xl text-primary-container text-4xl leading-none">
									₹
									<%=total%></p>
							</div>
							<div class="text-right">
								<p class="text-[12px] text-secondary">
									Saving ₹
									<%=discount%></p>
								<p class="text-[10px] text-on-surface-variant">Incl. all
									taxes</p>
							</div>
						</div>
					</div>
					<div class="p-6 bg-surface-container-highest/40">
						<a href="checkout.jsp"
							class="shimmer-btn primary-glow w-full py-5 rounded-lg flex items-center justify-center gap-4 text-on-primary-container font-headline-md text-lg active:scale-95 transition-all group text-center">
							Proceed to Checkout <span
							class="material-symbols-outlined group-hover:translate-x-2 transition-transform">arrow_forward</span>
						</a>
						<p
							class="text-center text-[11px] text-on-surface-variant mt-4 opacity-60">Secure
							SSL encrypted checkout via Crave Pay</p>
					</div>
				</div>
				<!-- Elite Promotion Card -->
				<div
					class="mt-stack-md glass-card p-4 rounded-lg flex items-center gap-4 border-primary/30 relative overflow-hidden group">
					<div
						class="absolute right-0 top-0 w-24 h-24 bg-primary/10 rounded-full blur-3xl group-hover:scale-150 transition-transform duration-1000"></div>
					<div
						class="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center text-primary flex-shrink-0">
						<span class="material-symbols-outlined"
							style="font-variation-settings: 'FILL' 1;">workspace_premium</span>
					</div>
					<div>
						<p class="text-sm font-bold text-primary">Elite Membership
							Active</p>
						<p class="text-xs text-on-surface-variant">
							You've saved ₹
							<%=discount%>
							on this order today.
						</p>
					</div>
				</div>
			</aside>
		</div>
	</main>
	<footer
		class="bg-surface-container-lowest dark:bg-surface-container-lowest w-full py-12 px-margin-mobile md:px-margin-desktop border-t border-outline-variant/20 flex flex-col md:flex-row justify-between items-center gap-stack-lg mb-20 md:mb-0 relative z-10">
		<div class="flex flex-col items-center md:items-start">
			<span class="font-headline-md text-primary font-black mb-2">FlavorNest</span>
			<p
				class="font-body-md text-body-md text-on-surface-variant text-center md:text-left">©
				2026 FlavorNest Elite Dining. All rights reserved.</p>
		</div>
		<div class="flex gap-stack-lg">

			class="font-label-sm text-label-sm text-on-surface-variant
			hover:text-primary transition-colors" href="#">Privacy Policy</a>
			class="font-label-sm text-label-sm text-on-surface-variant
			hover:text-primary transition-colors" href="#">Terms of Service</a>
			class="font-label-sm text-label-sm text-on-surface-variant
			hover:text-primary transition-colors" href="#">Partner with Us</a>
		</div>
	</footer>
	<!-- BottomNavBar mapping -->
	<nav
		class="fixed bottom-6 left-1/2 -translate-x-1/2 w-[90%] md:w-[400px] rounded-xl bg-surface-container-low/80 dark:bg-surface-container-lowest/80 backdrop-blur-glass-blur border border-white/10 shadow-2xl z-[60] md:hidden">
		<div class="flex justify-around items-center h-16 px-4">
			<a href="${pageContext.request.contextPath}/callRestaurantServlet"
				class="flex flex-col items-center justify-center text-on-surface-variant hover:text-primary transition-colors">
				<span class="material-symbols-outlined">home</span> <span
				class="font-label-sm text-label-sm">Home</span>
			</a>
			<div
				class="flex flex-col items-center justify-center text-on-surface-variant opacity-60 hover:text-primary transition-colors cursor-pointer">
				<span class="material-symbols-outlined">search</span> <span
					class="font-label-sm text-label-sm">Search</span>
			</div>
			<div
				class="flex flex-col items-center justify-center text-primary-container bg-primary/10 rounded-full px-4 py-1 shadow-[0_0_15px_rgba(255,95,31,0.3)] scale-90 transition-all duration-300">
				<span class="material-symbols-outlined">shopping_cart</span> <span
					class="font-label-sm text-label-sm">Cart</span>
			</div>
			<div
				class="flex flex-col items-center justify-center text-on-surface-variant opacity-60 hover:text-primary transition-colors cursor-pointer">
				<span class="material-symbols-outlined">person</span> <span
					class="font-label-sm text-label-sm">Profile</span>
			</div>
		</div>
	</nav>
	<script>
    // Simple micro-interaction for quantity buttons
    document.querySelectorAll('.material-symbols-outlined').forEach(icon => {
      if(icon.innerText === 'add' || icon.innerText === 'remove') {
        icon.parentElement.addEventListener('click', (e) => {
          const span = icon.parentElement.querySelector('span:not(.material-symbols-outlined)');
          if(span) {
            let val = parseInt(span.innerText);
            if(icon.innerText === 'add') val++;
            if(icon.innerText === 'remove' && val > 0) val--;
            span.innerText = val;
            
            // Visual feedback
            icon.classList.add('scale-125', 'text-primary');
            setTimeout(() => {
              icon.classList.remove('scale-125', 'text-primary');
            }, 200);
          }
        });
      }
    });

    // Inertia entry animations for cards
    const cards = document.querySelectorAll('.glass-card');
    const observerOptions = {
      threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry, index) => {
        if (entry.isIntersecting) {
          entry.target.style.opacity = '1';
          entry.target.style.transform = 'translateY(0)';
          entry.target.style.transition = `all 0.6s cubic-bezier(0.2, 0.8, 0.2, 1) ${index * 0.1}s`;
        }
      });
    }, observerOptions);

    cards.forEach(card => {
      card.style.opacity = '0';
      card.style.transform = 'translateY(20px)';
      observer.observe(card);
    });
  </script>
</body>
</html>