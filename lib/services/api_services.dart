import 'package:dio/dio.dart';
import 'package:cart_app/model/product_model.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://cart-app-backend-3nff.onrender.com/api',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );

  // Product methods
  Future<Response> fecthProducts() async {
    return await _dio.get('/product');
  }

  // Cart methods
  Future<Response> fetchCart() async {
    return await _dio.get('/cart');
  }

  Future<Response> addToCart(String productId) async {
    return await _dio.post('/cart/add', data: {'productId': productId});
  }

  Future<Response> deleteFromCart(String cartItemId) async {
    return await _dio.delete('/cart/item/$cartItemId');
  }

  Future<Response> updateCartItemQuantity(
    String cartItemId,
    int quantity,
  ) async {
    return await _dio.put(
      '/cart/item/$cartItemId',
      data: {'quantity': quantity},
    );
  }

  // Auth method
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
