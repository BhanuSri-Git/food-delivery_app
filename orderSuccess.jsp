<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.food.Model.User"%>
<%@ page import="java.math.BigDecimal"%>
<%
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
Integer lastOrderID = (Integer) session.getAttribute("lastOrderID");
BigDecimal lastOrderTotal = (BigDecimal) session.getAttribute("lastOrderTotal");
BigDecimal lastOrderSubtotal = (BigDecimal) session.getAttribute("lastOrderSubtotal");
BigDecimal lastOrderTax = (BigDecimal) session.getAttribute("lastOrderTax");
BigDecimal lastOrderDiscount = (BigDecimal) session.getAttribute("lastOrderDiscount");
String lastOrderPaymentMethod = (String) session.getAttribute("lastOrderPaymentMethod");
Integer lastRestaurantID = (Integer) session.getAttribute("lastRestaurantID");

if (lastOrderID == null) {
	response.sendRedirect(request.getContextPath() + "/callRestaurantServlet");
	return;
}
// Clear after displaying so user can't reload and see stale data
session.removeAttribute("lastOrderID");
session.removeAttribute("lastOrderTotal");
session.removeAttribute("lastOrderSubtotal");
session.removeAttribute("lastOrderTax");
session.removeAttribute("lastOrderDiscount");
session.removeAttribute("lastOrderPaymentMethod");
session.removeAttribute("lastRestaurantID");
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Placed! | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<style>
body {
	background: #101415;
	font-family: 'Inter', sans-serif;
}

@keyframes pop {
	0% { transform: scale(0.5); opacity: 0; }
	70% { transform: scale(1.1); }
	100% { transform: scale(1); opacity: 1; }
}

@keyframes fadeUp {
	from { opacity: 0; transform: translateY(30px); }
	to { opacity: 1; transform: translateY(0); }
}

.pop {
	animation: pop 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}

.fade-up {
	animation: fadeUp 0.7s ease forwards;
	opacity: 0;
}

.delay-1 { animation-delay: 0.3s; }
.delay-2 { animation-delay: 0.5s; }
.delay-3 { animation-delay: 0.7s; }
.delay-4 { animation-delay: 0.9s; }

.glow-ring {
	box-shadow: 0 0 0 8px rgba(34, 197, 94, 0.15), 0 0 0 20px rgba(34, 197, 94, 0.08);
}

.step-complete {
	background-color: #22c55e !important;
	border-color: #22c55e !important;
	animation: none !important;
}

@keyframes slideIn {
	from { transform: scale(0.8); opacity: 0; }
	to { transform: scale(1); opacity: 1; }
}

