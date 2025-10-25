# 🍔 Foodie App

A modern Flutter-based food ordering app that allows users to browse meal categories, view product details, customize portions and spice levels, add items to cart, and manage favorites — all powered by the **BLoC architecture** for predictable state management.

---

## 🚀 Features

- **Category & Product Listing**  
  Fetches data from TheMealDB API and displays categories and meals with images.

- **Product Details Screen**  
  Users can adjust portion and spice levels with real-time price updates.

- **Cart Management**  
  - Add, remove, and clear items.  
  - Dynamic subtotal, delivery fee, and total calculation.  
  - Integrated with `CartBloc` for consistent state handling.

- **Favorites System**  
  Add/remove favorite meals using a lightweight local service.

- **Cart Badge Counter**  
  Live cart count displayed in the app bar using `ValueNotifier`.

- **Checkout Simulation**  
  Checkout button triggers payment success message and clears the cart.

---

## 🧱 Architecture

- **State Management:** `flutter_bloc`  
- **Events & States:**  
  - `ProductBloc` → Handles fetching and displaying food categories/products.  
  - `CartBloc` → Manages cart state (`LoadCart`, `AddToCart`, `RemoveFromCart`, `ClearCart`).  

- **Services:**  
  - `CartService` — In-memory cart storage and count tracking.  
  - `FavoriteService` — Simple local favorite list handler.

- **Models:**  
  - `Product` model (Equatable) for parsing API responses and managing UI data.

---

## 🧰 Tech Stack

| Category | Tools |
|-----------|--------|
| Framework | Flutter |
| Language | Dart |
| State Management | flutter_bloc |
| Networking | http |
| Utilities | Equatable, ValueNotifier |
| IDE | VS Code / Android Studio |

---

## 🧑‍💻 Setup & Run

1. Clone the repository  
   ```bash
   git clone https://github.com/<your-username>/foodie_app.git
