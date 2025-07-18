import 'package:flutter/material.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Contenido de administración de productos'),
      ),
    );
  }
}
