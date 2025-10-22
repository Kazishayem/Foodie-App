// class CartService {
//   static List<Map<String, dynamic>> cartItems = [];

//   static void addCart(Map<String, dynamic> item) {
//     // একই প্রোডাক্ট আগে আছে কিনা চেক করো
//     final alreadyInCart = cartItems.any(
//       (cartItem) => cartItem['name'] == item['name'],
//     );

//     if (!alreadyInCart) {
//       cartItems.add(item);
//       print("✅ Added to cart: ${item['name']}");
//     } else {
//       print("⚠️ Already in cart: ${item['name']}");
//     }

//     print("🛒 Total items in cart: ${cartItems.length}");
//   }

//   static void removeCart(Map<String, dynamic> item) {
//     cartItems.removeWhere((cartItem) => cartItem['name'] == item['name']);
//     print("❌ Removed: ${item['name']}");
//     print("🛒 Total items now: ${cartItems.length}");
//   }
  
// }
import 'package:flutter/foundation.dart';

class CartService {
  static List<Map<String, dynamic>> cartItems = [];
  static ValueNotifier<int> cartCount = ValueNotifier(0); // ✅ যোগ করো

  static void addCart(Map<String, dynamic> item) {
    if (!cartItems.contains(item)) {
      cartItems.add(item);
      cartCount.value = cartItems.length; // ✅ count update
    }
  }

  static void removeCart(Map<String, dynamic> item) {
    cartItems.remove(item);
    cartCount.value = cartItems.length; // ✅ update
  }

  static void clearCart() {
    cartItems.clear();
    cartCount.value = 0;
  }
}
