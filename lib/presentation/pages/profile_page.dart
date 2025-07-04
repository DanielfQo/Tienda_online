import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/profile_option_tile.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  'assets/images/background_profile.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.black),
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
      ),
    );
  }

  Widget _buildLoggedInView(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: AppTheme.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KEVIN ANDRE',
                style: AppTheme.h1Style.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.black,
                    ),
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Opciones
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                ProfileOptionTile(
                  icon: Icons.person_outline,
                  title: 'Mi cuenta',
                  subtitle: 'Datos y configuración',
                  onTap: () => context.go(AppRoutes.account),
                ),
                ProfileOptionTile(
                  icon: Icons.local_shipping_outlined,
                  title: 'Historial de pedidos',
                  subtitle: 'Tus pedidos anteriores y en curso',
                  onTap: () => context.go(AppRoutes.orderHistory),
                ),
                ProfileOptionTile(
                  icon: Icons.location_on_outlined,
                  title: 'Direcciones',
                  subtitle: 'Administra tus direcciones',
                  onTap: () => context.go(AppRoutes.addressBook),
                ),
                ProfileOptionTile(
                  icon: Icons.help_outline,
                  title: '¿Necesitas ayuda?',
                  subtitle: 'Soporte y preguntas frecuentes',
                  onTap: () {},
                ),
              ],
            ),
          ),

          // Botón de logout
          CustomButton(
            text: 'Cerrar sesión',
            onPressed: () {
              authProvider.logout();
              context.go(AppRoutes.home);
            },
            icon: Icons.logout,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
