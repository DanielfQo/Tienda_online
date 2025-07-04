import '../entities/user.dart';

abstract class AuthRepository {
  Future<(String token, User)> login(String email, String password);
  Future<User> register(String nombre, String correo, String contrasena, String rol, int? tiendaId);
}