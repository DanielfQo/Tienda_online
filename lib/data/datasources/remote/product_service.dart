import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_online/data/models/product_model.dart';
import 'package:tienda_online/domain/entities/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts(String token) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/api/products'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded
      .map((e) => ProductModel.fromJson(e).toEntity())
      .toList();
    } else {
      throw Exception('Error al obtener productos');
    }
  }
}
