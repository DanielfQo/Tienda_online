import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_online/routes/app_routes.dart';
import 'custom_bottom_nav_bar.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  int _getIndex(String location) {
    if (location.startsWith(AppRoutes.search)) return 1;
    if (location.startsWith(AppRoutes.cart)) return 2;
    if (location.startsWith(AppRoutes.wishList)) return 3;
    return 0; // default: home
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(AppRoutes.home); break;
      case 1: context.go(AppRoutes.search); break;
      case 2: context.go(AppRoutes.cart); break;
      case 3: context.go(AppRoutes.wishList); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}
