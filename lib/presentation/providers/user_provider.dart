import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_profile.dart';

class UserProvider with ChangeNotifier {
  final GetUserProfile getUserProfile;

  User? _user;
  bool _loading = false;

  UserProvider(this.getUserProfile);

  User? get user => _user;
  bool get isLoading => _loading;

  Future<void> loadUserProfile(String token) async {
    _loading = true;
    notifyListeners();

    try {
      _user = await getUserProfile(token);
    } catch (e) {
      debugPrint('Error al cargar el perfil: $e');
    }

    _loading = false;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
