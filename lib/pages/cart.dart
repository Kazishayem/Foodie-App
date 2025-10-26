import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_event.dart';
import 'package:foodie_app/bloc/cart/cart_state.dart';
import 'package:foodie_app/bloc/Checkout/checkout_bloc.dart';
import 'package:foodie_app/pages/Checkout.dart';
import 'package:foodie_app/bloc/Checkout/checkout_bloc.dart';
import 'package:foodie_app/bloc/Checkout/checkout_event.dart';
import 'package:foodie_app/bloc/Checkout/checkout_state.dart';
import 'package:foodie_app/constants/colors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CartSuccess) {
          final cartItems = state.items;
          final total = state.totalAmount;

          return Scaffold(
            appBar: AppBar(
              title: const Text("My Cart 🛒"),
              backgroundColor: Colors.redAccent,
            ),
            body: cartItems.isEmpty
                ? const Center(child: Text("Your cart is empty 😢"))
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              // 🖼 Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),

                              // 📝 Product Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Spicy: ${item['spicyLevel'] ?? 0} | Portion: ${item['portion'] ?? 1}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "৳${item['price'].toString()}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 🗑 Delete Button
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                    RemoveFromCart(index),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${item['name']} removed!"),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButton: cartItems.isEmpty
                ? null
                : FloatingActionButton.extended(
                    backgroundColor: AppColors.primary,
                    icon: const Icon(Icons.payment),
                    label: const Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // ✅ Pass both CartBloc & CheckoutBloc to CheckoutPage
                      final cartBloc = context.read<CartBloc>();
                      final checkoutBloc = context.read<CheckoutBloc>();

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => MultiBlocProvider(
                      //       providers: [
                      //         BlocProvider.value(value: cartBloc),
                      //         BlocProvider.value(value: checkoutBloc),
                      //       ],
                      //       child: const CheckoutPage(),
                      //     ),
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<CartBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<CheckoutBloc>(),
                              ),
                            ],
                            child: const CheckoutPage(),
                          ),
                        ),
                      );
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }

        if (state is CartError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error: ${state.message}",
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
