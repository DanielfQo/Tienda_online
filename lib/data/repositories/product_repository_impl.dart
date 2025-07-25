import '../../domain/entities/product.dart';
import '../datasources/product_remote_datasource_impl.dart';
import '../models/product_model.dart';


abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> createProduct(Product product);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await remoteDataSource.getAllProducts();
    return models;
  }
  @override
  Future<Product> createProduct(Product product) async {
    final model = ProductModel.fromEntity(product);
    final created = await remoteDataSource.createProduct(model);
    return created.toEntity();
  }

}
