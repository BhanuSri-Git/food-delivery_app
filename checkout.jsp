<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.food.Model.Cart"%>
<%@ page import="com.food.Model.User"%>
<%@ page import="com.food.Model.CartItem"%>
<%
// Ensure user is logged in
User loggedInUser = (User) session.getAttribute("loggedInUser");

if (loggedInUser == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Integer currentRestaurantID = (Integer) session.getAttribute("CurrentRestaurantID");

String backToMenuURL;

if (currentRestaurantID != null) {
    backToMenuURL = request.getContextPath()
            + "/MenuServlet?RestaurantID=" + currentRestaurantID;
} else {
    backToMenuURL = request.getContextPath()
            + "/callRestaurantServlet";
}

// Retrieve cart from session (Cart object)
Cart cart = (Cart) session.getAttribute("cart");
if (cart == null || cart.isEmpty()) {
	// Redirect to menu if cart is empty
	response.sendRedirect(request.getContextPath() + "/menu.jsp");
	return;
}

// Compute totals
java.math.BigDecimal subtotal = new java.math.BigDecimal("0");
int totalItems = 0;
for (CartItem it : cart.getItems().values()) {
	if (it != null && it.getPrice() != null) {
		java.math.BigDecimal qty = new java.math.BigDecimal(it.getQuantity());
		subtotal = subtotal.add(it.getPrice().multiply(qty));
		totalItems += it.getQuantity();
	}
}
// Example fixed delivery fee and taxes — adjust as needed in CheckoutServlet
java.math.BigDecimal deliveryFee = new java.math.BigDecimal("30.00");
java.math.BigDecimal tax = subtotal.multiply(new java.math.BigDecimal("0.05")); // 5% tax
java.math.BigDecimal discount = new java.math.BigDecimal("5.00"); // Platform discount
java.math.BigDecimal total = subtotal.add(deliveryFee).add(tax).subtract(discount);
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout | FlavorNest</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&amp;family=Inter:wght@400;500;600&amp;family=JetBrains+Mono:wght@400;600&amp;family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
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
                  "body-lg": ["Inter"],
                  "mono": ["JetBrains Mono", "monospace"]
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
html { scroll-behavior: smooth; }

.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
}