.step-pending {
	animation: slideIn 0.3s ease;
}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body
	class="min-h-screen flex flex-col items-center justify-center p-6 text-white">

	<!-- Confetti dots background -->
	<div class="fixed inset-0 overflow-hidden pointer-events-none"
		aria-hidden="true">
		<div
			class="absolute top-10 left-1/4 w-2 h-2 bg-orange-500 rounded-full opacity-40"></div>
		<div
			class="absolute top-20 left-3/4 w-3 h-3 bg-green-500 rounded-full opacity-30"></div>
		<div
			class="absolute top-1/3 left-10 w-2 h-2 bg-yellow-400 rounded-full opacity-40"></div>
		<div
			class="absolute top-1/2 right-10 w-2 h-2 bg-pink-400 rounded-full opacity-30"></div>
		<div
			class="absolute bottom-20 left-1/3 w-3 h-3 bg-blue-400 rounded-full opacity-20"></div>
		<div
			class="absolute bottom-10 right-1/4 w-2 h-2 bg-orange-400 rounded-full opacity-40"></div>
	</div>

	<div class="max-w-md w-full text-center z-10">

		<!-- Success Icon -->
		<div
			class="pop mx-auto mb-8 w-28 h-28 rounded-full bg-green-500/20 border-2 border-green-500 flex items-center justify-center glow-ring">
			<svg class="w-14 h-14 text-green-400" fill="none"
				stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round"
					stroke-width="2.5" d="M5 13l4 4L19 7" />
            </svg>
		</div>

		<!-- Heading -->
		<h1 class="fade-up delay-1 text-4xl font-bold text-white mb-3"
			style="font-family: 'Sora', sans-serif;">Order Placed! &#127881;</h1>
		<p class="fade-up delay-1 text-gray-400 text-lg mb-8">Your food is
			being prepared with love.</p>

		<!-- Order Details Card -->
		<div
			class="fade-up delay-2 bg-white/5 border border-white/10 rounded-2xl p-6 mb-8 text-left space-y-4">

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Order ID</span> <span
					class="text-orange-400 font-bold text-lg">#FN-<%=lastOrderID%></span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Restaurant</span> <span
					class="text-white font-semibold">Restaurant #<%=lastRestaurantID%></span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Subtotal</span> <span
					class="text-white font-semibold">&#8377; <%=lastOrderSubtotal != null ? lastOrderSubtotal.setScale(2, java.math.RoundingMode.HALF_UP) : "\u2014"%></span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Tax (5%)</span> <span
					class="text-white font-semibold">&#8377; <%=lastOrderTax != null ? lastOrderTax.setScale(2, java.math.RoundingMode.HALF_UP) : "\u2014"%></span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Discount</span> <span
					class="text-green-400 font-semibold">-&#8377; <%=lastOrderDiscount%></span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Amount Paid</span> <span
					class="text-white font-semibold text-lg"> &#8377; <%=lastOrderTotal != null ? lastOrderTotal.setScale(2, java.math.RoundingMode.HALF_UP) : "\u2014"%>
				</span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Payment Method</span> <span
					class="text-white text-sm"><%=lastOrderPaymentMethod != null ? lastOrderPaymentMethod : "Cash on Delivery"%></span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Estimated Delivery</span> <span
					class="text-green-400 font-semibold text-sm">30&ndash;45 minutes</span>
			</div>

			<div class="border-t border-white/5"></div>

			<div class="flex items-center justify-between">
				<span class="text-gray-400 text-sm">Status</span> <span
					id="orderStatusBadge"
					class="inline-flex items-center gap-2 bg-orange-500/20 text-orange-400 text-xs font-bold px-3 py-1 rounded-full">
					<span id="statusDot"
					class="w-2 h-2 bg-orange-400 rounded-full animate-pulse"></span> <span
					id="statusText">Placed</span>
				</span>
			</div>
		</div>

		<!-- Order Tracking Steps -->
		<div
			class="fade-up delay-3 bg-white/5 border border-white/10 rounded-2xl p-6 mb-8">
			<h3
				class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-6">Order
				Progress</h3>
			<div class="space-y-4">
				<!-- Placed -->
				<div class="flex items-center gap-4">
					<div id="step-placed"
						class="w-10 h-10 rounded-full bg-green-500 flex items-center justify-center flex-shrink-0 step-complete">
						<svg class="w-5 h-5 text-white" fill="none" stroke="currentColor"
							viewBox="0 0 24 24">
                            <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7" />
                        </svg>
					</div>
					<div class="flex-grow">
						<p class="text-white font-semibold text-sm">Order Placed</p>
						<p class="text-gray-500 text-xs">Your order has been confirmed</p>
					</div>
					<span class="text-green-400 text-xs font-semibold">&#10003;
						Complete</span>
				</div>

				<!-- Preparing -->
				<div class="flex items-center gap-4">
					<div id="step-preparing"
						class="w-10 h-10 rounded-full bg-white/10 border-2 border-gray-600 flex items-center justify-center flex-shrink-0 step-pending">
						<span class="text-sm">&#127859;</span>
					</div>
					<div class="flex-grow">
						<p class="text-gray-300 font-semibold text-sm">Preparing</p>
						<p class="text-gray-500 text-xs">Your food is being prepared</p>
					</div>
					<span id="step-preparing-badge"
						class="text-gray-500 text-xs font-semibold">Pending</span>
				</div>

				<!-- Out for Delivery -->
				<div class="flex items-center gap-4">
					<div id="step-delivery"
						class="w-10 h-10 rounded-full bg-white/10 border-2 border-gray-600 flex items-center justify-center flex-shrink-0 step-pending">
						<span class="text-sm">&#128662;</span>
					</div>
					<div class="flex-grow">
						<p class="text-gray-300 font-semibold text-sm">Out for
							Delivery</p>
						<p class="text-gray-500 text-xs">Driver is on the way</p>
					</div>
					<span id="step-delivery-badge"
						class="text-gray-500 text-xs font-semibold">Pending</span>
				</div>

				<!-- Delivered -->
				<div class="flex items-center gap-4">
					<div id="step-delivered"
						class="w-10 h-10 rounded-full bg-white/10 border-2 border-gray-600 flex items-center justify-center flex-shrink-0 step-pending">
						<span class="text-sm">&#127968;</span>
					</div>
					<div class="flex-grow">
						<p class="text-gray-300 font-semibold text-sm">Delivered</p>
						<p class="text-gray-500 text-xs">Order delivered to your
							address</p>
					</div>
					<span id="step-delivered-badge"
						class="text-gray-500 text-xs font-semibold">Pending</span>
				</div>
			</div>
		</div>

		<!-- Action Buttons -->
		<div class="fade-up delay-4 flex flex-col sm:flex-row gap-3">
			<a href="orderDetails.jsp?orderId=<%=lastOrderID%>"
				class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-4 px-6 rounded-xl transition-all text-center">
				View Details </a> <a href="orderHistory"
				class="flex-1 bg-white/10 hover:bg-white/15 border border-white/10 text-white font-semibold py-4 px-6 rounded-xl transition-all text-center">
				My Orders </a> <a href="callRestaurantServlet"
				class="flex-1 text-white font-semibold py-4 px-6 rounded-xl transition-all text-center"
				style="background: linear-gradient(135deg, #ff5f1f, #ff8c5a); box-shadow: 0 8px 25px rgba(255, 95, 31, 0.3);">
				Order More Food </a>
		</div>

		<p class="fade-up delay-4 text-gray-600 text-xs mt-6">
			Thank you,
			<%=loggedInUser.getUserName()%>! Enjoy your meal &#127869;
		</p>
	</div>

	<script>
        (function(){
            var orderId = '<%=lastOrderID%>';
            if (!orderId) return;

            function updateTimeline(status) {
                status = status.toLowerCase().trim();

                function completeStep(stepId) {
                    var step = document.getElementById(stepId);
                    if (step) {
                        step.classList.add('step-complete');
                        step.classList.remove('step-pending');
                        step.innerHTML = '<svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7"/></svg>';
                        step.parentElement.querySelector('span:last-child').textContent = 'Complete';
                        step.parentElement.querySelector('span:last-child').className = 'text-green-400 text-xs font-semibold';
                    }
                }

                function activateStep(stepId, badgeId) {
                    var step = document.getElementById(stepId);
                    var badge = document.getElementById(badgeId);
                    if (step) {
                        step.classList.remove('bg-white/10');
                        step.classList.add('bg-orange-500', 'border-orange-500', 'animate-pulse');
                        step.style.boxShadow = '0 0 15px rgba(255,95,31,0.5)';
                    }
                    if (badge) {
                        badge.textContent = 'In Progress';
                        badge.className = 'text-orange-400 text-xs font-semibold animate-pulse';
                    }
                }

                if (status === 'placed') {
                    completeStep('step-placed');
                } else if (status === 'preparing') {
                    completeStep('step-placed');
                    activateStep('step-preparing', 'step-preparing-badge');
                } else if (status === 'out for delivery' || status.indexOf('delivery') >= 0) {
                    completeStep('step-placed');
                    completeStep('step-preparing');
                    activateStep('step-delivery', 'step-delivery-badge');
                } else if (status === 'delivered') {
                    completeStep('step-placed');
                    completeStep('step-preparing');
                    completeStep('step-delivery');
                    var delivered = document.getElementById('step-delivered');
                    if (delivered) {
                        delivered.classList.add('bg-green-500', 'border-green-500');
                        delivered.classList.remove('animate-pulse', 'bg-white/10');
                        delivered.parentElement.querySelector('span:last-child').textContent = 'Complete';
                        delivered.parentElement.querySelector('span:last-child').className = 'text-green-400 text-xs font-semibold';
                    }
                }
            }

            updateTimeline('Placed');

            var evtSource = new EventSource('<%=request.getContextPath()%>/orderStatus?orderId=' + orderId);
            evtSource.onmessage = function(e) {
                try {
                    var data = JSON.parse(e.data);
                    var status = data.status || 'Unknown';
                    var statusText = document.getElementById('statusText');
                    var statusDot = document.getElementById('statusDot');

                    if (statusText) statusText.textContent = status;
                    if (statusDot) {
                        if (status.toLowerCase() === 'placed' || status.toLowerCase() === 'preparing') {
                            statusDot.className = 'w-2 h-2 bg-orange-400 rounded-full animate-pulse';
                        } else if (status.toLowerCase().indexOf('delivery') >= 0 || status.toLowerCase().indexOf('way') >= 0) {
                            statusDot.className = 'w-2 h-2 bg-yellow-400 rounded-full animate-pulse';
                        } else if (status.toLowerCase() === 'delivered') {
                            statusDot.className = 'w-2 h-2 bg-green-400 rounded-full';
                        } else if (status.toLowerCase() === 'cancelled') {
                            statusDot.className = 'w-2 h-2 bg-red-400 rounded-full';
                        }
                    }

                    updateTimeline(status);

                    if (status.toLowerCase() === 'delivered' || status.toLowerCase() === 'cancelled') {
                        evtSource.close();
                    }
                } catch (err) {
                    console.error('Invalid SSE data', err);
                }
            };
            evtSource.onerror = function(e) {
                console.warn('SSE connection error', e);
            };
        })();
    </script>
</body>
</html>
