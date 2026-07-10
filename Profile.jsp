<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.food.Model.User" %>
<%@ page import="java.util.List" %>
<%--
  ============================================================================
  profile.jsp — restyled to match the FlavorNest dark-glass design system
  used across index.jsp / login.jsp / restaurant.jsp / cart.jsp, etc.
  Forwarded here ONLY by ProfileServlet, which already checks the session
  and redirects to login.jsp if nobody is logged in.
  JSTL-free: plain <% %> scriptlets only.
  ============================================================================
--%>
<%!
    private String esc(Object val, String def) {
        if (val == null) return (def == null) ? "" : def;
        String s = val.toString();
        if (s.isEmpty()) return (def == null) ? "" : def;
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
    private String initialLetter(String userName) {
        if (userName == null || userName.length() == 0) return "U";
        return String.valueOf(Character.toUpperCase(userName.charAt(0)));
    }
%>
<%
    Object uObj = request.getAttribute("profileUser");
    if (uObj == null) { uObj = session.getAttribute("loggedInUser"); }
    User user = (uObj instanceof User) ? (User) uObj : null;

    String ctx = request.getContextPath();
    String initial = (user != null) ? initialLetter(user.getUserName()) : "U";

    String successParam = request.getParameter("success");
    String errorParam = request.getParameter("error");

    Object ordersObj = request.getAttribute("orders");
    List<?> orders = (ordersObj instanceof List) ? (List<?>) ordersObj : null;
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile | FlavorNest</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&amp;family=Inter:wght@400;500;600&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<style>
  body {
    background-color: #101415;
    color: #e0e3e5;
    font-family: 'Inter', sans-serif;
  }
  .headline { font-family: 'Sora', sans-serif; }
  .glass {
    background: rgba(255, 255, 255, 0.04);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 255, 255, 0.08);
  }
  .card-hover { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
  .card-hover:hover { transform: translateY(-4px); border-color: rgba(255,95,31,0.35); box-shadow: 0 20px 40px -15px rgba(255,95,31,0.20); }
  .avatar-ring { background: conic-gradient(from 180deg, #ff5f1f, #ff8c5a, #ff5f1f); padding: 4px; }
  .primary-glow { background: linear-gradient(135deg, #ff5f1f 0%, #ff8c5a 100%); box-shadow: 0 8px 25px rgba(255,95,31,0.3); }
  .fade-in { animation: fadeIn 0.5s ease-out both; }
  @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
  .modal-backdrop { background: rgba(11, 15, 16, 0.7); backdrop-filter: blur(6px); }
  .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body>

  <%-- ===================== NAVBAR ===================== --%>
  <nav class="sticky top-0 z-40 glass border-b border-white/5">
    <div class="max-w-6xl mx-auto px-4 sm:px-6 py-3 flex items-center justify-between">
      <a href="<%= ctx %>/index.jsp" class="flex items-center gap-2.5">
        <span class="w-9 h-9 rounded-xl primary-glow flex items-center justify-center text-white font-bold text-lg">F</span>
        <span class="headline font-extrabold text-lg tracking-tight text-white">Flavor<span class="text-orange-400">Nest</span></span>
      </a>
      <div class="flex items-center gap-3 sm:gap-5">
        <a href="<%= ctx %>/cart.jsp" class="hidden sm:flex text-sm font-semibold text-gray-300 hover:text-orange-400 transition">Cart</a>
        <a href="<%= ctx %>/orderHistory" class="hidden sm:flex text-sm font-semibold text-gray-300 hover:text-orange-400 transition">Orders</a>
        <a href="<%= ctx %>/profile" class="w-9 h-9 rounded-full bg-orange-500/15 border-2 border-orange-400/60 flex items-center justify-center text-orange-300 font-bold text-sm">
          <%= initial %>
        </a>
      </div>
    </div>
  </nav>

<% if (user == null) { %>
  <div class="max-w-md mx-auto mt-24 text-center">
    <p class="text-gray-400">Session expired. Redirecting to login…</p>
  </div>
  <script>window.location.href = "<%= ctx %>/login.jsp";</script>
<% } else { %>
  <div class="max-w-6xl mx-auto px-4 sm:px-6 py-10">

    <% if ("updated".equals(successParam)) { %>
      <div class="mb-6 fade-in rounded-2xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 px-5 py-3 text-sm font-semibold">✓ Profile updated successfully.</div>
    <% } %>
    <% if ("password".equals(successParam)) { %>
      <div class="mb-6 fade-in rounded-2xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 px-5 py-3 text-sm font-semibold">✓ Password changed successfully.</div>
    <% } %>
    <% if ("wrongpw".equals(errorParam)) { %>
      <div class="mb-6 fade-in rounded-2xl bg-red-500/10 border border-red-500/30 text-red-400 px-5 py-3 text-sm font-semibold">✗ Current password is incorrect.</div>
    <% } %>

    <%-- ===================== HERO / AVATAR CARD ===================== --%>
    <div class="glass card-hover fade-in rounded-3xl p-6 sm:p-8 mb-6 flex flex-col sm:flex-row items-center sm:items-start gap-6">
      <div class="avatar-ring rounded-full shrink-0">
        <div class="w-24 h-24 sm:w-28 sm:h-28 rounded-full bg-[#101415] flex items-center justify-center">
          <span class="text-3xl sm:text-4xl font-extrabold headline bg-gradient-to-br from-orange-400 to-red-400 bg-clip-text text-transparent">
            <%= initial %>
          </span>
        </div>
      </div>

      <div class="flex-1 text-center sm:text-left">
        <h1 class="headline text-2xl sm:text-3xl font-extrabold text-white">
          <%= esc(user.getUserName(), "Your Name") %>
        </h1>
        <div class="mt-3 inline-flex items-center gap-2 rounded-full bg-orange-500/10 border border-orange-500/30 px-3 py-1">
          <span class="w-2 h-2 rounded-full bg-orange-400 animate-pulse"></span>
          <span class="text-xs font-bold text-orange-300 uppercase tracking-wide">
            <%= esc(user.getRole(), "Customer") %>
          </span>
        </div>
      </div>

      <div class="flex flex-col gap-2 w-full sm:w-auto">
        <button onclick="document.getElementById('editModal').classList.remove('hidden')"
                class="px-5 py-2.5 rounded-xl primary-glow text-white font-bold text-sm hover:scale-[1.02] active:scale-[0.98] transition">
          Edit Profile
        </button>
        <a href="<%= ctx %>/logoutServlet"
           class="px-5 py-2.5 rounded-xl border-2 border-white/10 text-gray-300 font-bold text-sm text-center hover:border-red-400/50 hover:text-red-400 hover:bg-red-500/5 transition">
          Logout
        </a>
      </div>
    </div>

    <%-- ===================== DETAIL CARDS GRID ===================== --%>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">

      <div class="glass card-hover fade-in rounded-2xl p-5">
        <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center mb-3 text-orange-400">
          <span class="material-symbols-outlined">mail</span>
        </div>
        <p class="text-xs font-bold text-gray-500 uppercase tracking-wide">Email Address</p>
        <p class="mt-1 font-semibold text-white break-all"><%= esc(user.getEmail(), "—") %></p>
      </div>

      <div class="glass card-hover fade-in rounded-2xl p-5">
        <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center mb-3 text-orange-400">
          <span class="material-symbols-outlined">location_on</span>
        </div>
        <p class="text-xs font-bold text-gray-500 uppercase tracking-wide">Delivery Address</p>
        <p class="mt-1 font-semibold text-white"><%= esc(user.getAddress(), "—") %></p>
      </div>

      <div class="glass card-hover fade-in rounded-2xl p-5">
        <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center mb-3 text-orange-400">
          <span class="material-symbols-outlined">badge</span>
        </div>
        <p class="text-xs font-bold text-gray-500 uppercase tracking-wide">Account ID</p>
        <p class="mt-1 font-semibold text-white">#<%= esc(user.getUserId(), "") %></p>
      </div>

      <% if (user.getcreateDate() != null) { %>
      <div class="glass card-hover fade-in rounded-2xl p-5">
        <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center mb-3 text-orange-400">
          <span class="material-symbols-outlined">calendar_month</span>
        </div>
        <p class="text-xs font-bold text-gray-500 uppercase tracking-wide">Date Joined</p>
        <p class="mt-1 font-semibold text-white"><%= user.getcreateDate() %></p>
      </div>
      <% } %>

      <% if (user.getLastLoginDate() != null) { %>
        <div class="glass card-hover fade-in rounded-2xl p-5">
          <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center mb-3 text-orange-400">
            <span class="material-symbols-outlined">schedule</span>
          </div>
          <p class="text-xs font-bold text-gray-500 uppercase tracking-wide">Last Login</p>
          <p class="mt-1 font-semibold text-white"><%= user.getLastLoginDate() %></p>
        </div>
      <% } %>
    </div>

    <%-- ===================== RECENT ORDERS ===================== --%>
    <% if (orders != null && !orders.isEmpty()) { %>
      <div class="mt-8">
        <h2 class="headline text-lg font-extrabold text-white mb-4">Recent Orders</h2>
        <div class="glass rounded-2xl divide-y divide-white/5 overflow-hidden">
          <%
            int shown = 0;
            for (Object oObj : orders) {
              if (shown >= 5) break;
              shown++;
              Object orderID = null, orderDate = null, status = null;
              try { orderID = oObj.getClass().getMethod("getOrderID").invoke(oObj); } catch (Exception e) { }
              try { orderDate = oObj.getClass().getMethod("getOrderDate").invoke(oObj); } catch (Exception e) { }
              try { status = oObj.getClass().getMethod("getStatus").invoke(oObj); } catch (Exception e) { }
          %>
            <div class="p-4 flex items-center justify-between hover:bg-white/[0.03] transition">
              <div>
                <p class="font-semibold text-gray-200">Order #FN-<%= esc(orderID, "") %></p>
                <p class="text-xs text-gray-500"><%= esc(orderDate, "") %></p>
              </div>
              <span class="text-xs font-bold px-3 py-1 rounded-full bg-orange-500/10 text-orange-300 border border-orange-500/20"><%= esc(status, "") %></span>
            </div>
          <% } %>
        </div>
        <div class="text-right mt-3">
          <a href="<%= ctx %>/orderHistory" class="text-orange-400 hover:text-orange-300 text-sm font-medium transition-colors">View all orders →</a>
        </div>
      </div>
    <% } %>

  </div>
<% } %>

  <%-- ===================== EDIT PROFILE MODAL ===================== --%>
  <div id="editModal" class="hidden fixed inset-0 z-50 modal-backdrop flex items-center justify-center p-4">
    <div class="glass w-full max-w-md rounded-3xl p-6 shadow-2xl fade-in">
      <div class="flex items-center justify-between mb-5">
        <h3 class="headline text-xl font-extrabold text-white">Edit Profile</h3>
        <button onclick="document.getElementById('editModal').classList.add('hidden')" class="text-gray-500 hover:text-white text-xl leading-none">✕</button>
      </div>
      <form action="<%= ctx %>/profile" method="post" class="space-y-4">
        <input type="hidden" name="action" value="updateProfile">
        <div>
          <label class="text-xs font-bold text-gray-500 uppercase">Email Address</label>
          <input type="email" name="email" value="<%= (user != null) ? esc(user.getEmail(), "") : "" %>"
                 class="mt-1 w-full rounded-xl border border-white/10 bg-white/5 px-4 py-2.5 text-sm text-white focus:outline-none focus:ring-2 focus:ring-orange-500/50">
        </div>
        <div>
          <label class="text-xs font-bold text-gray-500 uppercase">Delivery Address</label>
          <textarea name="address" rows="3"
                    class="mt-1 w-full rounded-xl border border-white/10 bg-white/5 px-4 py-2.5 text-sm text-white focus:outline-none focus:ring-2 focus:ring-orange-500/50"><%= (user != null) ? esc(user.getAddress(), "") : "" %></textarea>
        </div>
        <button type="submit"
                class="w-full py-3 rounded-xl primary-glow text-white font-bold text-sm transition">
          Save Changes
        </button>
      </form>

      <div class="mt-6 pt-6 border-t border-white/10">
        <h4 class="text-sm font-extrabold text-gray-300 mb-3">Change Password</h4>
        <form action="<%= ctx %>/profile" method="post" class="space-y-3">
          <input type="hidden" name="action" value="changePassword">
          <input type="password" name="currentPassword" placeholder="Current password" required
                 class="w-full rounded-xl border border-white/10 bg-white/5 px-4 py-2.5 text-sm text-white focus:outline-none focus:ring-2 focus:ring-orange-500/50">
          <input type="password" name="newPassword" placeholder="New password" required
                 class="w-full rounded-xl border border-white/10 bg-white/5 px-4 py-2.5 text-sm text-white focus:outline-none focus:ring-2 focus:ring-orange-500/50">
          <button type="submit"
                  class="w-full py-2.5 rounded-xl border-2 border-orange-500/40 text-orange-300 font-bold text-sm hover:bg-orange-500/10 transition">
            Update Password
          </button>
        </form>
      </div>
    </div>
  </div>

</body>
</html>
