import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';
import '../presentation/pages/main_page.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/register_page.dart';
import '../presentation/pages/profile_page.dart';
import '../presentation/pages/account_page.dart';
import '../presentation/pages/order_history_page.dart';
import '../presentation/pages/address_page.dart';
import '../presentation/pages/cart_page.dart';
import '../presentation/pages/search_page.dart';
import '../presentation/pages/wish_list_page.dart';
import '../presentation/widgets/main_shell.dart';
import '../presentation/pages/home_admin_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),

    GoRoute(
      path: AppRoutes.account,
      builder: (context, state) => const AccountPage(),
    ),

    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.orderHistory,
      builder: (context, state) => const OrderHistoryPage(),
    ),
    GoRoute(
      path: AppRoutes.addressBook,
      builder: (context, state) => const AddressPage(),
    ),
    GoRoute(
      path: AppRoutes.homeAdmin,
      builder: (context, state) => const HomeAdminPage(),
    ),
  ],
);
