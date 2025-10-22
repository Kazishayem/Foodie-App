class FavoriteService {
  static List<Map<String, dynamic>> favoriteItems = [];

  static bool isFavorite(Map<String, dynamic> item) {
    return favoriteItems.contains(item);
  }

  static void addFavorite(Map<String, dynamic> item) {
    if (!favoriteItems.contains(item)) {
      favoriteItems.add(item);
    }
  }

  static void removeFavorite(Map<String, dynamic> item) {
    favoriteItems.remove(item);
  }
}
