import 'package:flutter/material.dart';

class AdminBranchesPage extends StatelessWidget {
  const AdminBranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Sedes'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(child: Text('Contenido de administración de sedes')),
    );
  }
}
