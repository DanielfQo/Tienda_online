import 'package:flutter/material.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/entities/product.dart';

class ProductsProvider with ChangeNotifier {
  final GetAllProducts _getAllProducts;

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ProductsProvider(this._getAllProducts);

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await _getAllProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}