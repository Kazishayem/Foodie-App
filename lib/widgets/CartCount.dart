import 'package:flutter/material.dart';
import 'package:foodie_app/services/cartService.dart';
import 'package:foodie_app/pages/cart.dart';
import 'package:foodie_app/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_event.dart';

class CartCount extends StatelessWidget {
  const CartCount({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: CartService.cartCount,
      builder: (context, count, _) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                // pass the same CartBloc instance to the new route so BlocBuilder can find it
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => CartBloc()..add(LoadCart()),
                      child: const Cart(),
                    ),
                  ),
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
