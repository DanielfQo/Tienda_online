import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_endpoints.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<(String token, UserModel user)> login(String email, String password);
  Future<UserModel> register(
    String nombre,
    String correo,
    String contrasena,
    String rol,
    int? tiendaId,
  );
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDatasourceImpl(this.client);

  @override
  Future<(String token, UserModel user)> login(
    String email,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final token = json['access_token'];

      //  un usuario temporal
      final user = UserModel(
        id: 0,
        nombre: 'Usuario Temporal',
        correo: email,
        rol: 'client',
        tiendaId: null,
        verificado: false,
      );
      return (token.toString(), user);
    } else {
      throw Exception('Login fallido');
    }
  }

  @override
  Future<UserModel> register(
    String nombre,
    String correo,
    String contrasena,
    String rol,
    int? tiendaId,
  ) async {
    final response = await client.post(
      Uri.parse(ApiEndpoints.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': nombre,
        'email': correo,
        'password': contrasena,
        'role': rol,
        'store_id': tiendaId,
      }),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return UserModel.fromJson(json);
    } else {
      throw Exception('Registro fallido');
    }
  }
}
