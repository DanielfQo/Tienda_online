import '../../data/repositories/wish_list_repository_impl.dart';

class AddProductToWishlistUseCase {
  final WishlistRepository repository;

  AddProductToWishlistUseCase(this.repository);

  Future<bool> call({ required int productId, required int clientId, required String token}) {
    return repository.addProductToWishlist(productId: productId, clientId: clientId, token: token);
  }
}
