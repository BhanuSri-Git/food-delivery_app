<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.food.Model.User" %>
<%--
  ============================================================================
  navbar.jsp  (JSTL-free version)
  ----------------------------------------------------------------------------
  Shared navigation bar. Include this at the top of your pages, e.g.:
      <jsp:include page="/navbar.jsp" />
  or via <%@ include file="/navbar.jsp" %>

  Shows the Profile icon + Logout when a user is logged in, otherwise a
  Login link. Reads sessionScope.loggedInUser, which your login servlet
  already sets.

  No taglib directives, no ${...} EL, no <c:...> tags -- plain scriptlets
  only, so this has zero dependency on the JSTL jar.
  ============================================================================
--%>
<%
    String ctx = request.getContextPath();
    Object uObj = session.getAttribute("loggedInUser");
    User loggedUser = (uObj instanceof User) ? (User) uObj : null;

    String initial = "U";
    if (loggedUser != null && loggedUser.getUserName() != null && !loggedUser.getUserName().isEmpty()) {
        initial = String.valueOf(Character.toUpperCase(loggedUser.getUserName().charAt(0)));
    }
%>
<nav class="sticky top-0 z-40 bg-white/80 backdrop-blur-md shadow-sm">
  <div class="max-w-6xl mx-auto px-4 sm:px-6 py-3 flex items-center justify-between">

    <a href="<%= ctx %>/home.jsp" class="flex items-center gap-2">
      <img src="<%= ctx %>/assets/images/icon-192.png" alt="FlavorNest logo" class="w-9 h-9 rounded-xl object-cover shadow-md" />
      <span class="font-extrabold text-lg tracking-tight text-slate-800">Flavor<span class="text-orange-500">Nest</span></span>
    </a>

    <div class="flex items-center gap-3 sm:gap-5">
      <a href="<%= ctx %>/cart.jsp" class="hidden sm:flex text-sm font-semibold text-slate-600 hover:text-orange-500 transition">Cart</a>
      <a href="<%= ctx %>/orderHistory" class="hidden sm:flex text-sm font-semibold text-slate-600 hover:text-orange-500 transition">Orders</a>

      <% if (loggedUser != null) { %>
        <div class="flex items-center gap-3">
          <%-- Profile icon -> opens /profile, handled by ProfileServlet --%>
          <a href="<%= ctx %>/profile"
             title="My Profile"
             class="w-9 h-9 rounded-full bg-orange-100 border-2 border-orange-400 flex items-center justify-center text-orange-600 font-bold text-sm hover:scale-105 transition">
            <%= initial %>
          </a>

          <%-- Logout link -> invalidates session via LogoutServlet --%>
          <a href="<%= ctx %>/logoutServlet"
             class="text-sm font-semibold text-slate-500 hover:text-red-500 transition">
            Logout
          </a>
        </div>
      <% } else { %>
        <a href="<%= ctx %>/login.jsp"
           class="px-4 py-2 rounded-xl bg-orange-500 text-white text-sm font-bold hover:bg-orange-600 transition">
          Login
        </a>
      <% } %>
    </div>
  </div>
</nav>
