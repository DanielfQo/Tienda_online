import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    )
  ],
);
