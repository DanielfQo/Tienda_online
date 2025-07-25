import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

import 'data/datasources/auth_remote_datasource_impl.dart';
import 'data/datasources/user_remote_datasource_impl.dart';
import 'data/datasources/product_remote_datasource_impl.dart';
import 'data/datasources/wish_list_remote_datasource_impl.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/wish_list_repository_impl.dart';

import 'domain/usecases/login_user.dart';
import 'domain/usecases/register_user.dart';
import 'domain/usecases/get_user_profile.dart';
import 'domain/usecases/get_all_products.dart';
import 'domain/usecases/create_product.dart';

import 'domain/usecases/add_product_to_wishlist_usecase.dart';
import 'domain/usecases/get_wishlist_usecase.dart';

import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/providers/products_provider.dart';
import 'presentation/providers/wishlist_provider.dart';


void main() {
  final client = http.Client();

  // Auth
  final authDatasource = AuthRemoteDatasourceImpl(client);
  final authRepository = AuthRepositoryImpl(authDatasource);
  final loginUserUsecase = LoginUser(authRepository);
  final registerUserUsecase = RegisterUser(authRepository);

  // User
  final userDatasource = UserRemoteDatasourceImpl(client);
  final userRepository = UserRepositoryImpl(userDatasource);
  final userProfileUsecase = GetUserProfile(userRepository);

  // Products
  final productsDatasource = ProductRemoteDataSourceImpl(client);
  final productsRepository = ProductRepositoryImpl(productsDatasource);
  final getAllProductsUsecase = GetAllProducts(productsRepository);
  final createProductUsecase = CreateProduct(productsRepository);

  // Wishlist
  final wishlistDatasource = WishListRemoteDatasourceImpl(client);
  final wishlistRepository = WishlistRepositoryImpl(wishlistDatasource);
  final getWishlistUsecase = GetWishlistUseCase(wishlistRepository);
  final addProductToWishlistUsecase = AddProductToWishlistUseCase(wishlistRepository);

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
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(
            getWishlistUseCase: getWishlistUsecase,
            addProductToWishlistUseCase: addProductToWishlistUsecase,
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

