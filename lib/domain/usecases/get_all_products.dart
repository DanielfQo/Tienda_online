import '../entities/product.dart';
import '../../data/repositories/product_repository_impl.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAllProducts();
  }
}
