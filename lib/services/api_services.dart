import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cart_app/product_model/product_ model.dart';

class ApiService {
  static const String baseUrl =
      'https://cart-app-backend-3nff.onrender.com/api/product';

  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
