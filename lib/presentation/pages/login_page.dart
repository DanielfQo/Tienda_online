import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../../core/theme/light_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  String? _error;

  void _login() {
    final username = _userController.text.trim();
    final password = _passController.text.trim();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.login(username, password);

    if (authProvider.isLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      setState(() {
        _error = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black, size: 28),
                  onPressed: () => context.go(AppRoutes.profile),
                ),
              ),
              const SizedBox(height: 10),

              // Contenido centrado
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 80,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Por favor, inicia sesión para continuar',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: _userController,
                      label: 'Usuario',
                      icon: Icons.person,
                      validator: (value) =>
                          value == null || !value.contains('@')
                          ? 'Correo inválido'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passController,
                      label: 'Contraseña',
                      icon: Icons.lock,
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'Ingresar',
                      onPressed: _login,
                      icon: Icons.login,
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => context.go(AppRoutes.register),
                      child: const Text(
                        '¿No tienes cuenta? Regístrate',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
