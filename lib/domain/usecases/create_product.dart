import '../entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';

class CreateProduct {
  final ProductRepository repository;

  CreateProduct(this.repository);

  Future<void> call(Product product, String token) {
    return repository.createProduct(product, token);
  }
}
