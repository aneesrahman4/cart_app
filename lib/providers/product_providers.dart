import 'dart:developer';

import 'package:cart_app/model/product_model.dart';
import 'package:cart_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cart_app/product_model/product_ model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Future<void> fetchProducts() async {
    _isLoading = true;
    try {
      final response = await ApiService().fecthProducts();
      if (response.statusCode == 200)
        _products =
            (response.data as List<dynamic>)
                .map((result) => Product.fromJson(result))
                .toList();
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
