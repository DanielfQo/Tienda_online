import '../../domain/entities/product.dart';
import '../datasources/wish_list_remote_datasource_impl.dart';
import '../models/product_model.dart';

abstract class WishlistRepository {
  Future<List<Product>> getOrCreateWishlist({required int clientId, required String token});
  Future<bool> addProductToWishlist( {required int productId, required int clientId, required String token});
}

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDatasource remoteDatasource;

  WishlistRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Product>> getOrCreateWishlist({required int clientId, required String token}) async {
    final List<ProductModel> productModels =
        await remoteDatasource.getOrCreateWishlist(clientId: clientId, token: token);

    return productModels.map((model) {
      return Product(
        id: model.id,
        name: model.name,
        description: model.description,
        purchasePrice: model.purchasePrice,
        salePrice: model.salePrice,
        stock: model.stock,
        createdAt: model.createdAt,
        imageUrls: model.imageUrls,
        attributes: model.attributes,
        oferta: model.oferta,
        isLiked: true, // ya que está en wishlist, asumimos que le dio like
      );
    }).toList();
  }

  @override
  Future<bool> addProductToWishlist({ required int productId, required int clientId, required String token}) {
    return remoteDatasource.addProductToWishlist(productId: productId, clientId: clientId, token: token);
  }
}
