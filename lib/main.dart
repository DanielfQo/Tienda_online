import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/register_user.dart';
import 'presentation/providers/auth_provider.dart';


void main() {

  final client = http.Client();
  final authDatasource = AuthRemoteDatasourceImpl(client);
  final authRepository = AuthRepositoryImpl(authDatasource);
  final loginUserUsecase = LoginUser(authRepository);
  final registerUserUsecase = RegisterUser(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUserUsecase,
            registerUserUsecase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cliente Flutter',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
