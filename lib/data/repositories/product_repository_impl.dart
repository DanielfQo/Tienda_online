import '../../domain/entities/product.dart';
import '../datasources/product_remote_datasource_impl.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await remoteDataSource.getAllProducts();
    return models;
  }
}
