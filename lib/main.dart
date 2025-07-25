import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/datasources/user_remote_datasource_impl.dart';
import 'data/datasources/product_remote_datasource_impl.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';

import 'domain/usecases/login_user.dart';
import 'domain/usecases/register_user.dart';
import 'domain/usecases/get_user_profile.dart';
import 'domain/usecases/get_all_products.dart';
import 'domain/usecases/create_product.dart';


import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/products_provider.dart';


void main() {
  final client = http.Client();

  final authDatasource = AuthRemoteDatasourceImpl(client);
  final authRepository = AuthRepositoryImpl(authDatasource);
  final loginUserUsecase = LoginUser(authRepository);
  final registerUserUsecase = RegisterUser(authRepository);

  final userDatasource = UserRemoteDatasourceImpl(client);
  final userRepository = UserRepositoryImpl(userDatasource);
  final userProfileUsecase = GetUserProfile(userRepository);

  final productsDatasource = ProductRemoteDataSourceImpl(client);
  final productsRepository = ProductRepositoryImpl(productsDatasource);
  final getAllProductsUsecase = GetAllProducts(productsRepository);

  final createProductUsecase = CreateProduct(productsRepository);


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(loginUserUsecase, registerUserUsecase),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(userProfileUsecase),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(getAllProductsUsecase, createProductUsecase),
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
