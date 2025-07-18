import '../entities/user.dart';
import '../../data/repositories/auth_repository_impl.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(
    String name,
    String email,
    String password, [
    String rol = 'client',
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
