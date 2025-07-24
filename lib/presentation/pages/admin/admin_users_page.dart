import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/light_color.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/admin_app_bar.dart';

class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> usuarios = [
      {
        'id': 1,
        'nombre': 'Andrea Paredes',
        'correo': 'andrea@correo.com',
        'rol': 'admin',
      },
      {
        'id': 2,
        'nombre': 'Luis Torres',
        'correo': 'luis@correo.com',
        'rol': 'client',
      },
      {
        'id': 3,
        'nombre': 'Camila Ríos',
        'correo': 'camila@correo.com',
        'rol': 'client',
      },
      {
        'id': 4,
        'nombre': 'Marco Díaz',
        'correo': 'marco@correo.com',
        'rol': 'admin',
      },
      {
        'id': 5,
        'nombre': 'Lucía Gutiérrez',
        'correo': 'lucia@correo.com',
        'rol': 'client',
      },
    ];

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      appBar: const AdminAppBar(
        title: 'Usuarios',
        returnRoute: AppRoutes.homeAdmin,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            final user = usuarios[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: LightColor.orange.withOpacity(0.2),
                  child: Text('${user['id']}'),
                ),
                title: Text(user['nombre']),
                subtitle: Text('${user['correo']} • Rol: ${user['rol']}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  //  editar rol del usuario
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColor.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          //  para crear usuario
        },
      ),
    );
  }
}
