import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cart_app/model/cart_model.dart';
import 'package:cart_app/services/api_services.dart';

class CartProvider with ChangeNotifier {
  List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _token;

  void setToken(String token) {
    _token = token;
    ApiService().setAuthToken(token);
    notifyListeners();
  }

  Future<void> fetchCart() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService().fetchCart();

      if (response.statusCode == 200) {
        List<dynamic> items = [];

        if (response.data is List) {
          items = response.data;
        } else if (response.data is Map && response.data['cart'] is List) {
          items = response.data['cart'];
        } else if (response.data is Map && response.data['items'] is List) {
          items = response.data['items'];
        }

        _cartItems = items.map((item) => Cart.fromJson(item)).toList();
      } else {
        _error = 'Unexpected response: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Failed to fetch cart: ${e.toString()}';
      log(_error!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(String productId) async {
    try {
      final response = await ApiService().addToCart(productId);
      if (response.statusCode == 200) {
        await fetchCart();
      } else {
        _error = 'Failed to add: ${response.statusMessage}';
        log(_error!);
      }
    } catch (e) {
      _error = '❌ Failed to add to cart: ${e.toString()}';
      log(_error!);
    }
  }

  Future<void> deleteFromCart(String cartItemId) async {
    try {
      await ApiService().deleteFromCart(cartItemId);
      await fetchCart();
    } catch (e) {
      _error = 'Delete failed: ${e.toString()}';
      log(_error!);
      notifyListeners();
    }
  }

  Future<void> updateCartItemQuantity(String cartItemId, int quantity) async {
    log('⚠️ Quantity update skipped. Cart model does not support quantity.');
  }
}
