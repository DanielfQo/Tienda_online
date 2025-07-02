import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go(AppRoutes.home),
        ),
        elevation: 0,
        title: const Text(''),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: AppTheme.padding,
        child: Column(
          children: [
            // Foto de perfil
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage(
                'assets/images/avatar.png',
              ), // o NetworkImage()
            ),
            const SizedBox(height: 12),
            Text(
              isLoggedIn ? 'Rose Helbert' : 'Invitado',
              style: AppTheme.h1Style,
            ),
            const SizedBox(height: 20),

            // Fila de botones de acción
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: LightColor.background,
                boxShadow: AppTheme.shadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _profileAction(Icons.account_balance_wallet, 'Wallet'),
                  _profileAction(Icons.local_shipping, 'Shipped'),
                  _profileAction(Icons.credit_card, 'Payment'),
                  _profileAction(Icons.support_agent, 'Contact'),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Opciones del perfil
            _buildOption(
              icon: Icons.settings,
              title: "Settings",
              subtitle: "Privacy and logout",
              onTap: () {},
            ),
            _buildOption(
              icon: Icons.help_outline,
              title: "Help & Support",
              subtitle: "Help center and legal terms",
              onTap: () {},
            ),
            _buildOption(
              icon: Icons.question_answer_outlined,
              title: "FAQ",
              subtitle: "Questions and Answer",
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Botón de sesión
            isLoggedIn
                ? ElevatedButton.icon(
                    onPressed: () {
                      authProvider.logout();
                      context.go(AppRoutes.home);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Cerrar sesión'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: LightColor.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                : ElevatedButton.icon(
                    onPressed: () => context.go(AppRoutes.login),
                    icon: const Icon(Icons.login),
                    label: const Text('Iniciar sesión'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: LightColor.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // Barra inferior
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // navegación entre páginas si gustas
        },
      ),
    );
  }

  Widget _profileAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: LightColor.orange),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      leading: Icon(icon, color: LightColor.iconColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
    );
  }
}
