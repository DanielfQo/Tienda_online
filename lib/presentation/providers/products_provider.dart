import 'package:flutter/material.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_product.dart';

class ProductsProvider with ChangeNotifier {
  final GetAllProducts _getAllProducts;
  final CreateProduct _createProduct;

  ProductsProvider(this._getAllProducts, this._createProduct);

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;


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
  Future<bool> createNewProduct(Product product, String token) async {
    try {
      await _createProduct(product, token);
      await loadProducts(); // recarga
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
