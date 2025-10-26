import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/pages/home.dart';
import 'package:foodie_app/services/cartService.dart';
import 'package:foodie_app/bloc/checkout/checkout_bloc.dart';
import 'package:foodie_app/bloc/checkout/checkout_event.dart';
import 'package:foodie_app/bloc/checkout/checkout_state.dart';
import 'package:foodie_app/bloc/Cart/cart_state.dart';
import 'package:foodie_app/bloc/Cart/cart_bloc.dart';
import 'package:foodie_app/bloc/Cart/cart_event.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  double calculateTotal(List items) {
    double total = 0;
    for (var item in items) {
      total += item['price'];
    }
    return total + 50; // delivery fee
  }

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartBloc>().state;

    if (cartState is! CartSuccess) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final cartItems = cartState.items;
    final subtotal = calculateTotal(cartItems) - 50;

    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Payment Successful 🎉")),
          );
          CartService.clearCart();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (cartItems.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("Your cart is empty 🛒")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Checkout 💳"),
            backgroundColor: Colors.redAccent,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return ListTile(
                      leading: Image.network(
                        item['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Portion: ${item['portion']} | Spicy: ${item['spicyLevel'].toStringAsFixed(0)}",
                      ),
                      trailing: Text(
                        "৳${item['price'].toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Subtotal:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "৳${subtotal.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Fee:", style: TextStyle(fontSize: 16)),
                        Text("৳50", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Divider(thickness: 1, height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "৳${calculateTotal(cartItems).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: state is Checkoutloading
                            ? null
                            : () {
                                context.read<CheckoutBloc>().add(
                                  StartCheckout(calculateTotal(cartItems)),
                                );
                              },
                        child: state is Checkoutloading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Proceed to Payment",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
