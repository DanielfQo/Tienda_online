import '../../domain/entities/product.dart';
import '../datasources/product_remote_datasource_impl.dart';
import '../models/product_model.dart';


abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> createProduct(Product product, String token);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await remoteDataSource.getAllProducts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Product> createProduct(Product product, String token) async {
    final model = ProductModel.fromEntity(product);
    final createdModel = await remoteDataSource.createProduct(model, token);
    return createdModel.toEntity();
  }
}

