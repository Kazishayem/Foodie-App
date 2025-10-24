// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/ProductModel.dart';

// class ProductRepository {
//   static const String _baseUrl =
//       'https://www.themealdb.com/api/json/v1/1/categories.php';
//   // static const String _countryListEndpoint = '/country-list';

//   Future<List<Product>> getCountries() async {
//     try {
//       final response = await http.get(
//         Uri.parse(_baseUrl),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((json) => Product.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load Products: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load Products: $e');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ProductModel.dart';

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
