import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CartProvider with ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://cart-app-backend-3nff.onrender.com/api'),
  );

  List<dynamic> _cartItems = [];
  bool _isLoading = false;
  String? _error;
  String? _token;

  List<dynamic> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setToken(String token) {
    _token = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
    notifyListeners();
  }

  Future<void> fetchCart() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Add authentication header if token exists
      if (_token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $_token';
      }

      final response = await _dio.get('/cart');
      if (response.data is List) {
        _cartItems = response.data;
      } else if (response.data is Map && response.data['cart'] is List) {
        _cartItems = response.data['cart'];
      } else if (response.data is Map && response.data['items'] is List) {
        _cartItems = response.data['items'];
      } else {
        _cartItems = [];
      }
    } catch (e) {
      if (e is DioException) {
        _error =
            'Server error: ${e.response?.statusCode} - ${e.response?.data}';
      } else {
        _error = 'Network error: ${e.toString()}';
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(String productId, BuildContext context) async {
    try {
      final response = await _dio.post(
        '/cart/add',
        data: {'productId': productId},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('✅ Added to cart')));
        await fetchCart();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❌ Failed to add to cart')));
    }
  }

  Future<void> deleteFromCart(String cartItemId) async {
    try {
      await _dio.delete('/cart/item/$cartItemId');
      await fetchCart();
    } catch (e) {
      if (e is DioException) {
        _error =
            'Delete failed: ${e.response?.statusCode} - ${e.response?.data}';
      } else {
        _error = 'Delete failed: ${e.toString()}';
      }
      notifyListeners();
    }
  }

  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    try {
      final response = await _dio.put(
        '/cart/item/$cartItemId',
        data: {'quantity': quantity},
      );

      if (response.statusCode == 200) {
        await fetchCart();
      } else {
        _error = 'Failed to update quantity: ${response.statusCode}';
        notifyListeners();
      }
    } catch (e) {
      if (e is DioException) {
        _error =
            'Update failed: ${e.response?.statusCode} - ${e.response?.data}';
      } else {
        _error = 'Update failed: ${e.toString()}';
      }
      notifyListeners();
    }
  }
}
