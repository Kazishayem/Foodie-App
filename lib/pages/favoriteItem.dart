// import 'package:flutter/material.dart';
// import 'package:foodie_app/services/FavoriteService.dart';
// import 'package:foodie_app/constants/colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_bloc.dart';
// import 'package:foodie_app/bloc/cart/cart_event.dart';
// import 'package:foodie_app/bloc/cart/cart_state.dart';

// class FavoriteItem extends StatefulWidget {
//   const FavoriteItem({super.key});

//   @override
//   State<FavoriteItem> createState() => _FavoriteItemState();
// }

// class _FavoriteItemState extends State<FavoriteItem> {
//   @override
//   Widget build(BuildContext context) {
//     final favList = FavoriteService.favoriteItems;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Favorite Items ❤️"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: favList.isEmpty
//           ? const Center(
//               child: Text(
//                 "No favorite items yet ❤️",
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: favList.length,
//               itemBuilder: (context, index) {
//                 final item = favList[index];
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
//                                 "৳${item['price'].toString()}",
//                                 style: const TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         // 🛒 Add to Cart Button
//                         IconButton(
//                           icon: const Icon(
//                             Icons.add_shopping_cart,
//                             color: Colors.blueAccent,
//                           ),
//                           onPressed: () {
//                             context.read<CartBloc>().add(AddToCart(item));
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   "${item['name']} added to cart 🛒",
//                                 ),
//                                 duration: const Duration(seconds: 1),
//                               ),
//                             );
//                           },
//                         ),

//                         // ❌ Remove from Favorite Button
//                         IconButton(
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.redAccent,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               FavoriteService.removeFavorite(item);
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   "${item['name']} removed from favorites",
//                                 ),
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

//       // 🧹 Optional Floating Button (Clear all)
//       floatingActionButton: favList.isEmpty
//           ? null
//           : FloatingActionButton.extended(
//               backgroundColor: AppColors.primary,
//               icon: const Icon(Icons.delete_forever),
//               label: const Text(
//                 "Clear All",
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () {
//                 setState(() {
//                   FavoriteService.favoriteItems.clear();
//                 });
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("All favorites cleared ❌"),
//                     duration: Duration(seconds: 1),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:foodie_app/services/FavoriteService.dart';
import 'package:foodie_app/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_bloc.dart';
import 'package:foodie_app/bloc/cart/cart_event.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    final favList = FavoriteService.favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Items ❤️"),
        backgroundColor: Colors.redAccent,
      ),
      body: favList.isEmpty
          ? const Center(
              child: Text(
                "No favorite items yet ❤️",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favList.length,
              itemBuilder: (context, index) {
                final item = favList[index];

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
                        /// Product Image
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

                        /// Product Details
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
                                "৳${item['price']}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// ✅ Add to Cart
                        IconButton(
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            context.read<CartBloc>().add(AddToCart(item));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${item['name']} added to cart 🛒",
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),

                        /// ❌ Remove from favorite
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              FavoriteService.removeFavorite(item);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${item['name']} removed from favorites ❌",
                                ),
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

      floatingActionButton: favList.isEmpty
          ? null
          : FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.delete_forever),
              label: const Text(
                "Clear All",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  FavoriteService.favoriteItems.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All favorites cleared ❌"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
