import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../api_endpoints.dart';

abstract class AuthRemoteDatasource {
  Future<String?> login(String email, String password);
  Future<bool> register({
    required String nombre,
    required String correo,
    required String contrasena,
    String rol,
    int? tiendaId,
  });
}


class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<String?> login(String email, String password) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'correo': email,
        'contrasena': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      return null;
    }
  }

  @override
  Future<bool> register({
    required String nombre,
    required String correo,
    required String contrasena,
    String rol = 'cliente',
    int? tiendaId,
  }) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
        'rol': rol,
        'tienda_id': tiendaId, // puede ser null
      }),
    );

    return response.statusCode == 201;
  }
}
