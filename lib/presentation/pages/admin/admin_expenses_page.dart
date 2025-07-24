import 'package:flutter/material.dart';

class AdminExpensesPage extends StatelessWidget {
  const AdminExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Gastos'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(child: Text('Contenido de administración de gastos')),
    );
  }
}
