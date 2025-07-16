import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource_impl.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<User> getUserProfile(String token) async {
    final userModel = await remoteDatasource.getUserProfile(token);
    return userModel; // Ya es un User si tu UserModel extiende User, o convierte si no
  }
}
