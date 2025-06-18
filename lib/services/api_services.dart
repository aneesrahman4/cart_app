import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cart_app/product_model/product_ model.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://cart-app-backend-3nff.onrender.com/api/product',
      connectTimeout: const Duration(seconds: 20), // Increased timeout
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );

  static Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get('');
      final List data = response.data;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch products: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
