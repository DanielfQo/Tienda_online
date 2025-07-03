import 'package:flutter/material.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUser _loginUser;
  final RegisterUser _registerUser;

  AuthProvider(this._loginUser, this._registerUser);

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _token;
  String? _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Iniciar sesión usando el caso de uso
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final result = await _loginUser(email, password);
      if (result != null) {
        _token = result;
        _isLoggedIn = true;
        _setLoading(false);
        return true;
      } else {
        _setError('Credenciales incorrectas');
      }
    } catch (e) {
      _setError('Error de red. Intenta más tarde.');
    }

    _isLoggedIn = false;
    _token = null;
    _setLoading(false);
    return false;
  }

  /// Registro usando el caso de uso
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String rol = 'cliente',
    int? tiendaId,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final success = await _registerUser(
        name,
        email,
        password,
        rol,
        tiendaId,
      );

      if (!success) {
        _setError('No se pudo registrar el usuario');
      }

      _setLoading(false);
      return success;
    } catch (e) {
      _setError('Error de red. Intenta más tarde.');
      _setLoading(false);
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _token = null;
    notifyListeners();
  }
}
