import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(
    String name,
    String email,
    String password, [
    String rol = 'cliente',
    int? tiendaId,
  ]) {
    return repository.register(
      name,
      email,
      password,
      rol,
      tiendaId,
    );
  }
}