::selection { background: #ff6b35; color: #101415; }

/* ---- Ambient backdrop, matched to the rest of FlavorNest ---- */
.bg-mesh {
	position: fixed; inset: 0; z-index: -3; background-color: #0b0e10;
	background-image:
		radial-gradient(ellipse 80% 60% at 15% 0%, rgba(255, 107, 53, 0.16) 0%, transparent 60%),
		radial-gradient(ellipse 70% 60% at 90% 10%, rgba(255, 140, 95, 0.10) 0%, transparent 55%),
		radial-gradient(ellipse 70% 70% at 50% 100%, rgba(140, 147, 172, 0.10) 0%, transparent 55%),
		linear-gradient(180deg, #0b0e10 0%, #0f1315 50%, #0b0e10 100%);
}
.bg-grid {
	position: fixed; inset: 0; z-index: -2;
	background-image: linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px);
	background-size: 44px 44px;
	-webkit-mask-image: radial-gradient(ellipse 65% 60% at 50% 20%, black 0%, transparent 75%);
	mask-image: radial-gradient(ellipse 65% 60% at 50% 20%, black 0%, transparent 75%);
}
.ambient-glow {
	position: fixed; width: 560px; height: 560px; z-index: -1; filter: blur(90px); border-radius: 50%;
	background: radial-gradient(circle, rgba(255,107,53,0.10) 0%, transparent 70%);
	animation: drift 18s ease-in-out infinite;
}
.ambient-glow.glow-b { background: radial-gradient(circle, rgba(140,147,172,0.10) 0%, transparent 70%); animation-duration: 22s; animation-delay: -6s; }
@keyframes drift {
	0%, 100% { transform: translate(0,0) scale(1); }
	50% { transform: translate(24px,-18px) scale(1.06); }
}

/* ---- Layered glass shell: depth via two stacked translucency levels ---- */
.glass-shell {
	position: relative;
	background: linear-gradient(155deg, rgba(255,255,255,0.055) 0%, rgba(255,255,255,0.02) 100%);
	backdrop-filter: blur(22px);
	-webkit-backdrop-filter: blur(22px);
	border-radius: 1.5rem;
	box-shadow: 0 24px 60px -20px rgba(0,0,0,0.55), inset 0 1px 0 rgba(255,255,255,0.06);
}
.glass-shell::before {
	content: '';
	position: absolute; inset: 0; border-radius: inherit; padding: 1px;
	background: linear-gradient(155deg, rgba(255,255,255,0.16), rgba(255,255,255,0.02) 40%, rgba(255,107,53,0.12) 100%);
	-webkit-mask: linear-gradient(#000 0 0) content-box, linear-gradient(#000 0 0);
	-webkit-mask-composite: xor; mask-composite: exclude;
	pointer-events: none;
}

.step-badge {
	width: 2.1rem; height: 2.1rem; border-radius: 9999px;
	background: linear-gradient(135deg, #ff6b35 0%, #ff8c5f 100%);
	box-shadow: 0 6px 18px -4px rgba(255,107,53,0.55);
	color: white; font-weight: 800; font-size: 0.85rem; font-family: 'JetBrains Mono', monospace;
	display: flex; align-items: center; justify-content: center;
	flex-shrink: 0;
}
.step-connector {
	width: 1.5px; flex: 1; min-height: 28px;
	background: linear-gradient(180deg, rgba(255,107,53,0.5), rgba(255,107,53,0.05));
	margin: 6px 0 6px calc(1.05rem - 0.75px);
}

.field-wrap { position: relative; }
.field,
input.field,
select.field {
	width: 100%;
	margin-top: 0.4rem;
	padding: 0.85rem 1rem;
	border-radius: 0.85rem;
	background-color: #1b1e20 !important;
	border: 1.5px solid rgba(255, 255, 255, 0.09);
	color: #f2f0ee !important;
	font-size: 0.9rem;
	transition: border-color .18s ease, box-shadow .18s ease, background .18s ease;
	-webkit-text-fill-color: #f2f0ee;
	caret-color: #ff6b35;
	color-scheme: dark;
}
.field::placeholder { color: rgba(224, 227, 229, 0.32); }
.field:focus {
	outline: none;
	border-color: rgba(255, 107, 53, 0.65);
	background-color: #211c18 !important;
	box-shadow: 0 0 0 4px rgba(255, 107, 53, 0.12);
}
.field:focus + .field-glow { opacity: 1; }

/* Kill the browser's white/yellow autofill background */
.field:-webkit-autofill,
.field:-webkit-autofill:hover,
.field:-webkit-autofill:focus {
	-webkit-text-fill-color: #f2f0ee;
	-webkit-box-shadow: 0 0 0 1000px #1b1e20 inset;
	box-shadow: 0 0 0 1000px #1b1e20 inset;
	caret-color: #ff6b35;
	transition: background-color 9999s ease-in-out 0s;
}
.field-label {
	font-size: 0.68rem; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase;
	color: #b89b8f;
}

/* ---- Payment tiles ---- */
.pay-tile { position: relative; }
.pay-tile input { position: absolute; opacity: 0; width: 0; height: 0; }
.pay-tile label {
	display: flex; align-items: center; gap: 0.9rem;
	padding: 1rem 1.1rem;
	border-radius: 1rem;
	border: 1.5px solid rgba(255, 255, 255, 0.09);
	background: rgba(255, 255, 255, 0.03);
	cursor: pointer;
	transition: all .18s ease;
	font-weight: 600;
	font-size: 0.88rem;
	color: #d8c8c0;
}
.pay-tile label:hover { border-color: rgba(255, 107, 53, 0.35); background: rgba(255,255,255,0.045); }
.pay-tile .icon-tile {
	width: 2.4rem; height: 2.4rem; border-radius: 0.7rem; flex-shrink: 0;
	display: flex; align-items: center; justify-content: center;
	background: rgba(255,255,255,0.05); color: #e3bfb3;
	transition: all .18s ease;
}
.pay-tile input:checked + label {
	border-color: #ff6b35;
	background: linear-gradient(135deg, rgba(255,107,53,0.10), rgba(255,107,53,0.03));
	color: #ffdbcf;
	box-shadow: 0 8px 24px -8px rgba(255,107,53,0.4);
}
.pay-tile input:checked + label .icon-tile { background: #ff6b35; color: white; }
.pay-tile .check {
	margin-left: auto; width: 20px; height: 20px; border-radius: 9999px;
	border: 2px solid rgba(255,255,255,0.2); flex-shrink: 0;
	display: flex; align-items: center; justify-content: center;
}
.pay-tile input:checked + label .check { border-color: #ff6b35; }
.pay-tile input:checked + label .check::after {
	content: ''; width: 10px; height: 10px; border-radius: 9999px; background: #ff6b35;
}

/* ---- The ticket: signature element for the order summary ---- */
.ticket {
	position: relative;
	background: linear-gradient(160deg, rgba(255,255,255,0.06) 0%, rgba(255,255,255,0.02) 100%);
	backdrop-filter: blur(22px);
	-webkit-backdrop-filter: blur(22px);
	border-radius: 1.5rem;
	box-shadow: 0 24px 60px -20px rgba(0,0,0,0.6), inset 0 1px 0 rgba(255,255,255,0.07);
}
.ticket::before {
	content: '';
	position: absolute; inset: 0; border-radius: inherit; padding: 1px;
	background: linear-gradient(160deg, rgba(255,255,255,0.18), rgba(255,255,255,0.02) 45%, rgba(255,107,53,0.14) 100%);
	-webkit-mask: linear-gradient(#000 0 0) content-box, linear-gradient(#000 0 0);
	-webkit-mask-composite: xor; mask-composite: exclude;
	pointer-events: none;
}
.ticket-perf {
	position: relative;
	height: 14px;
	background-image: radial-gradient(circle at 14px 0, transparent 10px, transparent 10.5px);
	background-size: 28px 14px;
	background-repeat: repeat-x;
	-webkit-mask-image: radial-gradient(circle 9px at 14px 7px, transparent 98%, black 100%);
	mask-image: radial-gradient(circle 9px at 14px 7px, transparent 98%, black 100%);
	mask-composite: exclude;
	-webkit-mask-composite: destination-out;
	background-color: rgba(11,14,16,1);
}
.ticket-notch-l, .ticket-notch-r {
	position: absolute; width: 24px; height: 24px; border-radius: 50%;
	background: #0b0e10; top: 50%; transform: translateY(-50%); z-index: 2;
}
.ticket-notch-l { left: -12px; }
.ticket-notch-r { right: -12px; }
.ticket-divider {
	border-top: 1.5px dashed rgba(255,255,255,0.14);
}
.price-mono { font-family: 'JetBrains Mono', monospace; font-variant-numeric: tabular-nums; }

.cart-scroll { scrollbar-width: thin; scrollbar-color: rgba(255,107,53,0.35) transparent; }
.cart-scroll::-webkit-scrollbar { width: 5px; }
.cart-scroll::-webkit-scrollbar-thumb { background: rgba(255,107,53,0.35); border-radius: 9999px; }

.primary-glow {
	background: linear-gradient(135deg, #ff6b35 0%, #ff8c5f 100%);
	box-shadow: 0 10px 32px -6px rgba(255, 107, 53, 0.5);
}

@keyframes fadeUp {
	from { opacity: 0; transform: translateY(18px); }
	to { opacity: 1; transform: translateY(0); }
}
.reveal { animation: fadeUp .65s cubic-bezier(.2,.7,.2,1) forwards; opacity: 0; }

@media (prefers-reduced-motion: reduce) {
	.reveal, .ambient-glow { animation: none !important; opacity: 1 !important; }
}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="bg-background text-on-background overflow-x-hidden font-body-md">

	<div class="bg-mesh"></div>
	<div class="bg-grid"></div>
	<div class="ambient-glow -top-40 -left-40"></div>
	<div class="ambient-glow glow-b -bottom-40 -right-32"></div>

	<!-- Top bar -->
	<header class="bg-surface/60 backdrop-blur-[20px] sticky top-0 z-50 border-b border-white/5">
		<nav class="flex items-center px-margin-mobile md:px-margin-desktop h-20 w-full max-w-container-max mx-auto gap-4">
			<span class="w-9 h-9 rounded-lg flex items-center justify-center text-sm font-bold primary-glow text-white">F</span>
			<span class="font-headline-md text-headline-md font-bold text-on-surface">FlavorNest</span>
			<span class="ml-3 text-on-surface-variant text-sm hidden sm:inline">/ Checkout</span>
		</nav>
	</header>

	<main class="px-margin-mobile md:px-margin-desktop py-10 md:py-14">
		<div class="max-w-container-max mx-auto">

			<div class="mb-10 reveal">
				<a href="<%=backToMenuURL%>" class="inline-flex items-center gap-1 text-sm font-semibold text-on-surface-variant hover:text-primary-container transition-colors">
					<span class="material-symbols-outlined text-base">arrow_back</span> Back to menu
				</a>
				<h1 class="font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface mt-3">Checkout</h1>
				<p class="text-on-surface-variant mt-1 text-sm">Confirm your delivery details and we'll get your ticket moving.</p>
			</div>

			<form id="checkoutForm" action="<%=request.getContextPath()%>/checkoutServlet" method="post">
				<input type="hidden" name="subtotal" value="<%=subtotal%>">
				<input type="hidden" name="deliveryFee" value="<%=deliveryFee%>">
				<input type="hidden" name="tax" value="<%=tax%>">
				<input type="hidden" name="discount" value="<%=discount%>">
				<input type="hidden" name="total" value="<%=total%>">

				<div class="grid grid-cols-1 lg:grid-cols-5 gap-gutter items-start">

					<!-- LEFT: Delivery + Payment -->
					<div class="lg:col-span-3">

						<div class="flex gap-5">
							<!-- Step rail -->
							<div class="hidden sm:flex flex-col items-center pt-7">
								<div class="step-badge">1</div>
								<div class="step-connector"></div>
								<div class="step-badge">2</div>
							</div>

							<div class="flex-1 space-y-6 min-w-0">

								<!-- Delivery Address -->
								<div class="glass-shell reveal p-6 sm:p-8" style="animation-delay:.05s;">
									<div class="flex items-center gap-3 mb-6 sm:hidden">
										<div class="step-badge">1</div>
										<h2 class="font-headline-md text-headline-md text-on-surface">Delivery address</h2>
									</div>
									<h2 class="hidden sm:block font-headline-md text-headline-md text-on-surface mb-6">Delivery address</h2>

									<div class="grid grid-cols-1 sm:grid-cols-2 gap-x-4 gap-y-4">
										<div class="sm:col-span-2 field-wrap">
											<label class="field-label">Full name</label>
											<input type="text" name="fullName" value="<%=loggedInUser.getUserName()%>" required class="field">
										</div>

										<div class="sm:col-span-2 field-wrap">
											<label class="field-label">Phone</label>
											<input type="tel" name="phone" value="" required placeholder="10-digit mobile number" class="field">
										</div>

										<div class="sm:col-span-2 field-wrap">
											<label class="field-label">House / Flat / Building</label>
											<input type="text" name="addressLine1"
												value="<%=loggedInUser.getAddress() != null ? loggedInUser.getAddress() : ""%>"
												required class="field">
										</div>

										<div class="sm:col-span-2 field-wrap">
											<label class="field-label">Area / Street</label>
											<input type="text" name="addressLine2" required class="field">
										</div>

										<div class="field-wrap">
											<label class="field-label">City</label>
											<input type="text" name="city" required class="field">
										</div>

										<div class="field-wrap">
											<label class="field-label">Pincode</label>
											<input type="text" name="pincode" required pattern="\d{6}" title="6 digit pincode" class="field">
										</div>
									</div>
								</div>

								<!-- Payment Method -->
								<div class="glass-shell reveal p-6 sm:p-8" style="animation-delay:.12s;">
									<div class="flex items-center gap-3 mb-6 sm:hidden">
										<div class="step-badge">2</div>
										<h2 class="font-headline-md text-headline-md text-on-surface">Payment method</h2>
									</div>
									<h2 class="hidden sm:block font-headline-md text-headline-md text-on-surface mb-6">Payment method</h2>

									<div class="space-y-3">
										<div class="pay-tile">
											<input type="radio" id="pay-cod" name="paymentMethod" value="COD" checked>
											<label for="pay-cod">
												<span class="icon-tile"><span class="material-symbols-outlined text-lg">payments</span></span>
												Cash on Delivery
												<span class="check"></span>
											</label>
										</div>
										<div class="pay-tile">
											<input type="radio" id="pay-upi" name="paymentMethod" value="UPI">
											<label for="pay-upi">
												<span class="icon-tile"><span class="material-symbols-outlined text-lg">qr_code_2</span></span>
												UPI (PhonePe / GPay / Paytm)
												<span class="check"></span>
											</label>
										</div>
										<div class="pay-tile">
											<input type="radio" id="pay-card" name="paymentMethod" value="CARD">
											<label for="pay-card">
												<span class="icon-tile"><span class="material-symbols-outlined text-lg">credit_card</span></span>
												Credit / Debit Card
												<span class="check"></span>
											</label>
										</div>
										<div class="pay-tile">
											<input type="radio" id="pay-netbanking" name="paymentMethod" value="NETBANKING">
											<label for="pay-netbanking">
												<span class="icon-tile"><span class="material-symbols-outlined text-lg">account_balance</span></span>
												Net Banking
												<span class="check"></span>
											</label>
										</div>
										<div class="pay-tile">
											<input type="radio" id="pay-wallet" name="paymentMethod" value="WALLET">
											<label for="pay-wallet">
												<span class="icon-tile"><span class="material-symbols-outlined text-lg">account_balance_wallet</span></span>
												Wallet
												<span class="check"></span>
											</label>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>

					<!-- RIGHT: The Ticket (order summary) -->
					<div class="lg:col-span-2">
						<div class="ticket reveal lg:sticky lg:top-28" style="animation-delay:.18s;">

							<div class="p-6 sm:p-7 pb-5">
								<div class="flex items-center justify-between mb-1">
									<h2 class="font-headline-md text-headline-md text-on-surface">Your ticket</h2>
									<span class="material-symbols-outlined text-primary-container">confirmation_number</span>
								</div>
								<p class="text-xs text-on-surface-variant"><%=totalItems%> item<%=totalItems == 1 ? "" : "s"%> &middot; FlavorNest Express</p>
							</div>

							<div class="px-6 sm:px-7 space-y-3 max-h-56 overflow-y-auto cart-scroll mb-1">
								<%
								for (CartItem it : cart.getItems().values()) {
								%>
								<div class="flex justify-between items-start gap-3 pb-3 border-b border-white/5 last:border-0 last:pb-0">
									<div>
										<p class="font-semibold text-on-surface text-sm"><%=it.getName()%></p>
										<p class="text-xs text-on-surface-variant/70">Qty: <%=it.getQuantity()%></p>
									</div>
									<p class="price-mono font-bold text-on-surface text-sm whitespace-nowrap">
										&#8377;<%=it.getPrice().multiply(new java.math.BigDecimal(it.getQuantity())).setScale(2, java.math.RoundingMode.HALF_UP)%>
									</p>
								</div>
								<%
								}
								%>
							</div>

							<!-- Perforated tear between items and totals -->
							<div class="relative">
								<span class="ticket-notch-l"></span>
								<span class="ticket-notch-r"></span>
								<div class="ticket-perf"></div>
							</div>

							<div class="px-6 sm:px-7 pt-4 space-y-2 text-sm">
								<div class="flex justify-between text-on-surface-variant">
									<span>Subtotal</span><span class="price-mono">&#8377;<%=subtotal.setScale(2, java.math.RoundingMode.HALF_UP)%></span>
								</div>
								<div class="flex justify-between text-on-surface-variant">
									<span>Delivery fee</span><span class="price-mono">&#8377;<%=deliveryFee.setScale(2, java.math.RoundingMode.HALF_UP)%></span>
								</div>
								<div class="flex justify-between text-on-surface-variant">
									<span>Tax (5%)</span><span class="price-mono">&#8377;<%=tax.setScale(2, java.math.RoundingMode.HALF_UP)%></span>
								</div>
								<div class="flex justify-between text-green-400">
									<span>Discount</span><span class="price-mono">-&#8377;<%=discount.setScale(2, java.math.RoundingMode.HALF_UP)%></span>
								</div>
							</div>

							<div class="mx-6 sm:mx-7 ticket-divider mt-4"></div>

							<div class="px-6 sm:px-7 pt-4 pb-6 sm:pb-7">
								<div class="flex justify-between items-center mb-6">
									<span class="font-extrabold text-on-surface">Total</span>
									<span class="price-mono font-extrabold text-2xl text-primary-container">
										&#8377;<%=total.setScale(2, java.math.RoundingMode.HALF_UP)%>
									</span>
								</div>

								<button type="submit"
									class="w-full py-4 rounded-full primary-glow text-white font-extrabold text-sm hover:brightness-110 hover:scale-[1.01] active:scale-[0.99] transition-all flex items-center justify-center gap-2">
									Place Order <span class="material-symbols-outlined text-lg">arrow_forward</span>
								</button>
								<p class="text-center text-xs text-on-surface-variant/60 mt-3">By placing this order you agree to our terms &amp; refund policy.</p>
							</div>
						</div>
					</div>

				</div>
			</form>
		</div>
	</main>

</body>
</html>
 