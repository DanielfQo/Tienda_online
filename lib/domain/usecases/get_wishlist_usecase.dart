import '../entities/product.dart';
import '../../data/repositories/wish_list_repository_impl.dart';

class GetWishlistUseCase {
  final WishlistRepository repository;

  GetWishlistUseCase(this.repository);

  Future<List<Product>> call({
    required int clientId,
    required String token,
  }) {
    return repository.getOrCreateWishlist(clientId: clientId, token: token);
  }
}
