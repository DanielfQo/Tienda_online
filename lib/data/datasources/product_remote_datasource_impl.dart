import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../api_endpoints.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> createProduct(ProductModel product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(ApiEndpoints.products));

    if (response.statusCode == 200) {
      final List decoded = json.decode(utf8.decode(response.bodyBytes));
      return decoded.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.products),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer TU_TOKEN'
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      return ProductModel.fromJson(decoded);
    } else {
      throw Exception('Error al crear producto');
    }
  }

}
