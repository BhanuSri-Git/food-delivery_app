<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="dark" lang="en" style="">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>FlavorNest | Login</title>
<script
	src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&amp;family=Sora:wght@600;700;800&amp;display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet">
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "surface-dim": "#101415",
                    "secondary-container": "#8d3800",
                    "on-primary-fixed": "#390c00",
                    "outline": "#aa897f",
                    "error-container": "#93000a",
                    "primary-container": "#ff5f1f",
                    "surface-container": "#1d2022",
                    "on-tertiary-container": "#242c40",
                    "on-surface-variant": "#e3bfb3",
                    "on-error-container": "#ffdad6",
                    "inverse-primary": "#ab3600",
                    "surface-container-low": "#191c1e",
                    "outline-variant": "#5b4138",
                    "secondary-fixed": "#ffdbcc",
                    "on-tertiary-fixed-variant": "#3f465c",
                    "tertiary-container": "#8c93ac",
                    "primary-fixed-dim": "#ffb59c",
                    "surface-container-lowest": "#0b0f10",
                    "secondary": "#ffb693",
                    "surface-tint": "#ffb59c",
                    "on-background": "#e0e3e5",
                    "on-secondary-fixed-variant": "#7a3000",
                    "on-secondary-container": "#ffb592",
                    "on-surface": "#e0e3e5",
                    "error": "#ffb4ab",
                    "surface-bright": "#363a3b",
                    "tertiary": "#bec6e0",
                    "on-tertiary": "#283044",
                    "background": "#101415",
                    "on-primary": "#5c1900",
                    "tertiary-fixed-dim": "#bec6e0",
                    "surface-container-highest": "#323537",
                    "surface": "#101415",
                    "surface-container-high": "#272a2c",
                    "on-error": "#690005",
                    "surface-variant": "#323537",
                    "secondary-fixed-dim": "#ffb693",
                    "primary": "#ffb59c",
                    "inverse-surface": "#e0e3e5",
                    "primary-fixed": "#ffdbcf",
                    "on-primary-container": "#561700",
                    "on-primary-fixed-variant": "#832700",
                    "on-secondary": "#562000",
                    "on-secondary-fixed": "#351000",
                    "inverse-on-surface": "#2d3133",
                    "tertiary-fixed": "#dae2fd",
                    "on-tertiary-fixed": "#131b2e"
            },
            "borderRadius": {
                    "DEFAULT": "1rem",
                    "lg": "2rem",
                    "xl": "3rem",
                    "full": "9999px"
            },
            "spacing": {
                    "stack-sm": "8px",
                    "stack-lg": "32px",
                    "container-max": "1440px",
                    "margin-desktop": "80px",
                    "border-opacity": "0.1",
                    "margin-mobile": "20px",
                    "glass-blur": "20px",
                    "stack-md": "16px",
                    "gutter": "24px"
            },
            "fontFamily": {
                    "body-md": ["Inter"],
                    "headline-md": ["Sora"],
                    "display-xl": ["Sora"],
                    "body-lg": ["Inter"],
                    "label-sm": ["Inter"],
                    "headline-lg-mobile": ["Sora"],
                    "headline-lg": ["Sora"]
            },
            "fontSize": {
                    "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}],
                    "headline-md": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}],
                    "display-xl": ["64px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                    "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}],
                    "label-sm": ["12px", {"lineHeight": "1", "letterSpacing": "0.05em", "fontWeight": "600"}],
                    "headline-lg-mobile": ["32px", {"lineHeight": "1.2", "fontWeight": "600"}],
                    "headline-lg": ["40px", {"lineHeight": "1.2", "letterSpacing": "-0.01em", "fontWeight": "600"}]
            }
          },
        },
      }
    </script>
<style>
body {
	background-color: #0f172a;
	overflow-x: hidden;
}

.glass-container {
    background: rgba(25, 28, 30, 0.95);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0, 0, 0, 0.18);
}
.primary-glow {
	background: linear-gradient(135deg, #ff5f1f 0%, #ff8c5a 100%);
	box-shadow: 0 10px 30px -5px rgba(255, 95, 31, 0.4);
	position: relative;
	overflow: hidden;
}

.primary-glow::after {
	content: '';
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.2),
		transparent);
	transform: rotate(45deg);
	animation: shimmer 6s infinite;
}

@keyframes shimmer {
	0% { transform: translateX(-100%) rotate(45deg); }
	20% { transform: translateX(100%) rotate(45deg); }
	100% { transform: translateX(100%) rotate(45deg); }
}

.fade-in-up {
	animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
	opacity: 0;
	transform: translateY(20px);
}

@keyframes fadeInUp {
	to { opacity: 1; transform: translateY(0); }
}

