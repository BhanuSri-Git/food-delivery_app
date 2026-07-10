<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Replace Cart? | FlavorNest</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
<style>
  body {
    background: #101415;
    color: #e0e3e5;
    font-family: 'Inter', sans-serif;
    min-height: 100vh;
  }
  .headline { font-family: 'Sora', sans-serif; }
  .ambient-glow {
    position: absolute; width: 500px; height: 500px; border-radius: 50%;
    background: radial-gradient(circle, rgba(255,95,31,0.12) 0%, transparent 70%);
    filter: blur(80px); z-index: 0;
  }
  .glass-panel {
    background: rgba(25, 28, 30, 0.65);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255,255,255,0.1);
    box-shadow: 0 8px 32px rgba(0,0,0,0.4), 0 0 30px rgba(255,95,31,0.08);
  }
  .primary-glow {
    background: linear-gradient(135deg, #ff5f1f 0%, #ff8c5a 100%);
    box-shadow: 0 10px 20px -5px rgba(255,95,31,0.4);
  }
  .icon-ring {
    background: rgba(255,95,31,0.12);
    border: 1px solid rgba(255,95,31,0.3);
  }
  .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
  @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }
  .fade-up { animation: fadeUp 0.6s ease forwards; }
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body class="flex justify-center items-center p-6 relative overflow-hidden">

  <div class="ambient-glow -top-32 -left-32"></div>
  <div class="ambient-glow -bottom-32 -right-32"></div>

  <div class="glass-panel fade-up rounded-2xl p-8 sm:p-10 w-full max-w-[440px] relative z-10">

    <div class="text-center">
      <div class="icon-ring w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6">
        <span class="material-symbols-outlined text-orange-400 text-4xl">shopping_cart</span>
      </div>

      <h2 class="headline text-2xl font-bold text-white mb-3">Replace Your Cart?</h2>

      <p class="text-gray-400 leading-relaxed mb-8">
        Your cart already has items from a different restaurant.
        Starting an order here means clearing what's in there now.
      </p>
    </div>

    <div class="flex gap-3">
      <a href="cart.jsp"
         class="flex-1 text-center px-6 py-3 rounded-xl border border-white/10 text-gray-300 font-semibold text-sm hover:bg-white/5 hover:text-white transition-all">
        Cancel
      </a>

      <form action="ReplaceCartServlet" method="post" class="flex-1">
        <button type="submit"
                class="w-full px-6 py-3 rounded-xl primary-glow text-white font-semibold text-sm hover:scale-[1.02] active:scale-[0.98] transition-all">
          Replace Cart
        </button>
      </form>
    </div>

  </div>

</body>
</html>
