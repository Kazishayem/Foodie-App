import 'dart:convert';
import 'package:http/http.dart' as http;
import '../lib/models/ProductModel.dart'; // তোমার model এর path অনুযায়ী adjust করো

void main() async {
  final repository = ProductRepository();

  try {
    final products = await repository.getProducts();

    print('Total products: ${products.length}');
    for (var product in products) {
      print('ID: ${product.id}');
      print('Title: ${product.title}');
      print('Image: ${product.img}');
      print(
        'Short: ${product.short.substring(0, 50)}...',
      ); // শুধু 50 char দেখাচ্ছে
      print('----------------------------');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Repository code
class ProductRepository {
  static const String _baseUrl =
      'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> jsonData = data['categories'];

        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load Products: $e');
    }
  }
}
