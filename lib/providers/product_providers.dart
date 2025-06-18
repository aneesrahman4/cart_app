import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cart_app/product_model/product_ model.dart';

class ProductProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _dio.get(
        'https://cart-app-backend-3nff.onrender.com/api/product',
      );
      _products =
          (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      _error = 'Something went wrong';
    }

    _isLoading = false;
    notifyListeners();
  }
}
