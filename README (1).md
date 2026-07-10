<p align="center">
  <img src="src/main/webapp/assets/images/icon-192.png" width="120" alt="FlavorNest Logo">
</p>

<h1 align="center">🍽️ FlavorNest</h1>

<p align="center">
Modern Food Delivery Web Application built using Java, JSP, Servlets, Hibernate & MySQL
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk">
  <img src="https://img.shields.io/badge/JSP-Servlet-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Hibernate-ORM-brown?style=for-the-badge">
  <img src="https://img.shields.io/badge/MySQL-Database-blue?style=for-the-badge&logo=mysql">
  <img src="https://img.shields.io/badge/Tomcat-10-yellow?style=for-the-badge">
  <img src="https://img.shields.io/badge/MVC-Architecture-success?style=for-the-badge">
</p>

---

## 📖 About FlavorNest

FlavorNest is a full-stack food delivery web application inspired by platforms like **Swiggy** and **Zomato**. It enables users to browse restaurants, explore menus, add food items to the cart, securely place orders, and track order status in real time.

The application follows the **MVC (Model-View-Controller)** architecture and is built using **Java Servlets, JSP, Hibernate ORM, and MySQL**, ensuring a clean, scalable, and maintainable codebase.

---

## ✨ Features

### 👤 User Module
- User Registration & Login (session-based auth)
- Secure Logout
- Browse Restaurants
- Restaurant Search
- Restaurant Details
- View Menus
- Add to Cart / Update Cart / Remove Items
- Checkout & Place Orders
- View Order History
- Real-time Order Tracking (Server-Sent Events)
- Profile Management

### 🍕 Restaurant Module
- Restaurant Listings
- Restaurant Details
- Menu Management
- Food Categories
- Item Availability
- Restaurant Images

### 🛒 Cart Module
- Add / Increase / Decrease / Remove Items
- Dynamic Price Calculation
- Session-based Cart

### 📦 Order Module
- Order Placement & Confirmation
- Order Summary
- Order History
- Real-time Order Tracking

### 🛡️ Admin Module
- Admin Dashboard
- Order Management
- Restaurant & Menu Oversight

### 🔐 Authentication
- Session-based Login
- Role-based Access (Customer / Admin)
- User Validation

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Java | Backend |
| JSP | View Layer |
| Servlets | Controller |
| Hibernate ORM | Database Mapping |
| MySQL | Database |
| HTML5 | Structure |
| Tailwind CSS | Styling / Responsive UI |
| JavaScript | Client-side Interactions |
| Server-Sent Events | Real-time order status |
| Apache Tomcat | Web Server |
| Eclipse IDE | Development |

---

## 🏗️ Architecture

```
Browser
    │
    ▼
JSP Pages
    │
Servlets (Controller)
    │
DAO Layer
    │
Hibernate ORM
    │
MySQL Database
```

---

## 📁 Project Structure

```
food_app/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/food/
│       │       ├── Servlet/        # Controllers (Register, Login, Cart, Order, etc.)
│       │       ├── Model/          # Entities: User, Restaurant, Menu, Cart, Order...
│       │       └── DAO/            # Data access layer
│       └── webapp/
│           ├── assets/images/      # Logo, icons, favicons
│           ├── WEB-INF/            # web.xml, config
│           ├── signup.jsp
│           ├── login.jsp
│           ├── restaurant.jsp
│           ├── menu.jsp
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── orderHistory.jsp
│           ├── profile.jsp
│           ├── offers.jsp
│           ├── adminDashboard.jsp
│           └── adminOrders.jsp
├── FoodDelivery_schema.sql         # Database schema
└── README.md
```

---

## 📂 Database

Main Tables:
- Users
- Restaurants
- Menu
- Cart
- Orders
- OrderItems

---

## 🚀 Application Workflow

```
User Registration
        │
        ▼
Login
        │
        ▼
Browse Restaurants
        │
        ▼
View Menu
        │
        ▼
Add to Cart
        │
        ▼
Checkout
        │
        ▼
Place Order
        │
        ▼
Order Confirmation
        │
        ▼
Order History / Tracking
```

---

## 📸 Screenshots

> Add screenshots to a `screenshots/` folder at the project root and commit them, then they'll render below.

### Landing Page
![Landing](screenshots/landing.png)

### Login
![Login](screenshots/login.png)

### Restaurants Page
![Restaurants](screenshots/restaurant.png)

### Menu
![Menu](screenshots/menu.png)

### Cart
![Cart](screenshots/cart.png)

### Order Tracking
![Order](screenshots/order.png)

---

## ⚙️ Installation

### 1. Clone Repository
```bash
git clone https://github.com/BhanuSri-Git/food-delivery_app.git
```

### 2. Import Project
Import as a **Dynamic Web Project** into Eclipse (Java EE).

### 3. Configure Database
1. Create a MySQL database:
   ```sql
   CREATE DATABASE FlavorNest;
   ```
2. Import the schema:
   ```bash
   mysql -u root -p FlavorNest < FoodDelivery_schema.sql
   ```
3. Update your database credentials in your Hibernate config (`hibernate.cfg.xml`) or DB connection class.

### 4. Configure Tomcat
Requires Apache Tomcat 10+.

### 5. Run
```
http://localhost:8080/food_app/index.jsp
```

---

## 💻 Project Highlights

✔ MVC Architecture
✔ Hibernate ORM
✔ Responsive UI
✔ Session Management
✔ Secure Authentication
✔ Shopping Cart
✔ Real-time Order Tracking
✔ Clean Code Structure
✔ Database Normalization

---

## 📈 Future Enhancements

- Online Payments
- Google Maps Integration
- Email Notifications
- Coupons & Discounts
- Wishlist
- Ratings & Reviews
- AI Food Recommendations
- Delivery Tracking Map

---

## 📄 License

This project is licensed under the MIT License.

---

## 📬 Contact

**Bhanu Sri**
Java Full Stack Developer

📧 your-email@example.com
💼 LinkedIn: https://linkedin.com/in/your-profile
🐙 GitHub: https://github.com/BhanuSri-Git

---

## ⭐ Support

If you like this project, consider giving it a ⭐ on GitHub!

<p align="center">
Made with ❤️ using Java, Hibernate & MySQL
</p>
