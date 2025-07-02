import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: isLoggedIn
            ? _buildLoggedInView(context, authProvider)
            : _buildNotLoggedInView(context),
      ),
    );
  }

  Widget _buildNotLoggedInView(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              'assets/images/background_profile.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => context.go(AppRoutes.home),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        Padding(
          padding: AppTheme.padding.copyWith(top: 0),
          child: Column(
            children: [
              _authButton(
                label: 'INICIA SESIÓN',
                backgroundColor: const Color.fromARGB(255, 254, 201, 140),
                onTap: () => context.go(AppRoutes.login),
              ),
              const SizedBox(height: 12),
              _authButton(
                label: 'REGISTRATE',
                backgroundColor: const Color.fromARGB(255, 254, 169, 70),
                onTap: () => context.go(AppRoutes.register),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoggedInView(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: AppTheme.padding,
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => context.go(AppRoutes.home),
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 48,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          const SizedBox(height: 12),
          Text(
            'KEVIN ANDRE',
            style: AppTheme.h1Style.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              authProvider.logout();
              context.go(AppRoutes.home);
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
            style: ElevatedButton.styleFrom(
              backgroundColor: LightColor.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _authButton({
    required String label,
    required VoidCallback onTap,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? LightColor.orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child: Text(label.toUpperCase()),
      ),
    );
  }
}
