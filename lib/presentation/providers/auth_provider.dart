import 'package:flutter/material.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/entities/user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUser _loginUser;
  final RegisterUser _registerUser;

  AuthProvider(this._loginUser, this._registerUser);

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _token;
  User? _user;
  String? _errorMessage;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get token => _token;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }


  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final (token, user) = await _loginUser(email, password);
      _token = token;
      _user = user;
      _isLoggedIn = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Error de red o credenciales invalidas');
    }

    _isLoggedIn = false;
    _token = null;
    _user = null;
    _setLoading(false);
    return false;
  }


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
      final user = await _registerUser(name, email, password, rol, tiendaId);
      _user = user;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('No se pudo registrar el usuario');
      _setLoading(false);
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    _token = null;
    _user = null;
    notifyListeners();
  }
}
