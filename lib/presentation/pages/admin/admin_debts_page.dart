import 'package:flutter/material.dart';

class AdminDebtsPage extends StatelessWidget {
  const AdminDebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Deudas'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(child: Text('Contenido de administración de deudas')),
    );
  }
}