.bg-mesh {
	position: fixed;
	inset: 0;
	z-index: -3;
	background-color: #0b0e10;
	background-image:
		radial-gradient(ellipse 80% 60% at 15% 10%, rgba(255, 95, 31, 0.22) 0%, transparent 60%),
		radial-gradient(ellipse 70% 60% at 85% 15%, rgba(255, 140, 90, 0.14) 0%, transparent 55%),
		radial-gradient(ellipse 70% 70% at 50% 100%, rgba(140, 147, 172, 0.14) 0%, transparent 55%),
		linear-gradient(180deg, #0b0e10 0%, #0f1315 50%, #0b0e10 100%);
}

.bg-grid {
	position: fixed;
	inset: 0;
	z-index: -2;
	background-image:
		linear-gradient(rgba(255,255,255,0.035) 1px, transparent 1px),
		linear-gradient(90deg, rgba(255,255,255,0.035) 1px, transparent 1px);
	background-size: 44px 44px;
	-webkit-mask-image: radial-gradient(ellipse 70% 65% at 50% 35%, black 0%, transparent 75%);
	mask-image: radial-gradient(ellipse 70% 65% at 50% 35%, black 0%, transparent 75%);
}

.bg-grain {
	position: fixed;
	inset: 0;
	z-index: -1;
	opacity: 0.05;
	pointer-events: none;
	background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='120' height='120'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
}

.ambient-glow {
	position: absolute;
	width: 600px;
	height: 600px;
	background: radial-gradient(circle, rgba(255, 95, 31, 0.08) 0%,
		transparent 70%);
	border-radius: 50%;
	filter: blur(80px);
	z-index: -1;
	animation: drift 16s ease-in-out infinite;
}

.ambient-glow.glow-b {
	background: radial-gradient(circle, rgba(140, 147, 172, 0.10) 0%, transparent 70%);
	animation-duration: 20s;
	animation-delay: -4s;
}

.ambient-glow.glow-c {
	width: 420px;
	height: 420px;
	background: radial-gradient(circle, rgba(255, 182, 147, 0.10) 0%, transparent 70%);
	animation-duration: 24s;
	animation-delay: -9s;
}

@keyframes drift {
	0%, 100% { transform: translate(0, 0) scale(1); }
	33% { transform: translate(30px, -25px) scale(1.08); }
	66% { transform: translate(-25px, 20px) scale(0.96); }
}

.input-focus-glow:focus-within {
	box-shadow: 0 0 0 2px rgba(255, 95, 31, 0.5);
}

.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 24;
}
</style>
<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body
	class="min-h-screen flex flex-col justify-center items-center font-body-md text-on-surface p-6">
	<div class="bg-mesh"></div>
	<div class="bg-grid"></div>
	<div class="bg-grain"></div>
	<div class="ambient-glow -top-48 -left-48"></div>
	<div class="ambient-glow glow-b -bottom-48 -right-48"></div>
	<div class="ambient-glow glow-c top-1/3 left-1/2 -translate-x-1/2"></div>
	<main class="w-full max-w-[480px] z-10">
		<div class="flex flex-col items-center mb-stack-lg fade-in-up" style="animation-delay: 0.1s">
    <img src="<%=request.getContextPath()%>/assets/images/icon-192.png" alt="FlavorNest logo" class="w-16 h-16 mb-4 rounded-2xl object-cover" />
    <h1 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg tracking-tighter text-white">
        Flavor<span class="text-primary-container">Nest</span>
    </h1>
</div>
		<div class="glass-container rounded-lg p-margin-mobile md:p-10 shadow-2xl fade-in-up" style="animation-delay: 0.2s">
			<div class="mb-stack-lg text-center">
				<h2 class="font-headline-md text-headline-md text-white mb-2 text-center">Welcome Back, Food Lover 🍕</h2>
				<p class="font-body-md text-body-md text-on-surface-variant">Food you'll love, at your door.</p>
			</div>

			<form id="loginForm" action="<%=request.getContextPath()%>/callloginServlet" class="space-y-stack-md" method="post">
				<div class="space-y-2">
					<label class="font-label-sm text-label-sm text-outline block ml-1">Username</label>
					<div class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">person</span>
						<input class="w-full bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-4 text-white placeholder:text-on-surface-variant/40 focus:ring-0 focus:border-primary/50 transition-all outline-none"
							type="text" name="username" placeholder="Enter your username" required>
					</div>
				</div>
				<div class="space-y-2">
					<div class="flex justify-between items-center px-1">
						<label class="font-label-sm text-label-sm text-outline">Password</label>
					</div>
					<div class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">lock</span>
						<input id="password"
							class="w-full bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-12 text-white placeholder:text-on-surface-variant/40 focus:ring-0 focus:border-primary/50 transition-all outline-none"
							type="password" name="password" placeholder="••••••••" required>
						<button id="togglePassword" class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-white transition-colors" type="button">
							<span id="eyeIcon" class="material-symbols-outlined">visibility</span>
						</button>
					</div>
				</div>
				<button class="primary-glow w-full py-4 mt-stack-lg rounded-md font-headline-md text-body-lg text-white hover:scale-[1.02] active:scale-[0.98] transition-transform duration-300" type="submit">Sign In</button>
			</form>
			<div class="relative my-stack-lg">
				<div class="absolute inset-0 flex items-center">
					<div class="w-full border-t border-white/10"></div>
				</div>
				<div class="relative flex justify-center text-label-sm uppercase">
					<span class="bg-surface-container-low px-4 text-outline font-label-sm">Or continue with</span>
				</div>
			</div>
			<div class="grid grid-cols-2 gap-4">
				<button class="flex items-center justify-center gap-3 py-3 px-4 bg-white/5 border border-white/10 rounded-md hover:bg-white/10 transition-colors">
					<svg class="w-5 h-5" viewBox="0 0 24 24">
