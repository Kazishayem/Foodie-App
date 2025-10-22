import 'package:flutter/material.dart';
import 'package:foodie_app/services/cartService.dart';
import 'package:foodie_app/pages/cart.dart';

class CartCount extends StatelessWidget {
  const CartCount({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: CartService.cartCount, // ✅ listen to updates
      builder: (context, count, _) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                // optional: Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart()));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
            ),
            if (count > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
