import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import '../../domain/usecases/add_product_to_wishlist_usecase.dart';

class WishlistProvider with ChangeNotifier {
  final GetWishlistUseCase getWishlistUseCase;
  final AddProductToWishlistUseCase addProductToWishlistUseCase;

  List<Product> _wishlist = [];
  bool _isLoading = false;

  List<Product> get wishlist => _wishlist;
  bool get isLoading => _isLoading;

  WishlistProvider({
    required this.getWishlistUseCase,
    required this.addProductToWishlistUseCase,
  });

  Future<void> loadWishlist(int clientId, String token) async {
    _isLoading = true;
    notifyListeners();

    try {

      _wishlist = await getWishlistUseCase(clientId: clientId, token: token);
    } catch (e) {
      print('Error al cargar wishlist provider: $e');
      _wishlist = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToWishlist(int productId, int clientId, String token) async {
    final success = await addProductToWishlistUseCase(productId: productId, clientId: clientId, token: token);

    if (success) {
      await loadWishlist(clientId, token); // recarga la lista
    }
  }

  bool isProductInWishlist(int productId) {
    return _wishlist.any((product) => product.id == productId);
  }
}
