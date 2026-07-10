<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>500 – Server Error | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>body{background:#101415;font-family:'Inter',sans-serif;color:#e0e3e5;}</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen flex flex-col items-center justify-center text-center p-8">
    <div class="text-8xl mb-6">🔥</div>
    <h1 class="text-6xl font-bold text-red-500 mb-3">500</h1>
    <h2 class="text-2xl font-semibold text-white mb-4">Something went wrong</h2>
    <p class="text-gray-400 mb-2 max-w-md">Our kitchen just had a small fire. The team is working on it.</p>
    <% if (exception != null) { %>
    <p class="text-red-400 text-sm mb-6 max-w-lg bg-red-500/10 border border-red-500/20 px-4 py-2 rounded-lg">
        <%= exception.getMessage() %>
    </p>
    <% } %>
    <a href="login.html" class="bg-orange-500 hover:bg-orange-600 text-white font-semibold py-3 px-8 rounded-xl transition-all">
        Go Home
    </a>
</body>
</html>
