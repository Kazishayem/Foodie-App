import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Product/product_bloc.dart';
import '../bloc/Product/product_event.dart';
import '../bloc/Product/product_state.dart';
import '../repositories/product_repository.dart';
import '../pages/ProductShow.dart';
import '../services/FavoriteService.dart';
import '../constants/colors.dart';

class CategoryFoodsPage extends StatelessWidget {
  const CategoryFoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(ProductRepository())..add(FetchProducts()),
      child: const CategoryFoods(),
    );
  }
}

class CategoryFoods extends StatefulWidget {
  const CategoryFoods({super.key});

  @override
  State<CategoryFoods> createState() => _CategoryFoodsState();
}

class _CategoryFoodsState extends State<CategoryFoods> {
  // Optional: category buttons
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryButton('All'),
                  categoryButton('Combos'),
                  categoryButton('Sliders'),
                  categoryButton('Classic'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Products GridView
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductSuccess) {
                    final products = state.products;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return foodCard(context, {
                          'name': product.title,
                          'subtitle': product.short,
                          'image': product.img,
                          'rating': 4.5, // default rating
                          'description': product.short,
                        });
                      },
                    );
                  } else if (state is ProductEmpty) {
                    return const Center(child: Text('No products found'));
                  } else if (state is ProductError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Category Button Widget
  Widget categoryButton(String title) {
    final isSelected = title == selectedCategory;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
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
      ),
    );
  }

  // Food Card Widget
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
                child: Center(
                  child: Image.network(
                    food['image'],
                    height: 90,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              ),
              Text(
                food['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              // Text(
              //   food['subtitle'],
              //   style: const TextStyle(color: Colors.grey),
              // ),
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
