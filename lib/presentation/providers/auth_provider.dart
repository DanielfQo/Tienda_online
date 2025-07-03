import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;

  /// Método de login
  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://10.0.2.2:5000/api/usuarios/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': username,
          'contrasena': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['access_token'];
        _isLoggedIn = true;
      } else {
        _isLoggedIn = false;
        _token = null;
      }
    } catch (e) {
      _isLoggedIn = false;
      _token = null;
    }

    notifyListeners();
  }

  /// Método de registro
  Future<bool> register({
    required String nombre,
    required String correo,
    required String contrasena,
    String rol = 'cliente',
    int? tiendaId,
  }) async {
    final url = Uri.parse('http://10.0.2.2:5000/api/usuarios/registro');

    try {
      final response = await http.post(
        url,
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
    } catch (e) {
      return false;
    }
  }

  /// Método para cerrar sesión
  void logout() {
    _isLoggedIn = false;
    _token = null;
    notifyListeners();
  }
}
