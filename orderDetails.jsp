<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.food.Model.OrderTable"%>
<%@ page import="com.food.Model.OrderItem"%>
<%@ page import="com.food.Model.User"%>
<%@ page import="com.food.Model.Menu"%>
<%@ page import="com.food.DAOImpl.OrderTableDAOImpl"%>
<%@ page import="com.food.DAOImpl.OrderItemDAOImpl"%>
<%@ page import="com.food.DAOImpl.MenuDAOImpl"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
// Verify user is logged in
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

// Get order ID from request parameter
String orderIdStr = request.getParameter("orderId");
if (orderIdStr == null || orderIdStr.isEmpty()) {
	response.sendRedirect(request.getContextPath() + "/orderHistory");
	return;
}

int orderId;
try {
	orderId = Integer.parseInt(orderIdStr);
} catch (NumberFormatException e) {
	response.sendRedirect(request.getContextPath() + "/orderHistory");
	return;
}

// Fetch order details
OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
OrderTable order = orderDAO.getOrderTable(orderId);

if (order == null) {
	response.sendRedirect(request.getContextPath() + "/orderHistory");
	return;
}

// Verify this order belongs to the logged-in user
if (order.getUserID() != loggedInUser.getUserId()) {
	response.sendRedirect(request.getContextPath() + "/orderHistory");
	return;
}

// Fetch order items
OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderID(orderId);

// Fetch menu details for each order item
MenuDAOImpl menuDAO = new MenuDAOImpl();
java.util.Map<Integer, Menu> menuMap = new java.util.HashMap<>();
if (orderItems != null) {
	for (OrderItem item : orderItems) {
		Menu menu = menuDAO.getMenu(item.getMenuID());
		if (menu != null) {
			menuMap.put(item.getMenuID(), menu);
		}
	}
}

// Calculate totals from order items
BigDecimal subtotal = BigDecimal.ZERO;
if (orderItems != null) {
	for (OrderItem item : orderItems) {
		// ItemTotal = price * quantity, so we sum ItemTotal to get subtotal
		if (item.getItemTotal() != null) {
			subtotal = subtotal.add(item.getItemTotal());
		}
	}
}

