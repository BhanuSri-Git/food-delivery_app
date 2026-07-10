<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>404 – Page Not Found | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>body{background:#101415;font-family:'Inter',sans-serif;color:#e0e3e5;}</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="min-h-screen flex flex-col items-center justify-center text-center p-8">
    <div class="text-8xl mb-6">🍕</div>
    <h1 class="text-6xl font-bold text-orange-500 mb-3">404</h1>
    <h2 class="text-2xl font-semibold text-white mb-4">Oops! Page not found</h2>
    <p class="text-gray-400 mb-8 max-w-md">Looks like this page went on a food break. Let's get you back to something delicious.</p>
    <a href="login.html" class="bg-orange-500 hover:bg-orange-600 text-white font-semibold py-3 px-8 rounded-xl transition-all">
        Go Home
    </a>
</body>
</html>
