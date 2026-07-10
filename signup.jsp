<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.food.Model.User"%>
<%
// If already logged in, skip signup and go straight home
User loggedInUser = (User) session.getAttribute("loggedInUser");
if (loggedInUser != null) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	return;
}
%>
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Join FlavorNest | Create Your Account</title>
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
		darkMode : "class",
		theme : {
			extend : {
				"colors" : {
					"surface-dim" : "#101415",
					"secondary-container" : "#8d3800",
					"on-primary-fixed" : "#390c00",
					"outline" : "#aa897f",
					"error-container" : "#93000a",
					"primary-container" : "#ff5f1f",
					"surface-container" : "#1d2022",
					"on-tertiary-container" : "#242c40",
					"on-surface-variant" : "#e3bfb3",
					"on-error-container" : "#ffdad6",
					"inverse-primary" : "#ab3600",
					"surface-container-low" : "#191c1e",
					"outline-variant" : "#5b4138",
					"secondary-fixed" : "#ffdbcc",
					"on-tertiary-fixed-variant" : "#3f465c",
					"tertiary-container" : "#8c93ac",
					"primary-fixed-dim" : "#ffb59c",
					"surface-container-lowest" : "#0b0f10",
					"secondary" : "#ffb693",
					"surface-tint" : "#ffb59c",
					"on-background" : "#e0e3e5",
					"on-secondary-fixed-variant" : "#7a3000",
					"on-secondary-container" : "#ffb592",
					"on-surface" : "#e0e3e5",
					"error" : "#ffb4ab",
					"surface-bright" : "#363a3b",
					"tertiary" : "#bec6e0",
					"on-tertiary" : "#283044",
					"background" : "#101415",
					"on-primary" : "#5c1900",
					"tertiary-fixed-dim" : "#bec6e0",
					"surface-container-highest" : "#323537",
					"surface" : "#101415",
					"surface-container-high" : "#272a2c",
					"on-error" : "#690005",
					"surface-variant" : "#323537",
					"secondary-fixed-dim" : "#ffb693",
					"primary" : "#ffb59c",
					"inverse-surface" : "#e0e3e5",
					"primary-fixed" : "#ffdbcf",
					"on-primary-container" : "#561700",
					"on-primary-fixed-variant" : "#832700",
					"on-secondary" : "#562000",
					"on-secondary-fixed" : "#351000",
					"inverse-on-surface" : "#2d3133",
					"tertiary-fixed" : "#dae2fd",
					"on-tertiary-fixed" : "#131b2e"
				},
				"borderRadius" : {
					"DEFAULT" : "1rem",
					"lg" : "2rem",
					"xl" : "3rem",
					"full" : "9999px"
				},
				"spacing" : {
					"stack-sm" : "8px",
					"stack-lg" : "32px",
					"container-max" : "1440px",
					"margin-desktop" : "80px",
					"border-opacity" : "0.1",
					"margin-mobile" : "20px",
					"glass-blur" : "20px",
					"stack-md" : "16px",
					"gutter" : "24px"
				},
				"fontFamily" : {
					"body-md" : [ "Inter" ],
					"headline-md" : [ "Sora" ],
					"display-xl" : [ "Sora" ],
					"body-lg" : [ "Inter" ],
					"label-sm" : [ "Inter" ],
					"headline-lg-mobile" : [ "Sora" ],
					"headline-lg" : [ "Sora" ]
				},
				"fontSize" : {
					"body-md" : [ "16px", {
						"lineHeight" : "1.5",
						"fontWeight" : "400"
					} ],
					"headline-md" : [ "24px", {
						"lineHeight" : "1.3",
						"fontWeight" : "600"
					} ],
					"display-xl" : [ "64px", {
						"lineHeight" : "1.1",
						"letterSpacing" : "-0.02em",
						"fontWeight" : "700"
					} ],
					"body-lg" : [ "18px", {
						"lineHeight" : "1.6",
						"fontWeight" : "400"
					} ],
					"label-sm" : [ "12px", {
						"lineHeight" : "1",
						"letterSpacing" : "0.05em",
						"fontWeight" : "600"
					} ],
					"headline-lg-mobile" : [ "32px", {
						"lineHeight" : "1.2",
						"fontWeight" : "600"
					} ],
					"headline-lg" : [ "40px", {
						"lineHeight" : "1.2",
						"letterSpacing" : "-0.01em",
						"fontWeight" : "600"
					} ]
				}
			},
		},
	}
</script>
<style type="text/css">body {
	background-color: #0f172a;
	overflow-x: hidden;
}

