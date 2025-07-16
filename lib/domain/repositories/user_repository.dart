import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUserProfile(String token);
}
