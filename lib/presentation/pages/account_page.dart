import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../providers/user_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: userProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : user == null
            ? const Center(child: Text("No se pudo cargar el perfil"))
            : SingleChildScrollView(
                padding: AppTheme.padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Botón cerrar
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 28,
                          color: Colors.black,
                        ),
                        onPressed: () => context.go(AppRoutes.profile),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Center(
                      child: Text(
                        'EDITAR LA INFORMACIÓN DE PERFIL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Nombre
                    const Text('NOMBRE'),
                    const SizedBox(height: 4),
                    TextFormField(
                      initialValue: user.nombre,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text('FECHA DE NACIMIENTO'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildDateField(
                          user.fechaNacimiento?.day.toString().padLeft(
                                2,
                                '0',
                              ) ??
                              '',
                        ),
                        const SizedBox(width: 8),
                        _buildDateField(
                          user.fechaNacimiento?.month.toString().padLeft(
                                2,
                                '0',
                              ) ??
                              '',
                        ),
                        const SizedBox(width: 8),
                        _buildDateField(
                          user.fechaNacimiento?.year.toString() ?? '',
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text('CORREO ELECTRÓNICO'),
                    const SizedBox(height: 4),
                    TextFormField(
                      initialValue: user.correo,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.lock_outline),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text('CONTRASEÑA'),
                    const SizedBox(height: 4),
                    TextFormField(
                      obscureText: true,
                      initialValue: '********',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text('SEXO'),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildGenderOption(
                          'Masculino',
                          user.genero == 'Masculino',
                        ),
                        _buildGenderOption(
                          'Femenino',
                          user.genero == 'Femenino',
                        ),
                        _buildGenderOption('Otros', user.genero == 'Otros'),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  static Widget _buildDateField(String value) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        initialValue: value,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  static Widget _buildGenderOption(String label, bool selected) {
    return Expanded(
      child: RadioListTile(
        title: Text(label),
        value: label,
        groupValue: selected ? label : null,
        onChanged: (_) {},
        dense: true,
      ),
    );
  }
}