.glass-container {
	background: rgba(25, 28, 30, 0.6);
	backdrop-filter: blur(20px);
	-webkit-backdrop-filter: blur(20px);
	border: 1px solid rgba(255, 255, 255, 0.1);
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
	background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.2), transparent);
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
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.bg-mesh {
	position: fixed;
	inset: 0;
	z-index: -3;
	background-color: #0b0e10;
	background-image: radial-gradient(ellipse 80% 60% at 15% 10%, rgba(255, 95, 31, 0.22) 0%, transparent 60%),
		radial-gradient(ellipse 70% 60% at 85% 15%, rgba(255, 140, 90, 0.14) 0%, transparent 55%),
		radial-gradient(ellipse 70% 70% at 50% 100%, rgba(140, 147, 172, 0.14) 0%, transparent 55%),
		linear-gradient(180deg, #0b0e10 0%, #0f1315 50%, #0b0e10 100%);
}

.bg-grid {
	position: fixed;
	inset: 0;
	z-index: -2;
	background-image: linear-gradient(rgba(255, 255, 255, 0.035) 1px, transparent 1px),
		linear-gradient(90deg, rgba(255, 255, 255, 0.035) 1px, transparent 1px);
	background-size: 44px 44px;
	-webkit-mask-image: radial-gradient(ellipse 70% 65% at 50% 30%, black 0%, transparent 75%);
	mask-image: radial-gradient(ellipse 70% 65% at 50% 30%, black 0%, transparent 75%);
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
	background: radial-gradient(circle, rgba(255, 95, 31, 0.08) 0%, transparent 70%);
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
}</style>
<link rel="icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/assets/images/favicon.ico">
</head>
<body
	class="min-h-screen flex flex-col justify-center items-center font-body-md text-on-surface p-6">

	<div class="bg-mesh"></div>
	<div class="bg-grid"></div>
	<div class="bg-grain"></div>
	<div class="ambient-glow -top-48 -left-48"></div>
	<div class="ambient-glow glow-b -bottom-48 -right-48"></div>

	<main class="w-full max-w-[520px] z-10">

		<!-- Brand -->
		<div class="flex flex-col items-center mb-stack-lg fade-in-up" style="animation-delay:0.1s">
			<img src="<%=request.getContextPath()%>/assets/images/icon-192.png" alt="FlavorNest logo" class="w-16 h-16 mb-4 rounded-2xl object-cover" />
			<h1 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg tracking-tighter text-white">
				Flavor<span class="text-primary-container">Nest</span>
			</h1>
			<p class="font-body-md text-on-surface-variant mt-2 opacity-80">Experience
				culinary excellence.</p>
		</div>

		<!-- Signup Card -->
		<div
			class="glass-container rounded-lg p-margin-mobile md:p-10 shadow-2xl fade-in-up"
			style="animation-delay: 0.2s">

			<div id="msgBanner" class="hidden mb-5 text-sm px-4 py-3 rounded-md"></div>

			<form id="signupForm"
				action="<%=request.getContextPath()%>/callRegisterServlet"
				method="post" class="space-y-stack-md">

				<div class="space-y-2">
					<label class="font-label-sm text-label-sm text-outline block ml-1">Full
						Name</label>
					<div
						class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span
							class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">person</span>
						<input
							class="w-full bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-4 text-white placeholder:text-on-surface-variant/40 focus:ring-0 focus:border-primary/50 transition-all outline-none"
							type="text" name="username" placeholder="Julian Vane" required>
					</div>
				</div>

				<div class="space-y-2">
					<label class="font-label-sm text-label-sm text-outline block ml-1">Email
						Address</label>
					<div
						class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span
							class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">mail</span>
						<input
							class="w-full bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-4 text-white placeholder:text-on-surface-variant/40 focus:ring-0 focus:border-primary/50 transition-all outline-none"
							type="email" name="email" placeholder="julian@luxury.com"
							required>
					</div>
				</div>

				<div class="space-y-2">
					<label class="font-label-sm text-label-sm text-outline block ml-1">Password</label>
					<div
						class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span
							class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">lock</span>
						<input id="password"
							class="w-full bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-12 text-white placeholder:text-on-surface-variant/40 focus:ring-0 focus:border-primary/50 transition-all outline-none"
							type="password" name="password" placeholder="••••••••" required>
						<button id="togglePassword" type="button"
							class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-white transition-colors">
							<span id="eyeIcon" class="material-symbols-outlined">visibility</span>
						</button>
					</div>
				</div>

				<div class="space-y-2">
					<label class="font-label-sm text-label-sm text-outline block ml-1">Address</label>
					<div
						class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span
							class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">location_on</span>
						<input
							class="w-full bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-4 text-white placeholder:text-on-surface-variant/40 focus:ring-0 focus:border-primary/50 transition-all outline-none"
							type="text" name="address" placeholder="Enter your address"
							required>
					</div>
				</div>

				<div class="space-y-2">
					<label class="font-label-sm text-label-sm text-outline block ml-1">Role</label>
					<div
						class="relative group input-focus-glow rounded-md transition-all duration-300">
						<span
							class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors">badge</span>
						<select name="role" required
							class="w-full appearance-none bg-surface-container-highest/40 border border-white/5 rounded-md py-4 pl-12 pr-10 text-white focus:ring-0 focus:border-primary/50 transition-all outline-none">
							<option value="" disabled selected>Select Role</option>
							<option value="Customer">Customer</option>
							<option value="Admin">Admin</option>
						</select> <span
							class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant pointer-events-none">expand_more</span>
					</div>
				</div>

				<div class="flex items-start gap-3 px-1 pt-1">
					<input
						class="mt-1 rounded border-outline-variant/50 bg-surface-container-low text-primary-container focus:ring-primary-container focus:ring-offset-background"
						id="terms" type="checkbox" required> <label
						class="text-label-sm text-on-surface-variant leading-relaxed"
						for="terms"> I agree to the <a
						class="text-primary hover:underline transition-all" href="#">Terms
							of Service</a> and <a
						class="text-primary hover:underline transition-all" href="#">Privacy
							Policy</a>.
					</label>
				</div>

				<button
					class="primary-glow w-full py-4 mt-stack-lg rounded-md font-headline-md text-body-lg text-white hover:scale-[1.02] active:scale-[0.98] transition-transform duration-300"
					type="submit">Sign Up</button>
			</form>

			<div class="relative my-stack-lg">
				<div class="absolute inset-0 flex items-center">
					<div class="w-full border-t border-white/10"></div>
				</div>
				<div class="relative flex justify-center text-label-sm uppercase">
					<span
						class="bg-surface-container-low px-4 text-outline font-label-sm">Or
						continue with</span>
				</div>
			</div>

			<div class="grid grid-cols-2 gap-4">
				<button type="button"
					class="flex items-center justify-center gap-3 py-3 px-4 bg-white/5 border border-white/10 rounded-md hover:bg-white/10 transition-colors">
					<svg class="w-5 h-5" viewBox="0 0 24 24">
					<path
							d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
							fill="#4285F4"></path>
					<path
							d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
							fill="#34A853"></path>
					<path
							d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z"
							fill="#FBBC05"></path>
					<path
							d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
							fill="#EA4335"></path>
				</svg>
					<span class="font-label-sm text-white">Google</span>
				</button>
				<button type="button"
					class="flex items-center justify-center gap-3 py-3 px-4 bg-white/5 border border-white/10 rounded-md hover:bg-white/10 transition-colors">
					<svg class="w-5 h-5 text-white" fill="currentColor"
						viewBox="0 0 24 24">
					<path
							d="M17.05 20.28c-.98.95-2.05 1.61-3.21 1.61-1.14 0-1.51-.67-2.83-.67-1.34 0-1.78.65-2.81.67-1.14 0-2.34-.84-3.41-2.03-2.22-2.43-3.03-7.14-1.34-10.16 1.03-1.86 2.8-3.01 4.54-3.01 1.34 0 2.25.74 3.12.74.84 0 1.94-.85 3.37-.85 1.12 0 2.58.46 3.65 1.54-.15.11-2.12 1.3-2.12 3.86 0 3.1 2.51 4.22 2.65 4.28-.04.14-.41 1.48-1.61 2.62zM13.25 1.03c1.07-.07 2.19.68 2.87 1.48.69.8 1.25 2.13.9 3.23-1.1.09-2.28-.69-2.94-1.5-.67-.81-1.12-1.92-.83-3.21z"></path>
				</svg>
					<span class="font-label-sm text-white">Apple</span>
				</button>
			</div>
		</div>

		<div class="mt-stack-lg text-center fade-in-up"
			style="animation-delay: 0.3s">
			<p class="font-body-md text-on-surface-variant">
				Already have an account? <a
					class="text-primary font-bold hover:underline underline-offset-4 decoration-primary/30 transition-all"
					href="<%=request.getContextPath()%>/login.jsp">Sign In</a>
			</p>
		</div>
	</main>

	<script>
		const password = document.getElementById("password");
		const toggle = document.getElementById("togglePassword");
		const eyeIcon = document.getElementById("eyeIcon");
		toggle.addEventListener("click", function() {
			if (password.type === "password") {
				password.type = "text";
				eyeIcon.textContent = "visibility_off";
			} else {
				password.type = "password";
				eyeIcon.textContent = "visibility";
			}
		});

		(function() {
			const params = new URLSearchParams(window.location.search);
			const banner = document.getElementById('msgBanner');
			const err = params.get('error');
			if (err === 'taken') {
				banner.className = 'mb-5 text-sm px-4 py-3 rounded-md bg-red-500/20 border border-red-500/40 text-red-300';
				banner.innerText = 'Username already taken. Please choose a different one.';
				banner.classList.remove('hidden');
			} else if (err === 'empty') {
				banner.className = 'mb-5 text-sm px-4 py-3 rounded-md bg-yellow-500/20 border border-yellow-500/40 text-yellow-300';
				banner.innerText = 'Please fill in all required fields.';
				banner.classList.remove('hidden');
			} else if (err === 'failed') {
				banner.className = 'mb-5 text-sm px-4 py-3 rounded-md bg-red-500/20 border border-red-500/40 text-red-300';
				banner.innerText = 'Registration failed. Please try again.';
				banner.classList.remove('hidden');
			}
		})();
	</script>
</body>
</html>
