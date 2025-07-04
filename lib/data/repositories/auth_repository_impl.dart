import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<(String token, User)> login(String email, String password) async {
    final (token, userModel) = await remoteDatasource.login(email, password);
    return (token, userModel);
  }

  @override
  Future<User> register(String nombre, String correo, String contrasena, String rol, int? tiendaId) {
    return remoteDatasource.register(nombre, correo, contrasena, rol, tiendaId);
  }
}
