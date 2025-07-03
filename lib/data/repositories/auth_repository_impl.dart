import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<String?> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<bool> register(String name, String email, String password, {String rol = '', int? tiendaId}) {
    return remoteDatasource.register(
      nombre: name,
      correo: email,
      contrasena: password,
      rol: rol,
      tiendaId: tiendaId,
    );
  }
}
