// import 'package:flutter/foundation.dart';

// class CartService {
//   static List<Map<String, dynamic>> cartItems = [];
//   static ValueNotifier<int> cartCount = ValueNotifier(0); // ✅ যোগ করো

//   static void addCart(Map<String, dynamic> item) {
//     if (!cartItems.contains(item)) {
//       cartItems.add(item);
//       cartCount.value = cartItems.length; // ✅ count update
//     }
//   }

//   static void removeCart(Map<String, dynamic> item) {
//     cartItems.remove(item);
//     cartCount.value = cartItems.length; // ✅ update
//   }

//   static void clearCart() {
//     cartItems.clear();
//     cartCount.value = 0;
//   }
// }
// lib/services/cartService.dart
import 'package:flutter/foundation.dart';

class CartService {
  // public static list used by Bloc handlers as single source of truth
  static List<Map<String, dynamic>> cartItems = [];
  static ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  // Add product (product should contain 'price', 'name', 'image', etc.)
  static void addCart(Map<String, dynamic> product) {
    cartItems.add(product);
    cartCount.value = cartItems.length;
  }

  // Remove by index (safe)
  static void removeCart(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      cartCount.value = cartItems.length;
    }
  }

  static void clearCart() {
    cartItems.clear();
    cartCount.value = 0;
  }
}
