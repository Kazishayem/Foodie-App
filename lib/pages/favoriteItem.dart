import 'package:flutter/material.dart';
import 'package:foodie_app/services/FavoriteService.dart';
import 'package:foodie_app/constants/colors.dart';

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
      appBar: AppBar(title: const Text("Favorite Items")),
      body: favList.isEmpty
          ? const Center(child: Text("No favorite items yet ❤️"))
          : ListView.builder(
              itemCount: favList.length,
              itemBuilder: (context, index) {
                final item = favList[index];
                return ListTile(
                  title: Text(item['name']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.primary),
                    onPressed: () {
                      setState(() {
                        FavoriteService.removeFavorite(item);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
