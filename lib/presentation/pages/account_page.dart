import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppTheme.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Botón cerrar
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.black),
                  onPressed: () => context.go(AppRoutes.profile),
                ),
              ),
              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'EDITAR LA INFORMACIÓN DE PERFIL',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),

              /// Nombre
              const Text('NOMBRE'),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: 'Kevin Andre',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: 'Rodriguez Lima',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text('FECHA DE NACIMIENTO'),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildDateField('19'),
                  const SizedBox(width: 8),
                  _buildDateField('03'),
                  const SizedBox(width: 8),
                  _buildDateField('2005'),
                ],
              ),

              const SizedBox(height: 20),
              const Text('CORREO ELECTRÓNICO'),
              const SizedBox(height: 4),
              TextFormField(
                initialValue: 'kevinroli_jc@hotmail.com',
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
                  _buildGenderOption('Masculino', true),
                  _buildGenderOption('Femenino', false),
                  _buildGenderOption('Otros', false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String value) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        initialValue: value,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildGenderOption(String label, bool selected) {
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
