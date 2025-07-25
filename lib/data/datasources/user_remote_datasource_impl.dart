import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_endpoints.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> getUserProfile(String token);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;

  UserRemoteDatasourceImpl(this.client);

  @override
  Future<UserModel> getUserProfile(String token) async {
    final response = await client.get(
      Uri.parse(ApiEndpoints.profile),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      // Asegúrate de que la clave sea correcta: 'user', 'data', etc.
      final userJson = json['user'] ?? json;
      return UserModel.fromJson(userJson);
    } else {
      throw Exception('Error al obtener el perfil del usuario');
    }
  }
  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.products),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(product.toJson()),
    );

    if (response.statusCode == 201) {
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      return ProductModel.fromJson(decoded);
    } else {
      throw Exception('Error al crear el producto');
    }
  }

}
