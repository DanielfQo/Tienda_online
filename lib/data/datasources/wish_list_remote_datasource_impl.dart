import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_endpoints.dart';
import '../models/product_model.dart';

abstract class WishlistRemoteDatasource {
  Future<List<ProductModel>> getOrCreateWishlist({required int clientId, required String token});
  Future<bool> addProductToWishlist({required int productId, required int clientId, required String token});
}

class WishListRemoteDatasourceImpl implements WishlistRemoteDatasource {
  final http.Client client;

  WishListRemoteDatasourceImpl(this.client);

  @override
  Future<List<ProductModel>> getOrCreateWishlist({required int clientId, String? token}) async {
    final url = Uri.parse('${ApiEndpoints.wishlist}/items');
    final response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => ProductModel.fromJson(item['product']))
          .toList();
    } else {
      print('Error al obtener wishlist: ${response.body}');
      throw Exception('No se pudo obtener la wishlist');
    }
  }


  @override
  Future<bool> addProductToWishlist({required int productId, required int clientId, required String token}) async {
    final url = Uri.parse('${ApiEndpoints.wishlist}/items');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json.encode({'product_id': productId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Error al añadir producto a wishlist: ${response.body}');
      return false;
    }
  }

}
