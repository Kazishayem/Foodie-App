import 'package:flutter/material.dart';
import 'package:foodie_app/constants/colors.dart';
import 'package:foodie_app/widgets/CartCount.dart';
import 'package:foodie_app/services/cartService.dart';

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
    double basePrice = widget.product['price'] ?? 20;
    double totalPrice = basePrice * portion;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
        backgroundColor: AppColors.secondary,
        actions: const [CartCount()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(widget.product['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              widget.product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.product['subtitle'] ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

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

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Spicy
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Spicy",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Slider(
                        value: spicyLevel,
                        min: 0,
                        max: 2,
                        divisions: 2,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.grey.shade300,
                        onChanged: (value) =>
                            setState(() => spicyLevel = value),
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

                /// Portion
                Column(
                  children: [
                    const Text(
                      "Portion",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => setState(() {
                            if (portion > 1) portion--;
                          }),
                        ),
                        Text(
                          "$portion",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.green,
                          ),
                          onPressed: () => setState(() => portion++),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "৳${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    CartService.addCart({
                      ...widget.product,
                      "portion": portion,
                      "spicyLevel": spicyLevel,
                      "price": totalPrice, // ✅ dynamic price
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${widget.product['name']} added to cart 🛒",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "ORDER NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
