import '../entities/user.dart';
import '../../data/repositories/user_repository_impl.dart';

class GetUserProfile {
  final UserRepository repository;

  GetUserProfile(this.repository);

  Future<User> call(String token) {
    return repository.getUserProfile(token);
  }
}