<path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"></path>
<path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"></path>
<path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"></path>
<path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"></path>
</svg>
					<span class="font-label-sm text-white">Google</span>
				</button>
				<button class="flex items-center justify-center gap-3 py-3 px-4 bg-white/5 border border-white/10 rounded-md hover:bg-white/10 transition-colors">
					<svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 24 24">
<path d="M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2.04-.156-3.075 1.09-4.01 1.09zM15.866 1c-1.365.104-2.634.897-3.44 1.857-.9.987-1.442 2.377-1.234 3.727 1.48.117 2.805-.727 3.624-1.74.883-.987 1.35-2.39 1.05-3.844z"></path>
</svg>
					<span class="font-label-sm text-white">Apple</span>
				</button>
			</div>
		</div>
		<div class="mt-stack-lg text-center fade-in-up" style="animation-delay: 0.3s">
			<p class="font-body-md text-on-surface-variant">
				Don't have an account? <a class="text-primary font-bold hover:underline underline-offset-4 decoration-primary/30 transition-all" href="<%=request.getContextPath()%>/signup.jsp">Sign Up</a>
			</p>
			<p class="mt-4 font-label-sm text-outline opacity-40 uppercase tracking-widest">
				Fast Delivery &bull; Great Food &bull; Happy Moments</p>
		</div>
	</main>
	<div class="fixed top-0 left-0 w-64 h-64 pointer-events-none rounded-full bg-primary/5 blur-[100px] z-0 opacity-0 transition-opacity duration-1000" id="cursor-glow"></div>

	<script>
        const password = document.getElementById("password");
        const toggle = document.getElementById("togglePassword");
        const eyeIcon = document.getElementById("eyeIcon");

        toggle.addEventListener("click", function () {
            if (password.type === "password") {
                password.type = "text";
                eyeIcon.textContent = "visibility_off";
            } else {
                password.type = "password";
                eyeIcon.textContent = "visibility";
            }
        });

        const params = new URLSearchParams(window.location.search);
        if (params.get('error') === 'invalid') {
            const msg = document.createElement('div');
            msg.className = 'bg-red-500/20 border border-red-500/40 text-red-300 text-sm px-4 py-3 rounded-md mb-4';
            msg.innerText = 'Invalid username or password. Please try again.';
            document.getElementById('loginForm').prepend(msg);
        } else if (params.get('error') === 'empty') {
            const msg = document.createElement('div');
            msg.className = 'bg-yellow-500/20 border border-yellow-500/40 text-yellow-300 text-sm px-4 py-3 rounded-md mb-4';
            msg.innerText = 'Please enter both username and password.';
            document.getElementById('loginForm').prepend(msg);
        } else if (params.get('registered') === 'true') {
            const msg = document.createElement('div');
            msg.className = 'bg-green-500/20 border border-green-500/40 text-green-300 text-sm px-4 py-3 rounded-md mb-4';
            msg.innerText = 'Account created! Please log in.';
            document.getElementById('loginForm').prepend(msg);
        }

        const glow = document.getElementById("cursor-glow");

        let mouseX = 0;
        let mouseY = 0;

        window.addEventListener("mousemove", (e)=>{
            mouseX = e.clientX;
            mouseY = e.clientY;
        });

        function animateGlow(){
            glow.style.transform =
                `translate(${mouseX-128}px,${mouseY-128}px)`;

            requestAnimationFrame(animateGlow);
        }

        animateGlow();

        const inputs = document.querySelectorAll('input');
        inputs.forEach(input => {
            input.addEventListener('focus', () => {
                const icon = input.previousElementSibling;
                if (icon) {
                    icon.style.transform = 'translateY(-50%) scale(1.1)';
                    icon.style.transition = 'all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1)';
                }
            });
            input.addEventListener('blur', () => {
                const icon = input.previousElementSibling;
                if (icon) {
                    icon.style.transform = 'translateY(-50%) scale(1)';
                }
            });
        });
    </script>
</body>
</html>