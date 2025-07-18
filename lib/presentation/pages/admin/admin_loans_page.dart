import 'package:flutter/material.dart';

class AdminLoansPage extends StatelessWidget {
  const AdminLoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Préstamos'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Contenido de administración de préstamos'),
      ),
    );
  }
}
