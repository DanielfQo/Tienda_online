import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';


import '../providers/auth_provider.dart';
import '../../routes/app_routes.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  String? _error;

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final success = await authProvider.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passController.text,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
            content: Text("Registro exitoso. Ahora inicia sesión."),
            duration: Duration(seconds: 3),
            ),
        );
        context.go(AppRoutes.login);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? "Error al registrar"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // 👈 muestra loading
            : SingleChildScrollView( // 👈 muestra el formulario normal
                padding: AppTheme.padding,
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
                    _buildForm(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildForm() {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.person_add_alt_1, size: 80, color: Colors.orange),
          const SizedBox(height: 20),
          const Text('Crear cuenta', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Regístrate para comenzar', style: TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Nombre completo',
                  icon: Icons.person,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingrese su nombre' : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  label: 'Correo electrónico',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value == null || !value.contains('@') ? 'Correo inválido' : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passController,
                  label: 'Contraseña',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) =>
                      value != null && value.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _confirmPassController,
                  label: 'Confirmar contraseña',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) =>
                      value != _passController.text ? 'Las contraseñas no coinciden' : null,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Registrarse',
                  onPressed: _register,
                  icon: Icons.person_add,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
