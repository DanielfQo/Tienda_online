import 'package:flutter/material.dart';

class AdminSalesPage extends StatelessWidget {
  const AdminSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Ventas'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(child: Text('Contenido de administración de ventas')),
    );
  }
}
