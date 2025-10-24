// import 'package:flutter/material.dart';
// import 'package:foodie_app/services/cartService.dart';
// import 'package:foodie_app/pages/Checkout.dart';
// import 'package:foodie_app/constants/colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_event.dart';
// import 'package:foodie_app/bloc/cart/cart_state.dart';
// import 'package:foodie_app/pages/Checkout.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartItems = CartService.cartItems;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Cart 🛒"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: cartItems.isEmpty
//           ? const Center(child: Text("Your cart is empty 😢"))
//           : ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   elevation: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         // 🖼 Product Image
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             item['image'],
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(width: 15),

//                         // 📝 Product Info
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item['name'],
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 "Spicy: ${item['spicyLevel'].toStringAsFixed(0)} | Portion: ${item['portion']}",
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 "৳${item['price'].toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // 🗑 Delete Button
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.redAccent,
//                           ),
//                           onPressed: () {
//                             setState(() => CartService.removeCart(item));
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text("${item['name']} removed!"),
//                                 duration: const Duration(seconds: 1),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: cartItems.isEmpty
//           ? null
//           : FloatingActionButton.extended(
//               backgroundColor: AppColors.primary,
//               icon: const Icon(Icons.payment),
//               label: const Text(
//                 "Checkout",
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CheckoutPage()),
//                 ).then((_) => setState(() {}));
//               },
//             ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
// lib/pages/cart.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_state.dart';
// import 'package:foodie_app/bloc/cart/cart_event.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartBloc, CartState>(
//       builder: (context, state) {
//         if (state is CartLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state is CartSuccess) {
//           final cartItems = state.items;
//           final total = state.totalAmount;

//           return Scaffold(
//             appBar: AppBar(
//               title: const Text("My Cart 🛒"),
//               backgroundColor: Colors.redAccent,
//             ),
//             body: cartItems.isEmpty
//                 ? const Center(child: Text("Your cart is empty 😢"))
//                 : Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: cartItems.length,
//                           itemBuilder: (context, index) {
//                             final item = cartItems[index];
//                             return Card(
//                               margin: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 8,
//                               ),
//                               elevation: 3,
//                               child: ListTile(
//                                 leading: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     item['image'],
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 title: Text(item['name']),
//                                 subtitle: Text(
//                                   "Spicy: ${item['spicyLevel'] ?? 0} | Portion: ${item['portion'] ?? 1}",
//                                 ),
//                                 trailing: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "৳${(item['price'] ?? 0).toString()}",
//                                       style: const TextStyle(
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.delete,
//                                         color: Colors.redAccent,
//                                       ),
//                                       onPressed: () {
//                                         // remove by index
//                                         context.read<CartBloc>().add(
//                                           RemoveFromCart(index),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),

//                       // bottom summary & checkout
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.shade300,
//                               offset: const Offset(0, -3),
//                               blurRadius: 6,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Subtotal:",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 Text(
//                                   "৳${total.toStringAsFixed(2)}",
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: const [
//                                 Text("Delivery Fee:"),
//                                 Text("৳50"),
//                               ],
//                             ),
//                             const Divider(height: 20, thickness: 1),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Total:",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   "৳${(total + 50).toStringAsFixed(2)}",
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.redAccent,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.redAccent,
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 14,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   // If you want, you can dispatch a Checkout event here
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("Payment Successful 🎉"),
//                                     ),
//                                   );
//                                   context.read<CartBloc>().add(ClearCart());
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text(
//                                   "Proceed to Payment",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//           );
//         }

//         if (state is CartError) {
//           return Scaffold(
//             body: Center(
//               child: Text(
//                 "Error: ${state.message}",
//                 style: const TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             ),
//           );
//         }

//         // default fallback
//         return const Scaffold(body: Center(child: CircularProgressIndicator()));
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_event.dart';
import 'package:foodie_app/bloc/cart/cart_state.dart';
import 'package:foodie_app/pages/Checkout.dart';
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CheckoutPage()),
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
