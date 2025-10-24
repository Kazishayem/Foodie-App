// import 'package:flutter/material.dart';
// import 'package:foodie_app/services/cartService.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   double get totalPrice {
//     double total = 0.0;
//     for (var item in CartService.cartItems) {
//       total += (item['price'] ?? 0);
//     }
//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartItems = CartService.cartItems;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout 💳"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: cartItems.isEmpty
//           ? const Center(
//               child: Text(
//                 "Your cart is empty 🛒",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//             )
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       final item = cartItems[index];
//                       return ListTile(
//                         leading: Image.network(
//                           item['image'],
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 60,
//                               height: 60,
//                               color: Colors.grey[200],
//                               child: const Icon(Icons.broken_image),
//                             );
//                           },
//                         ),
//                         title: Text(
//                           item['name'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           "Portion: ${item['portion']} | Spicy: ${item['spicyLevel'].toStringAsFixed(0)}",
//                         ),
//                         trailing: Text(
//                           "৳${item['price'] ?? 0}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 5,
//                         offset: const Offset(0, -3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Subtotal:",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             "৳${totalPrice.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text(
//                             "Delivery Fee:",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             "৳50",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                       const Divider(thickness: 1, height: 25),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Total:",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "৳${(totalPrice + 50).toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.redAccent,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.redAccent,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text("Payment Successful 🎉"),
//                               ),
//                             );
//                             setState(() {
//                               CartService.clearCart();
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             "Proceed to Payment",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:foodie_app/pages/home.dart';
import 'package:foodie_app/services/cartService.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double get totalPrice {
    double total = 0.0;
    for (var item in CartService.cartItems) {
      total += (item['price'] ?? 0);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout 💳"),
        backgroundColor: Colors.redAccent,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty 🛒"))
          : Column(
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
                          style: const TextStyle(color: Colors.green),
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
                            "৳${totalPrice.toStringAsFixed(2)}",
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
                            "৳${(totalPrice + 50).toStringAsFixed(2)}",
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Payment Successful 🎉"),
                              ),
                            );
                            setState(() => CartService.clearCart());
                            Navigator.pop(context, Home());
                          },
                          child: const Text(
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
  }
}
