import 'package:flutter/material.dart';
import 'package:foodie_app/constants/colors.dart';
import 'package:foodie_app/pages/ProductShow.dart';
import 'package:foodie_app/services/FavoriteService.dart';

class CategoryFoods extends StatefulWidget {
  const CategoryFoods({super.key});

  @override
  State<CategoryFoods> createState() => _CategoryFoodsState();
}

class _CategoryFoodsState extends State<CategoryFoods> {
  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Cheeseburger',
      'subtitle': "Cheeseburger Burger",
      'rating': 4.9,
      'image': 'assets/images/burger3.png',
      'description':
          'The Cheeseburger Wendys Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it\'s topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.',
    },
    {
      'name': 'Hamburger',
      'subtitle': 'Veggie Burger',
      'rating': 4.8,
      'image': 'assets/images/burger5.png',
      'description':
          'Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.',
    },
    {
      'name': 'Hamburger',
      'subtitle': 'Chicken Burger',
      'rating': 4.6,
      'image': 'assets/images/burger4.png',
      'description':
          'Enjoy our delicious Hamburger Chicken Burger, made with juicy chicken fillet and fresh veggies, topped with creamy mayo and served on a soft, toasted bun.',
    },
    {
      'name': 'Hamburger',
      'subtitle': 'Fried Chicken Burger',
      'rating': 4.5,
      'image': 'assets/images/burger3.png',
      'description':
          'Our Fried Chicken Burger comes with a crispy fried chicken fillet, lettuce, tomato, and tangy sauce inside a fluffy bun.',
    },
    {
      'name': 'Hamburger',
      'subtitle': 'Double Patty Burger',
      'rating': 4.5,
      'image': 'assets/images/burger4.png',
      'description':
          'Double the flavor! Two juicy patties stacked with cheese, lettuce, and special sauce for a mouth-watering experience.',
    },
    {
      'name': 'Hamburger',
      'subtitle': 'Double Patty Burger',
      'rating': 4.5,
      'image': 'assets/images/burger4.png',
      'description':
          'Double the flavor! Two juicy patties stacked with cheese, lettuce, and special sauce for a mouth-watering experience.',
    },
    {
      'name': 'Meatbox',
      'subtitle': 'Meatbox',
      'rating': 4.5,
      'image': 'assets/images/meatbox.jpg',
      'description':
          'Double the flavor! Two juicy patties stacked with cheese, lettuce, and special sauce for a mouth-watering experience.',
    },
    {
      'name': 'Meatbox',
      'subtitle': 'Meatbox',
      'rating': 4.5,
      'image': 'assets/images/meatbox.jpg',
      'description':
          'Double the flavor! Two juicy patties stacked with cheese, lettuce, and special sauce for a mouth-watering experience.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryButton('All', isSelected: true),
                  categoryButton('Combos'),
                  categoryButton('Sliders'),
                  categoryButton('Classic'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Grid View
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return foodCard(context, food);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String title, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: Colors.red.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget foodCard(BuildContext context, Map<String, dynamic> food) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductShow(product: food)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(child: Image.asset(food['image'], height: 90)),
              ),
              Text(
                food['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                food['subtitle'],
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(food['rating'].toString()),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      FavoriteService.isFavorite(food)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: FavoriteService.isFavorite(food)
                          ? AppColors.primary
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        if (FavoriteService.isFavorite(food)) {
                          FavoriteService.removeFavorite(food);
                        } else {
                          FavoriteService.addFavorite(food);
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
