import 'package:flutter/material.dart';
import 'package:foodie_app/constants/colors.dart';
import 'package:foodie_app/widgets/CategoryFoods.dart';
import 'package:foodie_app/services/cartService.dart';
import 'package:foodie_app/pages/cart.dart';
import 'package:foodie_app/widgets/CartCount.dart';

class ProductShow extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductShow({super.key, required this.product});

  @override
  State<ProductShow> createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
  double spicyLevel = 1;
  int portion = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.product['name']),
      //   backgroundColor: AppColors.primary,
      // ),
      appBar: AppBar(
        title: Text(widget.product['name']),
        backgroundColor: AppColors.secondary,
        actions: const [
          CartCount(), // ✅ custom widget
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Product Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(widget.product['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🏷️ Product Name
            Text(
              widget.product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // 🧾 Subtitle
            Text(
              widget.product['subtitle'],
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // ⭐ Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 22),
                const SizedBox(width: 5),
                Text(
                  widget.product['rating'].toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Text(
              widget.product['description'] ?? 'No description available.',
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 🔹 Left: Spicy Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Spicy",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Slider(
                        value: spicyLevel,
                        min: 0,
                        max: 2,
                        divisions: 2,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.grey.shade300,
                        onChanged: (value) {
                          setState(() {
                            spicyLevel = value;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Mild", style: TextStyle(color: Colors.green)),
                          Text("Hot", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 80),

                /// 🔹 Right: Portion Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Portion",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        // Minus Button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if (portion > 1) portion--;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "$portion",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Plus Button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                portion++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔹 Price Button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "\$9.99",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                // 🔹 Order Now Button
                ElevatedButton(
                  onPressed: () {
                    CartService.addCart({
                      ...widget.product,
                      "portion": portion,
                      "spicyLevel": spicyLevel,
                    });
                    print("🛒 Cart items: ${CartService.cartItems}");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${widget.product['name']} added to cart 🛒",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Cart()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF3E2723,
                    ), // dark brown color
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    shadowColor: Colors.brown.withOpacity(0.4),
                  ),
                  child: const Text(
                    "ORDER NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
