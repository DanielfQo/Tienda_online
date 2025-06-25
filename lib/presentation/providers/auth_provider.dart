import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Simula login
  void login(String username, String password) {
    // Aquí podrías llamar a tu API para autenticar
    // Por ejemplo, si usuario y contraseña son correctos:
    if (username == 'user' && password == '1234') {
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
