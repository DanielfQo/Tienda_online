import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<bool> call(
    String name,
    String email,
    String password, [
    String rol = 'cliente',
    int? tiendaId,
  ]) {
    return repository.register(name, email, password, rol: rol, tiendaId: tiendaId);
  }
}
