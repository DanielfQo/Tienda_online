import '../entities/user.dart';

abstract class AuthRepository {
  Future<String?> login(String email, String password);
  Future<bool> register(String name, String email, String password, {
    String rol = 'cliente',
    int? tiendaId,
  });
  // Puedes agregar mas logout, register, getUserInfo...
}
