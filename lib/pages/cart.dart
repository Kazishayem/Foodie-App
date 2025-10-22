import 'package:flutter/material.dart';
import 'package:foodie_app/services/cartService.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

void didChangeDependencies() {
  super.didChangeDependencies();
  setState(() {}); // পেজ রিফ্রেশ করানোর জন্য
}
  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.cartItems;
    print("🧺 Cart page items: $cartItems");



    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart 🛒"),
        backgroundColor: Colors.redAccent,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty 😢",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Text(
                      "Spicy Level: ${item['spicyLevel'].toStringAsFixed(0)} | Portion: ${item['portion']}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          CartService.removeCart(item);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${item['name']} removed!"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