// Use order's total amount (which includes tax and discount)
BigDecimal total = order.getTotalAmount() != null ? order.getTotalAmount() : BigDecimal.ZERO;

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
String orderDateStr = order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "\u2014";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Details #FN-<%=orderId%> | FlavorNest
</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<style>
body {
	background: #0b0f10;
	font-family: 'Inter', sans-serif;
}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="text-white min-h-screen">
	<div class="max-w-2xl mx-auto px-6 py-8">

		<!-- Header with Back Button -->
		<div class="mb-8 flex items-center gap-3">
			<a href="orderHistory"
				class="text-orange-400 hover:text-orange-300 transition flex items-center gap-1">
				<span>&#8592;</span> Back to Orders
			</a>
		</div>

		<!-- Order Header -->
		<div class="bg-white/5 border border-white/10 rounded-2xl p-6 mb-6">
			<div class="flex items-center justify-between mb-4">
				<h1 class="text-2xl font-bold"
					style="font-family: 'Sora', sans-serif;">
					Order #FN-<%=orderId%></h1>
				<span
					class="inline-flex items-center gap-2 text-xs font-bold px-3 py-1 rounded-full"
					style="background: rgba(255, 95, 31, 0.15); color: #ff5f1f;">
					<%=order.getStatus() != null ? order.getStatus() : "Placed"%>
				</span>
			</div>
			<p class="text-gray-400 text-sm">
				&#128197;
				<%=orderDateStr%>
			</p>
		</div>

		<!-- Customer & Delivery Details -->
		<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
			<!-- Customer Info -->
			<div class="bg-white/5 border border-white/10 rounded-2xl p-6">
				<h2 class="text-lg font-semibold mb-4">Customer Details</h2>
				<div class="space-y-2">
					<p class="text-gray-400 text-sm">Name</p>
					<p class="text-white font-medium"><%=loggedInUser.getUserName()%></p>
					<p class="text-gray-400 text-sm mt-4">Email</p>
					<p class="text-white font-medium"><%=loggedInUser.getEmail()%></p>
				</div>
			</div>

			<!-- Delivery Address -->
			<div class="bg-white/5 border border-white/10 rounded-2xl p-6">
				<h2 class="text-lg font-semibold mb-4">Delivery Address</h2>
				<div class="space-y-2 text-sm">
					<%
					if (order.getFullName() != null) {
					%>
					<p>
						<span class="text-gray-400">Name:</span> <span
							class="text-white font-medium"><%=order.getFullName()%></span>
					</p>
					<%
					}
					%>
					<%
					if (order.getPhone() != null) {
					%>
					<p>
						<span class="text-gray-400">Phone:</span> <span
							class="text-white font-medium"><%=order.getPhone()%></span>
					</p>
					<%
					}
					%>
					<%
					if (order.getAddressLine1() != null) {
					%>
					<p>
						<span class="text-gray-400">Address:</span> <span
							class="text-white font-medium"><%=order.getAddressLine1()%></span>
					</p>
					<%
					}
					%>
					<%
					if (order.getAddressLine2() != null && !order.getAddressLine2().isEmpty()) {
					%>
					<p>
						<span class="text-gray-400"></span> <span
							class="text-white font-medium"><%=order.getAddressLine2()%></span>
					</p>
					<%
					}
					%>
					<%
					if (order.getCity() != null) {
					%>
					<p>
						<span class="text-gray-400">City:</span> <span
							class="text-white font-medium"><%=order.getCity()%> - <%=order.getPincode()%></span>
					</p>
					<%
					}
					%>
				</div>
			</div>
		</div>

		<!-- Order Items -->
		<div class="bg-white/5 border border-white/10 rounded-2xl p-6 mb-6">
			<h2 class="text-lg font-semibold mb-4">Ordered Items</h2>
			<div class="space-y-3">
				<%
				if (orderItems != null && !orderItems.isEmpty()) {
					for (OrderItem item : orderItems) {
						Menu menu = menuMap.get(item.getMenuID());
						String itemName = menu != null ? menu.getItemName() : "Menu Item #" + item.getMenuID();
				%>
				<div
					class="flex items-center justify-between pb-3 border-b border-white/5">
					<div>
						<p class="text-white font-medium">
							<%=itemName%></p>
						<p class="text-gray-400 text-sm">
							Qty:
							<%=item.getQuantity()%>
						</p>
					</div>
					<p class="text-orange-400 font-bold">
						&#8377;
						<%=item.getItemTotal() != null ? item.getItemTotal().setScale(2, java.math.RoundingMode.HALF_UP) : "0.00"%></p>
				</div>
				<%
				}
				} else {
				%>
				<p class="text-gray-400">No items found</p>
				<%
				}
				%>
			</div>
		</div>

		<!-- Cost Breakdown -->
		<div class="bg-white/5 border border-white/10 rounded-2xl p-6 mb-6">
			<h2 class="text-lg font-semibold mb-4">Order Summary</h2>
			<div class="space-y-3 text-sm">
				<div class="flex items-center justify-between">
					<span class="text-gray-400">Subtotal</span> <span
						class="text-white font-medium">&#8377; <%=subtotal.setScale(2, java.math.RoundingMode.HALF_UP)%></span>
				</div>
				<div class="flex items-center justify-between">
					<span class="text-gray-400">Delivery Fee</span> <span
						class="text-white font-medium">&#8377; 30.00</span>
				</div>
				<div class="flex items-center justify-between">
					<span class="text-gray-400">Tax (5%)</span> <span
						class="text-white font-medium">&#8377; <%=subtotal.multiply(new BigDecimal("0.05")).setScale(2, java.math.RoundingMode.HALF_UP)%></span>
				</div>
				<div class="flex items-center justify-between">
					<span class="text-gray-400">Discount</span> <span
						class="text-green-400 font-medium">-&#8377; 5.00</span>
				</div>
				<div
					class="border-t border-white/5 pt-3 flex items-center justify-between">
					<span class="font-semibold">Total Amount</span> <span
						class="text-orange-400 font-bold text-lg">&#8377; <%=total.setScale(2, java.math.RoundingMode.HALF_UP)%></span>
				</div>
			</div>
		</div>

		<!-- Payment & Status -->
		<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
			<div class="bg-white/5 border border-white/10 rounded-2xl p-6">
				<h3
					class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-3">Payment
					Method</h3>
				<p class="text-white font-medium text-lg">
					<%=order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD"%>
				</p>
			</div>
			<div class="bg-white/5 border border-white/10 rounded-2xl p-6">
				<h3
					class="text-sm font-semibold text-gray-400 uppercase tracking-wider mb-3">Restaurant
					ID</h3>
				<p class="text-white font-medium text-lg">
					#<%=order.getRestaurantID()%></p>
			</div>
		</div>

		<!-- Status Timeline -->
		<div class="bg-white/5 border border-white/10 rounded-2xl p-6 mb-6">
			<h2 class="text-lg font-semibold mb-4">Order Status</h2>
			<div class="space-y-4">
				<!-- Placed -->
				<div class="flex items-start gap-4">
					<div
						class="w-10 h-10 rounded-full bg-green-500 flex items-center justify-center flex-shrink-0">
						<svg class="w-5 h-5 text-white" fill="none" stroke="currentColor"
							viewBox="0 0 24 24">
                            <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7" />
                        </svg>
					</div>
					<div>
						<p class="text-white font-semibold">Order Placed</p>
						<p class="text-gray-500 text-xs">Your order has been confirmed</p>
					</div>
				</div>

				<!-- Preparing -->
				<div class="flex items-start gap-4">
					<div
						class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0"
						style="background: <%=order.getStatus() != null && order.getStatus().toLowerCase().contains("preparing") ? "#22c55e"
		: "rgba(255,255,255,0.1)"%>; border: 2px solid <%=order.getStatus() != null && order.getStatus().toLowerCase().contains("preparing") ? "#22c55e"
		: "rgba(255,255,255,0.2)"%>;">
						<span class="text-sm">&#127859;</span>
					</div>
					<div>
						<p
							class="<%=order.getStatus() != null && order.getStatus().toLowerCase().contains("preparing") ? "text-white"
		: "text-gray-300"%> font-semibold">Preparing</p>
						<p class="text-gray-500 text-xs">Your food is being prepared</p>
					</div>
				</div>

				<!-- Out for Delivery -->
				<div class="flex items-start gap-4">
					<div
						class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0"
						style="background: <%=order.getStatus() != null && order.getStatus().toLowerCase().contains("delivery") ? "#22c55e"
		: "rgba(255,255,255,0.1)"%>; border: 2px solid <%=order.getStatus() != null && order.getStatus().toLowerCase().contains("delivery") ? "#22c55e"
		: "rgba(255,255,255,0.2)"%>;">
						<span class="text-sm">&#128662;</span>
					</div>
					<div>
						<p
							class="<%=order.getStatus() != null && order.getStatus().toLowerCase().contains("delivery") ? "text-white"
		: "text-gray-300"%> font-semibold">Out
							for Delivery</p>
						<p class="text-gray-500 text-xs">Driver is on the way</p>
					</div>
				</div>

				<!-- Delivered -->
				<div class="flex items-start gap-4">
					<div
						class="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0"
						style="background: <%=order.getStatus() != null && order.getStatus().toLowerCase().contains("delivered") ? "#22c55e"
		: "rgba(255,255,255,0.1)"%>; border: 2px solid <%=order.getStatus() != null && order.getStatus().toLowerCase().contains("delivered") ? "#22c55e"
		: "rgba(255,255,255,0.2)"%>;">
						<span class="text-sm">&#127968;</span>
					</div>
					<div>
						<p
							class="<%=order.getStatus() != null && order.getStatus().toLowerCase().contains("delivered") ? "text-white"
		: "text-gray-300"%> font-semibold">Delivered</p>
						<p class="text-gray-500 text-xs">Order delivered to your
							address</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Action Buttons -->
		<div class="flex gap-3">
			<a href="orderHistory"
				class="flex-1 bg-white/10 hover:bg-white/15 border border-white/10 text-white font-semibold py-3 px-6 rounded-xl transition-all text-center">
				Back to Orders </a> <a href="callRestaurantServlet"
				class="flex-1 text-white font-semibold py-3 px-6 rounded-xl transition-all text-center"
				style="background: linear-gradient(135deg, #ff5f1f, #ff8c5a);">
				Order Again </a>
		</div>

	</div>
</body>
</html>
