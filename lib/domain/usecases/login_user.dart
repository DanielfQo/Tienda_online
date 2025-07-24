import '../entities/user.dart';
import '../../data/repositories/auth_repository_impl.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<(String token, User user)> call(String email, String password) {
    return repository.login(email, password);
  }
}
