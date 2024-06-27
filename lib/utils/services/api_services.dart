import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pruduct_app/models/product/product.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts(
      {int skip = 0, int limit = 10, String search = ''}) async {
    final response =
        await http.get(Uri.parse('$baseUrl?limit=$limit&skip=$skip&q=$search'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
