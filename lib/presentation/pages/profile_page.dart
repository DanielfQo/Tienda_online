import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import '../widgets/custom_button.dart';


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
              CustomButton(
                text: 'INICIA SESIÓN',
                background: const Color.fromARGB(255, 254, 201, 140),
                onPressed: () => context.go(AppRoutes.login),
                icon: Icons.login,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'REGÍSTRATE',
                onPressed: () => context.go(AppRoutes.register),
                icon: Icons.person_add,
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
          CustomButton(
            text: 'Cerrar sesión',
            onPressed: (){
              authProvider.logout();
              context.go(AppRoutes.home);
            },
            icon: Icons.logout,
          )

        ],
      ),
    );
  }

}
